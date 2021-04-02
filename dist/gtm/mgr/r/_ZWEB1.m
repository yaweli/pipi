%ZWEB1	; ELI SMADAR (C) INTERFACE TO CGI FOR GTM
	;
	; NEW 2019
	; http://127.0.0.1/cgi-bin/EsGtm?PPP=1000&NEXT=1
	S ERR="",DEV="WEB",MOD="DEF"
	R A:4 E  W "TIME OUT , BYE" Q
	I A'="==DL1==" W "MISSING DL1, BYE" Q
	F F=1:1:1000 R A Q:A="==DL2=="  D
	.I A'["=" Q
	.S VAR=$P(A,"=",1),VAL=$P(A,"=",2,999) Q:VAR=""
	.I VAL?1"'".E1"'" S VAL=$E(VAL,2,$L(VAL)-1)
	.S %SH(VAR)=VAL
	I F>999 W "ERROR MISSING DL2, BYE" Q
	;ZWR %SH
	;  %SH("QUERY_STRING")
	;  %SH("QUERY_STRING")="aaa=4000&BBB=XYZ"
	S IP=$G(%SH("REMOTE_ADDR"))
	D GET(%SH("QUERY_STRING"))
	;ZWR %PAR
	i $d(%PAR("PPP")) K JB K %SH("HTTP_COOKIE") ; START FROM SCRATCH , FORGET COOKIES 
	;
	K ^W($J_"P")
	F F=1:1 R A:0 Q:'$T  Q:A="==DL3=="  D
	.S ^W($J_"P",F)=Appp
	;ZWR ^W($J_"P",*)
	D JB I ERR'="" W !,"ERR: "_ERR Q
	D ENVGET
	D ENEXT   I ERR'="" W !,"ERR:"_ERR Q
	D RUN
	D ENVSAV
	K ^W($J_"P")
	H 0
	Q
RUN	;
	S $ET=" W !,""run er=""_$ZS S ^%ELI=$ZS Q"
	D DO^%ZU(U,P)
	Q
ENVGET ;
	I '$D(JB) Q
	N I S I="" F  S I=$O(^W(JB,"EMV",I)) Q:I=""  M @I=^(I)
	Q
ENVSAV	;
	S ^%ELI="SAV1"
	I '$D(JB) Q
	S ^%ELI="SAV2:"_$g(JB)_":"_$G(SUBMITN)_":)"
	K ^W(JB,"ENV")
	N ERR,U,P,T S T=""
	N I S I="a" F K=1:1 S I=$O(@I) Q:I=""  I I'["%",I'="I",I'="JB" M ^W(JB,"ENV",I)=@I S T=T_","_I
	S ^%ELI="SAV3:"_$D(SUBMITN)_":"_K_":"_JB_":"_$d(^W(JB,"ENV","SUBMITN"))_":"_T
	ZWR 
	Q
COOK(A) ;
	;%SH("HTTP_COOKIE")="klara=dutsTGbWzkICBbiHWJSY"
	S JB=$P(A,"=",2)
	Q
JB	;
	;%SH("HTTP_COOKIE")="klara=dutsTGbWzkICBbiHWJSY"
	I $D(%SH("HTTP_COOKIE")) D COOK(%SH("HTTP_COOKIE")) Q
	I '$D(%PAR("PPP")) S ERR="MISSING PPP" Q
	S PROJ=%PAR("PPP")
	S A=^%ZES("P",PROJ)
	S U=$P(A,"_",1)
	S P=$P(A,"_",2)
	S MOD="INIT"
	Q
GET(%A) ;
	N VAR,VAL,F
	F F=1:1:$L(%A,"&") D GET1($P(%A,"&",F))
	Q
GET1(%A) ;
	S VAR=$P(%A,"=",1) Q:VAR=""
	S VAL=$P(%A,"=",2)
	S %PAR(VAR)=VAL
	Q
DEMO	;
	S ^%ZES("P",1000)="ELI_^START"
	Q
NEXT(RUT) ;
	S SUBMITN=$$UCI^%ZU_"_"_RUT
	Q
ENEXT	;
	W 111
	I $G(%PAR("mod"))="klara"  	I '$D(SUBMITN) S ERR="^START MUST GIVE NEXT PROG B D NEXT^%ZWEB1()" Q
	W 2222_" *"_$G(%PAR("mod"))_"* "
	I '$D(SUBMITN)  Q
	W 3333
	S U=$P(SUBMITN,"_",1)
	S P=$P(SUBMITN,"_",2)
	Q
