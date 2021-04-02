%ESWSE	; E.S. CGI ENTRY - TO MUMPS - FOR TOM2000found
	; new ver 2019 forr gtm
	; URL=http://host/cgi-bin/Es
	;
	;
	S $et="w $zs g ^%ESET"
	D INIT
	I $D(Id) D LOAD Q:$L(ERR)
	I '$L($G(%RUT)) D ERR3 Q
	D FIXHEB
	D NEWID
	D HTML
	D HEAD1,META,BOOTS,HEAD2
	D DOC
	D DO
	D SAVE1
	D BOOTSE
	Q
INIT	;
	S D="_" K %DONE
	M %VR=VR
	;D DD^%ESLIB("%VR")
	I $G(%VR("Referer"))?1"..".e s %VR("Referer")="http://"_%VR("Referer")
	S %REF=$P($G(%VR("Referer")),"/",4,999)
	S %REF=$E(%REF,1,100)
	;S %REF=$ZCVT(%REF,"U") ;Upper case
	S %REF=$$CAPS^%ESS(%REF) ;Upper case
	D INITLEV^%ESLIB
	I %REF="",$G(QUERY)["ajmode=1" G SKIP
	I %REF="",$D(^%ESV(2,"DEF")) S %REF=^("DEF")
	I $L(%REF) D
	.I $L($G(^%ESV(2,"INTERNET",%REF))) D
	..S %RUT=@$R
	I $G(%RUT)="",%REF["?" D
	.S %REF1=$P(%REF,"?",1) Q:%REF1=""
	.I $L($G(^%ESV(2,"I?",%REF1))) D
	..S %RUT=@$ZR
	I $L(%REF) I $G(%RUT)="" I %REF?1"PROJ/".E S %RUT="^%ESDEV0" ; DEFAULT
SKIP	;
	D PARK(QUERY)
	Q
PARK0	; FOR VARS WITH "_" AS DELIMITER -> TO GLOBAL
	I $D(%PARK0) Q
	S %PARK0=1
	D GLOAD("JB") ;-> JB
	K ^W(JB,"V")
	S %GVAR="^[""INT""]W(JB,""V"")" ; S I=$O(@%GVAR@("FL",I))
	Q
PARK(ARG) ;
	N %PARK0 K %DONTS,%PARK
	N G,A,B,C,H,%G,A0 S %G=""""
	F G=1:1 S C=$P(ARG,"&",G) Q:C=""  D
	.S A=$P(C,"=",1)
	.I A="" Q
	.I A?1"?".E S A=$E(A,2,999)
	.S B=$P(C,"=",2,99)
	.I B["%" S A0=A,B=$$CONV(B) ;%AB->LETER
	.S H=$P(A,"-",1)
	.;S B=$$HEB(B)
	.I H?.N S H="r"_H
	.I H["." D
	..I $L(H,".")>2 X "S %VR(""A"",$P(H,""."",1),$P(H,""."",2,999))=0"
	..S H=$P(H,".",1)_"("_%G_$P(H,".",2,999)_%G_")"
	.I H[D D
	..D PARK0
	..S H="^W(JB,"_%G_"V"_%G_","_%G_$P(H,D,1)_%G_","_%G_$P(H,D,2)_%G_")" ; 
	.I H="" Q
	.I H?1"'".E S H=$E(H,2,99999)
	.I B?.E1"'" S B=$E(B,0,$L(B)-1)
	.S @H=B
	.S %DONTS($P(H,"(",1))="" ;DONT SAVE FLAG
	.S %PARK(H)=B
	Q
FIXHEB	;
	N I,V S I=""
	F  S I=$O(%PARK(I)) Q:I=""  D
	.S V=%PARK(I) I I["EEE" Q
	.I I'="itmVal" S V=$$HEB(V) ; Add 10/12/2020 e.s.
	.S @I=V
	Q  ;                 vvvv -> 4 digit unicode
v2CONV(A)	; XYZ -> XYZ  xy%0026z -> xy&z
	N B,G,E
	S B=""
	F G=1:1:$L(A) S E=$E(A,G) D:E="%"  S B=B_E
	.I $E(A,G+1,G+4)="" Q
	.;S E=$C($ZH($E(A,G+1,G+2))) ; CACHE
	.S E=$C($$HEX2DEC^%ESS($E(A,G+1,G+4)))
	.I E=$C(10) S E="\n"
	.S G=G+4
	.;S E=$C($$HEX2DEC^%ESS($E(A,G+1,G+2)))
	.;S G=G+2
	Q B
C(N) ; UNICODE $C
	I N>1487,N<1515 Q $E("אבגדהוזחטיךכלםמןנסעףפץצקרשת",N-1487)
	Q
CONV(A) ; convert %abcd -> char using linux echo -n $'\uabcd' , new e.s. 5.3.2020
	;             %05d0"%05d1   
	N AA,X,C,S4 S A0=$G(A0)
	;
	S S4=2
	I A0="itmVal" S S4=4
	I A'["%" Q A
	I A["%000a" S A=$$REP^%ESS(A,"%000a","\n")
	I A'["%" Q A
	S AA=""
	F X=1:1:$L(A) D
	.S C=$E(A,X)
	.I C="'"  S AA=AA_"\'"  Q
	.I C="""" S AA=AA_"\""" Q
	.I C="(" S AA=AA_"\(" Q
	.I C=")" S AA=AA_"\)" Q
	.I C'="%" S AA=AA_C Q
	.I $E(A,X+3)="%" S AA=AA_"$'\u"_$E(A,X+1,X+2)_"'" S X=X+2 Q  ; %22 = " two char utf
	.;S AA=AA_"$'\u"_$E(A,X+1,X+S4)_"'" S X=X+S4 ; %05ea ; 4 char unicode
	.S AA=AA_"\U"_$E(A,X+1,X+S4) S X=X+S4 ; %05ea ; 4 char unicode ; UBUNTU
	;
	;
	;S AA=$$EVAL^%ESF("/usr/bin/echo -n "_AA) ; EVAL INSTEAD OF $$PIPE^%ESF() SINCE STRING IS VERY VERY LONG
	S AA=$TR(AA,"+"," ")
	S AA=$$EV^%ESF("echo -en """_AA_"""") ; New (ubuntu too) ; ubuntu /echo -en "\U05ea"
	;
	; +:
	; itmVal=%05d0+%05d0
	; itmVal=%05d0%002b%05d0
	; \U000a\U000c
	Q AA
LOAD	;
	S ERR=""
	I Id="" D ERR1 Q
	I '$D(^ID(0,Id)) D ERR2 Q
	I $D(%RUT) N %RUT
	D LOAD1
	I $L($G(SId)) D INIT2 N %SGLO S %SGLO=%SSGLO D LOAD2
	Q
LOAD1	;  glo -> env
	N SId,ERR
	D INIT1
LOAD2	;
	N I S I=""
	F  S I=$O(@%SGLO@(I)) Q:I=""  M @I=^(I)
	Q
INIT1	;
	S %SGLO="^%ESV(9,Id,""A"")"
	Q
INIT2	;
	S %SSGLO="^%ESV(9,Id,""S"",SId)"
	Q
GLOAD(VAR) ;
	N %SGLO D INIT1
	I $D(@%SGLO@(VAR)) M @VAR=^(VAR)
	Q
SAVE1	; env -> glo
	; Only non % vars are kept
	;
	N SId,ERR
	D INIT1
	N I S I="A"
	F  S I=$O(@I) Q:I=""  I I'="Id",I'="I",'$D(%DONTS(I)) M @%SGLO@(I)=@I
	D SAV("%RUT")
	D SAV("%LNG")
	D SAV("%DLG")
	D SAV("%GEN")
	S @%SGLO=$H_D
	K %AJAXS
	Q
NEWID	; -> Id
	I $D(ajmode) Q
	N LEN,F,T,A,C,I,FL
	I '$D(^CURRENT("ID","ST")) D
	.S ^CURRENT("ID","F")=65
	.S ^CURRENT("ID","LEN")=28
	.S ^CURRENT("ID","ST")="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	.S ^CURRENT("ID","T")=87
	.I '$D(^T("G","NAME")) S ^("NAME")="ZMANI"
	S F=^CURRENT("ID","ST")
	S LEN=^("LEN")
	S FL=$L(F)
	S A="" F I=1:1:LEN D
	.S C=$R(FL)
	.S C=$E(F,C+1)
	.S A=A_C
	S Id=A
	S ^ID(0,Id)=$H
	Q
ERR1	;
	S ERR=1
	W !,"Wrong access to "_^CURRENT("NAME")
	I $D(^CURRENT("LOGOUT")) X ^("LOGOUT")
	Q
ERR2	;
	S ERR=2
	W !,"Wrong access to "_^CURRENT("NAME")_"."
	W "<BR>*"_$g(Id)_"*"_$$UCI^%ESV
	I $D(^CURRENT("LOGOUT")) X ^("LOGOUT")
	Q
ERR3	;
	I '$d(^CURRENT("NAME")) S ^("NAME")="My company/ "_$NA(^("NAME"))
	S ERR=3
	W !,"Wrong access to "_^CURRENT("NAME")_".. ("_%REF_") project not define"
	I $D(^CURRENT("LOGOUT")) X ^("LOGOUT")
	Q
SUBSAV(VAR) ;
	D INIT2
	M @%SSGLO@(VAR)=@VAR
	Q
SAV(VAR) ;
	I '$D(@VAR) Q
	D INIT1
	M @%SGLO@(VAR)=@VAR
	Q
KIL(VAR) ;
	D INIT1
	K @%SGLO@(VAR)
	Q
HEAD1	;
	I $D(ajmode) Q
	;W "<HEAD>",!
	Q
META	;
	I $D(ajmode) Q
	I $D(metaU)!$d(Umode) D  Q
	.W " <meta http-equiv=""Content-Type"" content=""text/html; charset=UTF-8"">",!
	I $D(metaW) D  Q
	.W " <meta http-equiv=""Content-Type"" content=""text/html; charset=windows-1255"">",!
	I $D(%RUT),$D(^CURRENT("G.NO","X"_$P(%RUT,"^",2))) Q
	I $D(^CURRENT("G","HEB-META")) D  Q
	.W " <meta http-equiv=""X-UA-Compatible"" content=""IE=7"" />",!
	.W " <meta http-equiv=""Content-Type"" content=""text/html; charset=ISO-8859-8"">",!
	Q
HEAD2	;
	I $D(ajmode) Q
	I $D(Umode) Q
	;W "</HEAD>",!
	Q
BOOTS	;
	I '$D(^CURRENT("LOOK")) Q
	W "<meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">",!
	W "<link href=""/cust/bootstrap/css/bootstrap.min.css"" rel=""stylesheet"" media=""screen"">",!
	W "<link href=""/cust/bootstrap/css/bootstrap-responsive.min.css"" rel=""stylesheet"">",!
	Q
BOOTSE	;
	I '$D(^CURRENT("LOOK")) Q
	W !,"<script src=""/cust/jq/jquery-latest.min.js""></script>"
	W !,"<script src=""/cust/bootstrap/js/bootstrap.min.js""></script>"
	Q
DOC	;
	;I '$D(ajmode) D REM^%ESLIB("PROG="_%RUT)
	S %RUT1=%RUT K %RUT
	Q
SET(RUT) S %RUT=RUT Q
HEB(A)	;
	N B S B=""
	S B=$TR(A,"+"," ")
	S B=$$CL^%ESS(B)
	Q B
	; REMOVED E.S. 2.2.2020
	N DLT S DLT=0
	I $D(%DLG),$D(%LNG),%LNG=1,%DLG=7 S DLT=128
	S B=$$RWINH(B,DLT)
	S B=$$CUTLT^%ESS(B)
	F  Q:B'["  "  S B=$$REP^%ESS(B,"  "," ")
	Q B
RWINH(S,DL) ;
	N A,H,Q,C,D,B,SP,I,A1
	I $L($G(DL))=0 S DL=128
	;S H="`abcdefghijklmnopqrstuvwxyz"
	S H="" F I=224:1:250 S H=H_$C(I)
	S Q="()[]{}<>"
	S B="-.,;+$"
	S A="",A1="",D=1
	F I=$L(S):-1:1 D
	.S C=$E(S,I)
	.S C=$TR(C,"()[]{}<>",")(][}{><")
	.I B[C S A1=$S(D:A1_C,1:C_A1) Q
	.I H_Q[C D  Q
	..S:H[C C=$C($A(C)-DL)
	..I D S A1=A1_C Q
	..D WCD
	.I D D WCD Q
	.I C=" " S A1=" "_A1_" "
	.S A1=C_A1
	S A=A_A1
	Q A
WCD	S SP=""
	S A=A_A1_SP,A1=C,D='D
	Q
TOP	;
	D X("TOP")
	Q
BOT	;
	D X("BOT")
	Q
TOPJOB	;
	I $D(JB),$D(^W("00",JB)) D KILJ(^(JB))
	I $D(JB) S ^W("00",JB)=$J
	Q
BOTJOB	;
	I $L($G(JB)) K ^W("00",JB)
	Q
X(W)	;
	I $D(%DONE(W)) Q
	I $D(%DONT(W)) Q
	I $D(%RUT1),$D(%GEN("NIT",%RUT1)) Q
	S %DONE(W)=1
	I $D(%GEN(W)) D
	.N I S I=""
	.F  S I=$O(%GEN(W,I)) Q:I=""  X %GEN(W,I)
	Q
ADD(W,X) ;
	N RUN S RUN=1+$ZP(%GEN(W,"")),%GEN(W,RUN)=X
	Q
DONT(W)	S %DONT(W)=1 Q
HTML	;
	;I $D(ajmode) Q
	;I $G(QUERY)'["metaUH5"!($g(Umode)["H5") W "<!DOCTYPE html>",!
	;W "<HTML>",!
	Q
DO	;
	I '$D(ajmode) D TOPJOB,TOP
	D DO1
	I '$D(ajmode) D BOT,BOTJOB
	Q
DO1	;
	I '$D(REDUCI) D @%RUT1 Q
	I $D(REDUCI) D DOPROG^%ESS(%RUT1,REDUCI) Q
	Q
KILJ(J)	Q  ;D KILJ^%ESV(J) Q
NIT(RUT) ;
	S %GEN("NIT",RUT)=1
	D SAV("%GEN")
	Q
VER() Q "2.07" ;system wide "space" "+" solution
	;Q "2.06" ;Ubuntu too , hebrew
    ;Q "2.05" ;dont lost my + HEB()
    ;Q "2.04" ; conv() using 4 digits only for var name itmVal
	;Q "2.03" ; conv() using linux echo command , support 2 and 4 digits
	;Q "2.03" ; conv() using linux echo command
	;Q "2.02"
