%ESC	;
	Q
READCSV(F,X,DL,TIT,OPT,OPTF,COND) ;
	;/**
	; * Read csv file and call your label per line
	; * each line contain V() vector with the line data
	; * V() line data is in this format: V("Head")=value
	; * the "Head" is taken from the header of the CSV file (first line in the file)
	; * if the header have no content , you have B string
	; * with the line content col1_col2_col3_..
	; * I= line number 2,3,4..  (1 is header)
	; * example: D READCSV(F,"D CN1^JXC155T","|")
	; *  F = can be url , ex: https://domain.com/aaa.csv
	; * 
	; * @param DL - alternate delimiter (_ is default)
	; * @param TIT - alternate title
	; * @param OPT = CLN all titles clean out of blank 
	; *        OPT = LIN1 - also include line 1 , no title so line 1 also valid
	; *        OPT = CACHE - if global exist , don't load newone , use the old one 
	; * @param OPTF = Open file options , LIMIT=2000 to limit the line length 
	; * @param COND exe mumps after load file
	; **/
	N H,A,I,B,V,RM
	S ERR="",OPT=$G(OPT),OPTF=$G(OPTF)
	N GLO S GLO=$NA(^W($J,"KCSV"))
	K @GLO
	D HTTP
	D RR 
	K @GLO
	Q
RR  ;
	I OPT["NOGET" G RR1
	I '$D(@GLO),OPTF'="" D G^%ESF(F,GLO,OPTF) I ERR'="" Q
	I '$D(@GLO),OPTF=""  D G^%ESF(F,GLO)      I ERR'="" Q
RR1	;
	S H=$TR($G(@GLO@(1)),$C(13,0)_"""") I H="" S ERR="Empty file "_F Q
	I $D(COND) N SKIP X COND I $D(SKIP) Q
	I $L($G(TIT)) S H=TIT I H[D S H=$TR(H,D,DL)
	I H[$C(239) S H=$TR(H,$C(239,187,191))
	I H[$C(255) S H=$TR(H,$C(255))
	I H[$C(254) S H=$TR(H,$C(254))
	;I OPT["CLN" D
	;.N K F K=1:1:$L(H,DL) S $P(H,DL,K)=$$CL^%ZCAVS($P(H,DL,K))
	;
	S I=1 I OPT["LIN1" S I=""
	F  S I=$O(@GLO@(I)) Q:I=""  S A=$TR(^(I),$C(13,0)),B=$$CSV2D(A,DL,"","",H) X X
	Q
CSV2D(A,P,ADDM,DTO,H) ; "STRING","STRING 2 , TEXT",123 -> "STRING_STRING 2 , TEXT_123"
	; /**
	;  * Convert single line CSV format string with commas 
	;  * to underline delimited string
	;  * 
	;  * @param A source CSV format string from excell
	;  * @param P optional delimiter (default ,)
	;  * @param ADDM optional =1 if you want the " to stay around the string
	;  * @param ADDM optional =2 if you want the " to leave single " in
	;  *        case original string inclue "" double quote
	;  * @param DTO optional = char that will replace the _ if exsit 
	;  *        default is "-" (minus)
	;  * @param H="name_phone_address_city" - if H exist than the values will be return into V() ??
	;  *        V("name")=pic1   V("phone")=pic2    V("address")=pic3    V("city")=pic4 
	;  */
	; 
	N B,M,F,C
	S P=$G(P) I P="" S P=","
	I $G(DTO)="" S DTO="-"
	S A=$TR(A,"_",DTO)
	S B="",M=0 I $L($G(H)) K V S H=$TR(H,D," "),H=$TR(H,P,D)
	F F=1:1:$L(A) D
	.S C=$E(A,F)
	.I M=0,C="""" S M=1 S:$G(ADDM)=1 B=B_C Q
	.I M=0,C=P S B=B_"_" Q
	.I M=0 S B=B_C Q
	.I M=1,C="""" S M=0 S:$G(ADDM)=1 B=B_C S:$G(ADDM)=2&($E(A,F+1)=C) B=B_C Q
	.I M=1,C="_" S B=B_"*" Q
	.I M=1 S B=B_C
	I $L($G(H)) F F=1:1:$L(H) I $L($P(H,D,F)) S V($P(H,D,F))=$P(B,D,F)
	Q B
HTTP ;
	I F'?1"http"1e1":".e Q
	N U S U=F N F S F="/tmp/cs"_JB_".csv"
	S RM=F
	D CG^%ESF("curl -s """_U_"""",GLO)
	S OPT=OPT_"/NOGET"
	D RM^%ESF(F) S ERR=""
	Q