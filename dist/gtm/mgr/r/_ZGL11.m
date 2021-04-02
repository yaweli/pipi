%ZGL11	;
%G1	;GLOBAL READ @SMB@ ; 10 Jun 92   3:39 PM
1	S %DIR=0 D R K %DIR G KQ
R	K % W !,"Dlobal ^" 
	D READ
	;R %
	W !
	Q:"^"[%  I %="?" D GD G R
	S QQ=", probably forgot quotes in subscript."
	I %="*D"!(%="??")!(%="?") X "N  D ^%GD" G R ;;;D GETDIR,DIS G R
	I %?1"?"1A.NA!(%?1"?%".NA) D GETDIR,DISP G R
	S %WRT=1 D GO G R:%ER D GETDIR:%GD Q
GO	S %("M")=-1,(%("C"),%("P"))=0,%("D")=1,(%P,%CP,%GD,%L,%ER)=0 W:%WRT ?8
GN	D NM I $E(%N,2)'="%",$E(%N,2)'="[",$E(%N,2)'?.A,%N'="^ " G ER2
	G GN:%C=" "
L	G P1:")"[%C,ER:"(,"'[%C S %L=%L+1,%("P")=%L,%P=0
P	S %P=%P+1 Q:$E(%,%CP+1)=""  S %("C")=%L D E,SET Q:%ER
	I %C=":" S %(%L,%P)=$C(127) D E S:%O]"" @("%(%L,%P)="_%O)
	I %C=":" D E S:%O]"" %(%L,%P,"C")=%O
	G P:%C=" ",L:")"'[%C
P1	Q:%C=""  G ER:$E(%,%CP+1)]"" S %("M")=%L,%("D")=0 Q
E	S %F=%CP+1,%PR=0
E1	D N I %PR=0!(%C="")," ),:"[%C S %O=$E(%,%F,%CP-1) Q
	I "()"[%C S %PR=%PR+$S(%C="(":1,1:-1) G E1
	G E1:%C'=""""
F	D N G E1:""""[%C,F
N	S %CP=%CP+1,%C=$E(%,%CP) W:%WRT %C Q
NM	;
	I $E(%)="(" S %4N=$E($ZR,2,999) S:$E(%4N,$L(%4N))=")" %4N=$E(%4N,1,$L(%4N)-1) S %=%4N_$E(%,2,999) K %4N
	I $E(%)="@" S %4N=@$P(%,"@",2),%=$S($E(%4N,$L(%4N))'=")":%4N_$P(%,"@",3,999),1:$E(%4N,1,$L(%4N)-1)_$S($P(%,"@",3,999)="":"",1:","_$E($P(%,"@",3,999),2,999)))
	D N0 S %P=%P+1,%(0,%P,"S")=%N
	I %C="*" S %(0,%P)=%N_"zzzzzzzz",%GD=1 D N Q
	I %C'=":",%C'="-" S %(0,%P)=%N Q
	S %GD=1 D N0 I %N="" S %(0,%P)="zzzzzzzzz" Q
	S %(0,%P)=%N Q
N0	D UP S %N="^" I %C="%" S %N="^%" D N
N1	I %C?1AN!(%C="%") S %N=%N_%C D N G N1
	I %C="("!(%C'="[") D  Q
	.S %Z=%N_"("""")",%Z=$Q(@%Z)
	.I $E(%Z,2)="[",$E(%N,2)'="[" S %N=$E(%Z,1,$F(%Z,"]")-1)_$E(%N,2,$L(%N))
	I $F(%,"]")=0 Q
	S %A=$E(%,$F(%,"["),$F(%,"]")-2)
	S %A1=$P(%A,","),%A2=$P(%A,",",2)
	I %A1?1A.NA,$L(%A1)'>8,$E(@%A1) S %A1=""""_@%A1_""""
	I %A2?1A.NA,$L(%A2)'>8,$D(@%A2) S %A2=""""_@%A2_""""
	S %A="["_%A1 S:%A2'="" %A=%A_","_%A2 S %A=%A_"]",%N=%N_%A
	S %CP=%CP+$F(%,"]")-2 W:%WRT $E(%A,2,255) D N G N1
	Q
UP	D N G UP:%C="^" Q
ER	S %ER=1 W:%WRT " ?",*7 Q
ER2	W " - Global name must begin with alphabetic or ""%""",*7 S %ER=2 Q
KQ	K %C,%CP,%ER,%F,%GD,%L,%N,%O,%P,%PR,%WRT,%IEX
	I %="" S %G=""
	Q
DIS	S %N="" F %I=1:1 S %N=$O(^UTILITY($J,0,%N)) Q:%N=""  W:%I#8=1 ! W ?%I-1#8*10,%N
	K %I,%N Q
DISP	S %N="^"_$E(%,2,$L(%)-1)_$C($A(%,$L(%))-1)_"z",%S="^"_$E(%,2,99)
	F %I=1:1 S %N=$O(^UTILITY($J,0,%N)) Q:$E(%N,1,$L(%S))'=%S  W:%I#8=1 ! W ?%I-1#8*10,%N
	K %I,%N,%S Q
GETDIR	Q:%DIR  S %GZE=$ZT,$ZT="TRAP^%ZGL1" O 63::1 G GET:$T W " <View buffer wait>" O 63
GET	K ^UTILITY($J,0)
	I %["[" D
	.S %ALTUCI=$P($P(%,"]",1),"[",2)
	.S @("%UCI=$ZU("_%ALTUCI_")"),%ALTUCI="["_%ALTUCI_"]"
	.S %SN=$P(%UCI,",",2),%UCI=$P(%UCI,",")
	.S %=$P(%,"]",2,$L(%))
	E  S %UCI=$P($ZU(""),","),%SN=$P($ZU(""),",",2),%ALTUCI=""
	S %STB=$V(44)
	S %MM=$V(%SN*($V(%STB+34)#256)+$V(%STB+12)+2)
	S %BLK=$V(%UCI-1*20+4,%MM)#256*65536+$V(%UCI-1*20+2,%MM)
	S %VS="S"_%SN
	S %CT=0
%VIEW	V %BLK:%VS
	S %END=$V(1022,0),%NAM="",%PT=0
%NXT	G %PTR:%END'>%PT
%C	S %A=$V(%PT,0)#256,%PT=%PT+1,%NAM=%NAM_$C(%A\2) G %C:%A#2
	S ^UTILITY($J,0,"^"_%ALTUCI_%NAM)=""
	S %CT=%CT+1,%PT=%PT+8,%NAM="" G %NXT
%PTR	S %BLK=$V(1016,0)#256*65536+$V(1014,0) I %BLK G %VIEW
%PTR1	C 63 K %A,%ALTUCI,%CT,%NAM,%PT,%BLK,%END,%GZE,%LST,%STB,%UCI,%UCN,%UCIN S %DIR=1 Q
TRAP	U 0 W !,$ZE G %PTR1
SET	;S $ZT="TRAP1^%ZGL1"
	I $$ZV^%ZCAVV="MVX" S $ZT="TRAP1^%ZGL1"
	I $$ZV^%ZCAVV="GTM" N $ET S $ET="G %ERG^%ZGL"
	S %(%L,%P)=$C(127) S:%O]"" @("%O="_%O),%(%L,%P)=%O S %(%L,%P,"S")=%O Q
TRAP1	U 0 I $ZE["UNDEF" W !!,*7,"Global undefined",QQ,!! D KQ
	E  I $ZE["SYNTX" W !!,*7,"Syntax error",QQ,!! D KQ
	E  I $ZE["INRPT" W !,$ZE,! D KQ
	E  W !,$ZE,!
	S %ER=1 Q
TRAPG	;
	S $EC=""
	W !,$ZS,!
	S %ER=1
	Q
GTO	D R G KQ
INT	S %DIR=0 D INT1 K %DIR Q
INT1	S %P=% K % S %=%P,%WRT=0 D GO I %ER K % S %="" G KQ
	D GETDIR:%GD G KQ
GD	;
	I $$ZV^%ZCAVV="MVX" D INT^%GD Q
	D ^%GD
	Q
READ	;
	N RING,X,C,E,CC,PO,US,MD,ZV S US=$$USER^%ZCAVV,ZV=$$ZV^%ZCAVV,RING=0
	I ZV="GTM" D NOECHO^%ZCAVU,ESC^%ZCAVU W *27,"[?7l" U 0:WIDTH=0
	S %="",E=0,X=0,MD="I"
	F  R *CC S C=$C(CC) D READ1 Q:E
	I ZV="GTM" D ECHO^%ZCAVU
	D SAVE
	Q
READ1	;
	I CC'=9 S RING=0
	I CC=13 S E=1 Q
	I CC=10 S E=1 Q
	I C=""  S E=1 Q
	I CC=8   D BS Q
	I CC=127 D BS Q
	I CC=9  D TAB  Q
	I CC=27 D ARRW Q
	I CC=21 S %="" D SHOW Q  ;^U
	S X=X+1
	I $L(%)+1=X S $E(%,X)=C W:ZV="GTM" C Q
	I MD="I" S %=$E(%,0,X-1)_C_$E(%,X,$L(%))
	D SHOW1(X)
	Q
BS	;
	I X=0 Q
	S $E(%,X)=""
	D
	.I $L(%)+1=X W *8," ",*8 Q
	.D SHOW1(X-1)
	S X=X-1
	Q
TAB	; ^QWEB("ER","ON.103","AB
	I %'["(" D FULLG Q
	I %?.E1")" D SHOW W *7 Q  ;ALREAD FULL
	N GLO0,GLL,GLP,L,GL,N,GLLV,Q
	S GL0=$P(%,"(",1) ;QWEB
	S GLP=$P(%,"(",2,999) ;"ER","ON.103","AB
	S GLL="" I $L(GLP) D
	.S L=$L(GLP,",")
	.S GLL=$P(GLP,",",L) ; "AB
	.S GLP=$P(GLP,",",0,L-1) ;"ER","ON.103"
	I $L(GLL),GLL?1"""".E,GLL'?.E1"""" S GLL=GLL_""""
	S GLLV="" I $L(GLL) D GLL
	S GL="^"_GL0
	I $L(GLP) S GL=GL_"("_GLP_")"
	;GLP="ER","ON.103"
	;GL=^QWEB("ER","ON.103")
	;W !,"GLLV="_GLLV,!!
	S N=GLLV I $L(GLLV),'$D(@GL@(GLLV)) S N=$O(@GL@(GLLV))
	I GLLV="" S N=$O(@GL@(GLLV))
	S L=$L(GLLV)
	I $E(N,0,L)'=GLLV W *7 S N=GLLV D LIST
	S Q="""" I N?.N.".".N S Q=""
	S %=GL0_"("
	I $L(GLP) S %=%_GLP_","
	S %=%_Q_N_Q D SHOW
	Q
GLL	;
	N $ET S $ET="D GLLE^%ZGL1"
	S GLLV=""
	X "S GLLV="_GLL ; AB
GLLE	;
	S $EC=""
	Q
FULLG	; ^QWE -> ^QWEB ;T.B.C
	S GLIST=$NA(^WW($J,8)) I '$D(@GLIST) D GLIST
	I $D(@GLIST@("^"_%)) D  Q
	.S %=%_"("
	.D SHOW
	S N=$O(@GLIST@("^"_%))
	S N=$E(N,2,99)
	I $E(N,1,$L(%))'=% D  Q
	.D SHOW W *7
	S %=N_"("
	D SHOW
	Q
KILL	;
	S GLIST=$NA(^WW($J,8)) K @GLIST
	Q
GLIST	;
	K @GLIST
	D GLOLIST^%ZCAVL6("*",GLIST)
	D GLOLIST^%ZCAVL6("%*",GLIST,$$MGR^%ZCAVV)
	Q
SHOW1(X) ;
	N G S G=X
	D SHOW
	W *13
	W "Global ^",$E(%,0,G)
	Q
LIST	;
	S RING=RING+1 I RING<3 Q
	N M,I S N=$E(N,0,$L(N)-1),I=N
	F M=1:1:10 S I=$O(@GL@(I)) Q:I=""  Q:$E(I,0,$L(N))'=N  W !,$NA(^(I))
	I M>9 W !,"There is more..."
	W ! D SHOW
	Q
SHOW	;
	W *13
	W "Global ^",%,*27,"[K" S X=$L(%)
	Q
ARRW	;
	N KEY
	S KEY=$E($ZB,2,99)
	I KEY="[A" D UPUP,SHOW Q
	I KEY="[B" D DOWN,SHOW Q
	I KEY="[D" D LEFT Q
	I KEY="[C" D RIGH Q
	Q
LEFT	;
	Q:X=0
	W *8
	S X=X-1
	Q
RIGH	;
	I X=$L(%) Q
	W $E(%,X+1)
	S X=X+1
	Q
UPUP	;
	S PO=$G(PO)
	S PO=$ZP(^mcav("gl",US,PO))
	S %="" I $L(PO) S %=^(PO)
	Q
DOWN	;
	S PO=$G(PO)
	S PO=$O(^mcav("gl",US,PO))
	S %="" I $L(PO) S %=^(PO)
	Q
SAVE	;
	I %="" Q
	N RUN S RUN=1+$ZP(^mcav("gl",US,""))
	I %=$G(^(RUN-1)) Q
	S ^(RUN)=%
	Q
