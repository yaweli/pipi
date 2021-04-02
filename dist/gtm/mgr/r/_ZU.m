%ZU	; CHANGE UCI 
	; (C) ELI SMADAR GTM
	D START
	W !,$ZV," JOB "_$J_" : "_$$CUST^%ZU
G	R !,"UCI : ",U Q:U=""
	I U="?" D LIST G G
	I $D(^%ZUCI(U))	D GOUCI(U),DIS Q
	W " NO such UCI"
	G G
	Q
START	;
	S ZV="GTM",D="_",OSTYP=$G(^CURRENT("OS.TYPE"))
	S $ZINTERRUPT="K ^%WJ($J) ZSH ""*"":^%WJ($J)"
	S $ZSTEP="S %i=$I U 0 W ! ZP @$ZPOS U %i B"
	Q
S	;
	S JB=$J D START
	Q
DIS	;
	W !,"WELCOME TO E.S. GTM "_$$VER
	W !,"J"_$J_" I"_$P
	W !,"----------------------------"
	Q
SET0	;
	Q
	S ^%ZUCI("MGR")=""
	S ^%ZUCI("MGR","G")="/gtm/mgr/mgr.gld"
	S ^%ZUCI("MGR","R")="/gtm/mgr/ /gtm/"
	Q
LIST	;
	N GLO S GLO=$NA(^W($J,11)) K @GLO
	D GETU(GLO)
	N I S I=""
	F  S I=$O(@GLO@(I)) Q:I=""  D
	.W !,I,?10,^(I,"G")," ",^("R")
	Q
GETU(GLO) ;
	S ERR=""
	K @GLO
	M @GLO=^%ZUCI
	Q
GOUCI(U) ;
	N A,GLD,RUT
	S A=^%ZUCI(U)
	S GLD=^(U,"G")
	S RUT=^("R")
	S $zgbldir=GLD
	S $zroutines=RUT
	S $ZPROMPT=U_">"
	Q
UCI() ;
	Q $P($ZPROMPT,">",1)
DO(%U,%P) ;
	N HERE S HERE=$$UCI
	D GOUCI(%U)
	D
	.N HERE
	.D @%P
	D GOUCI(HERE)
	Q
luci	;
	D START^%ZU
	N GLO S GLO=$NA(^W($J,11)) K @GLO
	D GETU(GLO)
	N I S I=""
	F  S I=$O(@GLO@(I)) Q:I=""  D
	.W $$LOWER^%ESS(I)," "
	Q
ZT	;
	X "zT"
	Q
CUST() ;
	Q ^["MGR"]CURRENT("NAME")
JOB(UCI,RUT,PAR) ;
	N JBJ
	S JBJ=$G(JB)
	J JOB1^%ZU(UCI,RUT,PAR,JBJ)
	Q
JOB1(UCI,RUT,PAR,JBJ) ;
	D START^%ZU
	S JB="J"_$J_":"_JBJ
	D DO(UCI,"JOB2^%ZU")
	Q
JOB2 ;
	L +^JOB(JB)
	D @RUT
	L -^JOB(JB)
	Q
VER() Q "1.02"
