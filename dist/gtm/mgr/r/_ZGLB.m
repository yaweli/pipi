%ZGLB	; GLB LOAD HANDLER ; 16 Oct 2001 12:39 PM
	Q
Z	S AP="%ZAPH",PM="AP" D T^%ZA
	Q
C1	;
C2	;
C3	;
C4	;
C5	;
C6	;
C7	;
C8	;
C9	;
C10	;
	S PIC=FLD("PIC")
	S LAB=FLD("VAC") S:LAB="" LAB=FLD("STP") Q:LAB=""
	F %I=1:1 Q:'$D(^AP(AP,"T",PM,LAB,%I))  S %X=$P(^(%I)," ",2,99) X %X
	K %X
	Q
INS	Q
	Q
SEL	;
	S SG=1 D SG^%Z
	N A,P,PIC,TYP,OK
	S A=$G(^W(JB,AP,SC,LN))
	S M=$P(A,D,1)
	D FLD(1) ; -> FLD,TYP
	S F=99
	Q
FLD(P)	; [FUNC] GET FLD OF PIC.1
	Q
PF2	Q
PF3	Q
PF4	Q
HLP	Q
DEL	Q
	Q
EXT	;
	I F=16 S F=1 Q
	I F=99 S F=0
	E  S F=9
	;
	K %R
	K %SEL,%LNLOAD,%KCOMP
	Q
HDR	;
	Q
FIND	; LOAD AGAIN FROM M
	S %SEL=M
	D LOAD,CD^%ZAW,DATA
	Q
NOP	;
	Q
SCR	Q
	;
LOAD	; IN---> @%K ;
	Q:$D(^[wUCI]W(JB,AP,SC))
	;
	S %L=""
LOADN	; LOAD THE NEXT N PAGES ;
	N I,A,N,VK,VS,VX,GLOB,DATA,%K,SORT
	;
	; D SETGLB ; -> V.GLB ;
	;
	S YL=^%J(JB,AP,PM,"V.PAR","YL")
	I '$D(^%J(JB,AP,PM,"V.PAR","GLOB.R")) Q
	S GLOB=^%J(JB,AP,PM,"V.PAR","GLOB.R")
	S wKEY=^%J(JB,AP,PM,"V.PAR","GLOB.K")
	S DATA=^%J(JB,AP,PM,"V.PAR","DATA")
	K VX
	M VX=^%J(JB,AP,PM,"V.GLB","VX")
	K VS
	M VS=^%J(JB,AP,PM,"V.GLB","VS")
	K %K
	M %K=^%J(JB,AP,PM,"V.GLB","VK")
	Q:%K("STOP")=09                     ; DON'T LOAD GLOBAL AGAIN
	;
	S SORT=%K("SORT")
	S %SEL=%K("SEL")
	S %K("LN.LAST")=$O(^[wUCI]W(JB,AP,SC,""),-1)
	S %K("LN.LOAD")=00                  ; LIN.# LOAD BY LD1
	S %K("LN.LOAD.TO")=%K("PG.LOAD")*YL ; LIN.# MAX TO LOAD
	I %K("FROM")'="",%K("FROM")]wKEY D
	.      S wKEY=%K("FROM") Q:'$D(@GLOB@(wKEY))
	.      S wKEY=$O(@GLOB@(wKEY),-1)
	;S %INC=$G(%K("INC"))
	S LN=%K("LN.LAST")
	D LDGLB(GLOB,wKEY) ;D DO^%J(wUCI,"LOAD^%JGLB")
	;
	S %K("STOP")=STOP
	M ^%J(JB,AP,PM,"V.GLB","VK")=%K
	Q
LDGLB(GLOB,%L) ; IN UCI.ORIGION ;
	;
	S %L=$G(%L)
	F  S %L=$O(@GLOB@(%L),SORT)  D LD1 Q:STOP>1
	Q
LD1	; .@%K (%L) ;
	S STOP=0
	I %L=""         S STOP=9 Q
	I %L]%K("UNTL") S STOP=9 Q
	I %K("INC")'="" I %L'[%K("INC") Q
	I %SEL'=""      I $E(%L,1,$L(%SEL))'=%SEL S STOP=9 Q
	;;I %INC="[" I %L'[%SEL Q
	F %I=1:1 Q:'$D(VX(%I))  X VX(%I) Q:STOP
	Q:STOP
	;
	S LN=LN+1
	X "S A="_DATA S $P(A,D,31)=01
	F %I=1:1 Q:'$D(VS(%I))  D
	.  S VAC=VS(%I,"VAC"),VAL=VS(%I,"VAL") X "S VAL="_VAL
	.  S FLD=VAC I VAC'?.N S FLD=^%J(JB,AP,PM,"VA",VAC)
	.  S PIC=$P(^%J(JB,AP,PM,"V",FLD),D,5)
	.  S $P(A,D,PIC)=VAL
	S ^[wUCI]W(JB,AP,SC,LN)=A
	;
	S %K("LN.LOAD")=%K("LN.LOAD")+1
	I %K("LN.LOAD")+01>%K("LN.LOAD.TO") D  Q
	.    S STOP=5
	.    S ^%J(JB,AP,PM,"V.PAR","GLOB.K")=%L
	Q
SET	;
	S CODE="Q"
	S %SEL=$G(%SEL)
	Q
