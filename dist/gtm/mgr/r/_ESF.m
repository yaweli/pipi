%ESF	; FILE LIBRARY
	Q
EXIST(F) ;
	I $ZSEARCH("")
	I $ZSEARCH(F)="" Q 0
	Q 1
G(FL,GL) ; GET FILE "FL" INTO GLOBAL "GL"
	N A,J,READ S READ=""
	S ERR="" K @GL
	I '$$EXIST(FL) S ERR="CANNOT OPEN FILE "_FL Q  ;'
	N %I S %I=$I
	C FL
	O FL:READ
	D RUN
	C FL
	U %I
	Q
RUN	;
	N $ZT S $ZT="D ERR Q"
	F J=1:1 D  I $ZEOF'=0 Q
	.U FL R A I $ZEOF'=0 Q
	.S @GL@(J)=A
	Q
ERR	;
	I $ZE'["ENDOF" S ERR=$ZE Q
	S %F("L")=J-1
	Q
RENAME(FROM,TO) ;
	I $ZV["UNIX" D  Q
	.I $ZF(-1,"mv "_FROM_" "_TO)
	I $ZF(-1,"REN "_FROM_" "_TO)
	Q
MODE(FILE,MODE) ;
	N NULL S NULL=">/dev/null"
	I $ZV["UNIX" I $ZF(-1,"/bin/chmod "_MODE_" "_FILE_" "_NULL)
	Q
OWN(FILE,OWN) ;
	N NULL S NULL=">/dev/null"
	I $ZV["UNIX" I $ZF(-1,"/bin/chown "_OWN_" "_FILE_" "_NULL)
	Q
P(GL,FL,OPT,TO) ;
	S ERR=""
	N WRITE S WRITE="WNS"
	S OPT=$G(OPT),TO=$G(TO) I TO="" S TO=1
	I OPT["A" S WRITE="WSA"
	O FL:(WRITE:NEW):TO
	I $T=0 S ERR="CANNOT CREATE FILE "_FL Q
	U FL
	N I,N S I=""
	F  S I=$O(@GL@(I)) Q:I=""  D
	.S A=$G(^(I))
	.S N=$O(^(I))
	.W A
	.I N="" Q
	.W !
	C FL
	Q
FILEAT(F) ;
	N B,A
	I ZV="GTM" D  Q B
	.S A=$$PIPE("/usr/bin/stat """_F_"""|/usr/bin/grep Change") ; Change: 2019-09-25 12:01:25.580863997 +0300
	.S B=$P(A," ",2)
	.S B=$$DT^%ESD(B,3,0)_","_$$TIMAB^%ESD($P($P(A," ",3),".",1))
	Q $ZU(140,7,F)
FILEATD(F) ;
	I $$FILEAT(F)\16#2 Q "D"
	Q "F"
	Q
MODTIM(F) ; RETURN MODIFICATION TIME -> $H
	; file:///C:/CacheSys/Docs/olr/olrfzutil140.html#188875
	Q $ZU(140,2,F)
MODTIMU(F) ;
	N H S H=$$MODTIM(F)
	S H=$$WEBDATE^%ESD(H)
	Q H
DIR(MASK,GLO) ;
	ZT
	N A,M S M=""
	K @GLO S ERR=""
	N I S I=MASK
	F  S A=$ZSEARCH(I) Q:A=""  S I=""  D
	.I A?.E1"." Q
	.S M=M+1
	.S @GLO@(M)=A
	Q
RM(F)	;
	I F["*" ZT
	I F[";" ZT
	I F["`" ZT
	I $ZV["Linux" D COM("rm -f "_F) Q
	I $ZV["UNIX" D COM("rm -f "_F) Q
	I $ZV["Windows" I $ZF(-1,"del "_F) Q
	Q
MKDIR(DIR) ;
	S ERR=""
	N ANS,ANSERR
	D CGE("mkdir """_DIR_"""")
	I $L($G(ANSERR(1))) S ERR=ANSERR(1)
	Q
MV(F,T) ;
	S ERR=""
	D COM("mv """_F_""" """_T_"""")
	Q
COPY(F1,F2) ;
	N T 
	F T=",",";","*","'","""","`"," " I F1[T!(F2[T) S ERR="canot contain "_T X "ZT"
	I $ZV["Linux" D COM("cp -f "_F1_" "_F2) Q
	I $ZV["UNIX" I $ZF(-1,"cp -f "_F1_" "_F2)
	I $ZV["Windows" I $ZF(-1,"copy "_F1_" "_F2)
	Q
COM(F)	;
	I ZV="GTM" ZSY F Q
	I $ZF(-1,F)
	Q
CGE(COM,GLO,GLOE) ; run linux command save GLO = output GLOE = errors
	N F,K
	I $G(GLO)=""  S GLO="ANS"
	I $G(GLOE)="" S GLOE="ANSERR"
	S ERR="" K @GLO,@GLOE
	S F="/tmp/a"_$j_".tmp"
	S K="/tmp/e"_$j_".tmp"
	S COM=COM_" 1>"_F_" 2>"_K
	D COM(COM)
	D G(F,GLO)
	D G(K,GLOE)
	N ERR
	D RM(F)
	D RM(K)
	Q
CG(COM,GLO) ;
	I $G(GLO)="" S GLO="ANS"
	S ERR="" K @GLO
	N F S F="/tmp/a"_$j_".tmp"
	S COM=COM_" > "_F
	D COM(COM)
	D G(F,GLO)
	N ERR
	D RM(F)
	Q
CF(COM,GLO) ; for long commands
	I $G(GLO)="" S GLO="ANS"
	S ERR="" K @GLO
	N F S F="/tmp/a"_$j_".tmp"
	N S S S="/tmp/a"_$j_".sh"
	N GL1 S GL1=$NA(^W(JB,"CF")) 
	S @GL1@(1)=COM
	D P(GL1,S)
	D COM("sh "_S_">"_F)
	D G(F,GLO)
	N ERR
	D RM(F)
	D RM(S)
	Q
C1(COM) ; RETURN VLAUE OF SINGLE LINE COMMAND
	N GL S GL=$NA(^W($J,"A1")) K @GL
	D CG(COM,GL)
	N A S A=$G(@GL@(1))
	K @GL
	Q A
LIST(MASK,GL)
	K @GL
	I $ZSEARCH("")
	N A,D,M,I S D="_"
	F  S I=$ZSEARCH(MASK) Q:I=""  S @GL@(I)=""
	Q
WIFIL(GLO) ;
	N WIFI,A,I
	S ERR="" K @GLO
	D CG("iwlist scan | grep ESSID",GLO)
	I ERR'="" Q
	S I="" F  S I=$O(@GLO@(I)) Q:I=""  D
	.S A=^(I),WIFI=$P(A,"""",2)
	.S ^(I)=WIFI
	Q
S1(G,X) ;
	D S2
	Q
SCAN(G,X) ;
	N (G,X)
S2	S %=G
	D INT1^%ZGL1
	I $L($G(X))=0 S X="D DO^"_$ZN
	S %("X")=X
	S %GIOD=$I
	D GO^%ZGL
	Q
GG	;
	R !,"GLOBAL ^",G I G="" Q
	W !
	D SCAN(G,"W !,""S ""_%G,""="",$$GG1^%ESF(%D),""""")
	W !
	Q
GG1(A) ;
	I $L(A),A?.N Q A
	Q """"_$$REP^%ESS(A,"""","""""")_""""
USER() ;
	N A S A=$ZTRNLNM("USER")
	I A="" S A=0
	Q A
REGTM	;
	D START^%ZU
	I $$USER^%ESF'="root" W !,"root only" Q
	;
	S U=$$UCI^%ZU
	S UL=$$LOWER^%ESS(U)
	S GL=$na(^W($J,11)) K @GL
	D LIST^%ESF("/gtm/"_UL_"/r/*.m",GL)
	N I S I=""
	F  S I=$O(@GL@(I)) Q:I=""  D REGTM1
	Q
REGTM1 ;
	w "." ; /gtm/eli/r/mes8594143.m
	s R=$P($P(I,"/",5),".",1)
	ZL R
	Q
GR(FILE,OPT) ; GLOBAL RESTORE
	N (OPT,ERR,FILE) S ERR="",OPT=$G(OPT)
	D START^%ZU
	S GL=$NA(^W($J,"*FR")) K @GL
	D G^%ESF(FILE,GL)
	S I=$O(@GL@("")) S NAME=^(I)
	S I=$O(@GL@(I))  S DATE=^(I)
	I OPT'["SILENCE" D
	.W "Restoring ..."
	.W !,"NAME: "_NAME
	.W !,"DATE: "_DATE
	S E=0
	F  S I=$O(@GL@(I)) Q:I=""  D  Q:E
	.S G=^(I)
	.S I=$O(^(I)) I I="" S E=1 Q
	.S V=^(I)
	.I G'?1"^".E ZT
	.S @G=V
	Q
GS(VEC,FILE,NAME) ;
	; VEC="MES" ; %GDSM FORMAT EXP
	N (ERR,VEC,FILE,NAME) S ERR=""
	D START^%ZU
	S GL=$NA(^W($J,"*F")) K @GL
	S @GL@($I(LN))=$G(NAME,"GLOBAL SAVE")_" from "_$$USER
	S @GL@($I(LN))="DATE "_$$NOW^%ESD_" "_$$TIM^%ESD
	D GS1(VEC)
	D P^%ESF(GL,FILE)
	Q
GS1(%SRC) ;
	D SCAN^%ESF(%SRC,"D GS2^%ESF")
	Q
GS2	;
	S GL=$NA(^W($J,"*F"))
	S LN=$ZP(@GL@(""))
	S @GL@($I(LN))=%G
	S @GL@($I(LN))=%D
	Q
	;
	; G=DSM GLOBAL FORMAT
	; X=EXECUTE EACH GLOBAL 
SCAN(G,X) ;
	N %,%C,%C1,%CHK,%D,%DF,%G,%GIOD,%GN,%GP,%L,%N,%Q,%SS,%Z,%ZL,%ZN,%X,%SQ
	N %P,%S
	S %=G
	D INT1^%ZGL1
	S %("X")=X
	S %GIOD=$I
	D GO^%ZGL
	Q
xT	;
	D GS^%ESF("SRC(0,)","/tmp/eli.g") ZSY "cat /tmp/eli.g"
	Q
CSUM(F) ; return checksum of a file using linux command
	; EX RESPONSE: 173d8b83bb5dfefc6cf2ac6e18d57a30bb89a7f9335da70bd9040debff0966f2ee891df12cdae1123cf00c95bdac3a990b803f2bc4fd7819d81d2041f5238d6b1
	N ANS
	D CG("sha512sum """_F_"""")
	Q $P(ANS(1)," ",1)
PIPE(C) ;
	N P,A,%I S %I=$I
	S P="pipe"_$J
	O P:(command=C)::"PIPE"
	U P R A
	C P
	U %I
	Q A
EVAL(C) ;
	N P,A,%I S %I=$I
	S P="pipe"_$J
	O P:(command="eval `cat -`")::"PIPE"
	U P W C write /EOF
	R A
	C P U %I
	Q A
EV(C) ;
	I $L(C)>100 Q $$EVAL(C)
	;
	N P,A,%I S %I=$I
	S P="pipe"_$J
	O P:(command="eval '"_C_"'")::"PIPE" 
	U P ;W C write /EOF
	R A
	C P U %I
	Q A
	;
PIPEW(C,GL1,GL2) ;
	K @GL2
	N P,A,%I,LN S %I=$I
	S P="pipe"_$J
	O P:(command=C)::"PIPE"
	U P
	N I S I="" F  S I=$O(@GL1@(I)) Q:I=""  W ^(I),!
	write /EOF
	S LN=0
	F  Q:$ZEOF  R A S @GL2@($I(LN))=A
	C P U %I
	Q
GL() ; return next ^w(jb,...somthing..)
	N RUN S RUN=$I(^W(JB,".GL"))
	Q $NA(^W(JB,"G"_RUN))
	Q
VER() Q "2.03" ; add $$GL