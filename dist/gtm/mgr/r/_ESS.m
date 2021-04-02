%ESS    ; STRINGS
    ;(C) ELI SMADAR
	D L^%ESS
	I $I["/pts/" new a R !,"enter.. ",a
    Q
LOWER(A) ;
    I ZV="CACHE" Q $ZCVT(A,"L") 
    I ZV="GTM"   Q $ZCO(A,"L")
    D ZT^%ZU
    Q "" 
L1(A) ;
    I ZV="CACHE" Q $ZCVT(A,"T") 
    I ZV="GTM"   Q $ZCO(A,"T")
    D ZT^%ZU
    Q "" 
CAPS(A)	;
    I ZV="CACHE" Q $ZCVT(A,"U")
    I ZV="GTM"   Q $ZCO(A,"U") 
    D ZT^%ZU
    Q ""
CL(A) ;
	S A=$$CUTLT(A)
	F  Q:A'["  "  S A=$$REP(A,"  "," ")
	Q A
CUTLT(A) ;
	Q $$CUTL($$CUTT(A))     
CUTL(A) ; CUT LEADING BLANKS
	F  Q:$E(A,1)'=" "  S A=$E(A,2,$L(A))
	Q A
CUTT(A) ; CUT TRALING BLANKS
	F  Q:$E(A,$L(A))'=" "  S A=$E(A,0,$L(A)-1)
	Q A
DOPROG(%PRG5,%UCI5) ;
	D DO^%ZU(%UCI5,%PRG5)
	Q
	;CACHE
	;N %OLDNS S %OLDNS=$ZU(5)
	;ZN %UCI5 D @%PRG5
	;ZN %OLDNS
	Q
D(A) ;
	N X F X=1:1:$L(A) W !,X," : ",$A($E(A,X))," : ",$E(A,X),?10 I $A($E(A,X))>127 W " (8BIT)"
	Q
DP(A,DL) ;
	I $G(DL)="" S DL="_"
	N X F X=1:1:$L(A,DL) W !,X," [",$P(A,DL,X),"]"
	Q
CRC(A) ; CAL CHECKSUM OF A LINE
	N B,I S B=0
	F I=1:1:$L(A) S B=I*$A($E(A,I))+B
	Q B
HEX2DEC(%X) ; 
	N %i,%j,%D
	S %D=0 F %i=1:1:$L(%X) S %j=$F("0123456789ABCDEF0123456789abcdef",$E(%X,%i)) Q:'%j  S %D=%D*16+(%j-2#16)
	Q %D
DEC2HEX(%D) ; 
	N i,d,%X S d=%D
	S %X="" F i=1:1 S %X=$E("0123456789ABCDEF",d#16+1)_%X,d=d\16 Q:'d
	Q %X
REP(S,FROM,TO) ; 
	N L,B,I,R
	S L=$L(FROM)
	S B=""
	F I=1:1:$L(S) D
	.S R=$E(S,I,I+L-1)
	.I R=FROM S B=B_TO,I=I+L-1 Q
	.S B=B_$E(S,I)
	Q B
ST	;
	S $ZSTEP="S %i=$I U 0 W ! ZP @$ZPOS U %i B"
	;I $ET="" S $ET="B"
	Q
CLNH(A) ;
	N M,B,X
	S M=0,B=""
	F X=1:1:$L(A) S C=$E(A,X) D
	.I M=0,C="<" S M=1,B=B_" " Q
	.I M=1,C=">" S M=0 Q
	.I M=1,C="""" S M=3
	.I M=3,C="""" S M=1
	.I M=0 S B=B_C
	Q $$CL(B)
LOCK1 ; LOCK LIST MY UCI 
	I '$D(UCI) S UCI="MGR"
	; OUTPUT: ANS()
	N U,A,JOB,VEC,F
	K ANS,VEC
	N F S F="/tmp/a"_$j_".tmp"
	; gtmgbldir=/gtm/MGR.gld
	S COM="export gtmgbldir=/gtm/"_UCI_".gld && /gtm/lke show all"
	S COM=COM_" > "_F_" 2>&1"
	zsy COM
	D G^%ESF(F,"ANS")
	N I S I="",M=0
	F  S I=$O(ANS(I)) Q:I=""  D
	.S A=ANS(I) ; ^HOLD Owned by PID= 16096 which is an existing process
	.I A?3.4U S U=A Q
	.I A?1"^".E S GL=$P(A," ",1) S:A'["Own" A=ANS(I+1) D
	..S JOB=$P($P(A,"PID= ",2)," ",1)
	..S VEC(U,GL)=JOB
	K ANS M ANS=VEC
	D RM^%ESF(F)
	Q
LOCK ;
	N VEC
	N UCI S UCI=""
	F  S UCI=$O(^%ZUCI(UCI)) Q:UCI=""  D
	.;D DOPROG("LOCK1^%ESS",UCI)
	.D LOCK1
	.M VEC=ANS
	K AND M ANS=VEC
	Q
L	;
	D START^%ZU
	D LOCK
	W "LOCK TABLE",!
	W "==========",!
	W "UCI",?6,"JOB",?15,"GLOBAL",!
	W "---",?6,"---",?15,"------",!
	S U=""
	F  S U=$O(ANS(U)) Q:U=""  D
	.S GL=""
	.F  S GL=$O(ANS(U,GL)) Q:GL=""  D
	..S JJ=ANS(U,GL)
	..W U,?6,JJ,?15,GL,!
	Q
UNI(A) ;
	F  S F=$F(A,$C(226,128)) Q:'F  S A=$E(A,0,F-3)_$$UNIR6($E(A,F))_$E(A,F+1,9999)
	F  S F=$F(A,$C(195)) Q:'F  S A=$E(A,0,F-2)_$$UNIR($E(A,F))_$E(A,F+1,9999)
	N X,B S B="" F X=128:1:155,157:1:165,181:1:183,210:1:216,224:1:229,233:1:237 S B=B_$C(X)
	Q $TR(A,B,"cueaaaaceeeiiiAAEaAouuOUoOxfaiounNAAAEEiIIOsOOoOUUUyY")
	;
	;F X=144:1:159 W $C(226,128,X)
	;‐‑‒–—―‖‗‘’‚‛“”„‟
	;
	;------|-'',""""
	;
	;FOR>F X=128:1:191 W $C(195,X)
	;    ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ
	;    AAAAAAACEEEEIIIIDNOOOOOxOUUUUYpsaaaaaaaceeeeiiiionooooo-ouuuuypy
UNIR(C) ;
	N F,X S X="" F F=128:1:169 S X=X_$C(F)
	Q $TR(C,X,"AAAAAAACEEEEIIIIDNOOOOOxOUUUUYpsaaaaaaaceeeeiiiionooooo-ouuuuypy")
UNIR6(C) ;
	N F,X S X="" F F=144:1:159 S X=X_$C(F)
	Q $TR(C,X,"------|-'',""""""""")
	;         "            1 2 3 4"
	;FOR>F X=128:1:185 W $C(225,187,X)
	;    ỀềỂểỄễỆệỈỉỊịỌọỎỏỐốỒồỔổỖỗỘộỚớỜờỞởỠỡỢợỤụỦủỨứỪừỬửỮữỰựỲỳỴỵỶỷỸỹ
ZERO(A,N) ;
	Q $E("0000000000000000000000000",1,N-$L(A))_A
CLR8(A) ;
	N B,X,C S B=""
	F X=1:1:$L(A) S C=$A($E(A,X)) I C<128 S B=B_$C(C)
	Q B
FIXW(A) ; 
	I A["&amp;" S A=$$REP(A,"&amp;","&")
	I A["&quot;" S A=$$REP(A,"&quot;","""")
	I A["&#10;" S A=$$REP(A,"&#10;"," ") ; NEWLINE
	Q A
CHAR(S) ;
	I S="STAR" Q $C(226,173,144)
	I S="POLY" Q $C(226,173,147)
	I S="POLE" Q $C(226,173,148)
	I S="LEFT" Q $C(226,173,133)
	I S="RIGT" Q $C(226,173,134)
	I S="BOX"  Q $C(226,172,155)
	I S="FLSH" Q $C(226,154,161)
	I S="COFF" Q $C(226,152,149)
	Q S
ZW(VAR) ;
	I $I'["pts" W "<PRE>",!
	I '$D(VAR) S VAR="V"
	I $D(@VAR)#2 W !,"    ;"_VAR_"="_$G(@VAR)
	N I
	S I="" F  S I=$O(@VAR@(I)) Q:I=""  W !,"    ;"_VAR_"("""_I_""")="_$G(@VAR@(I))
	Q
ST2W(A) ; "string" -> "%hex%hex..."
	N G,C,B,DL S B="",DL="%"
	F G=1:1:$L(A) D
	.S C=$E(A,G)
	.I C=" " S B=B_"+" Q
	.I C?1LUN,$A(C)<129 S B=B_C Q
	.S B=B_DL_$$ZERO($$DEC2HEX($A(C)),2)
	Q B
C72U(A) ; VISUAL
	N B,X,C,AS
	S B=""
	F X=1:1:$L(A) D
	.S C=$E(A,X),AS=$A(C)
	.I AS'<96,AS'>122 S C=$C(215)_$C(144-96+AS)
	.S B=B_C
	Q B
C72UL(A) ; LOGICAL
	N B,X,C,AS
	S B=""
	F X=1:1:$L(A) D
	.S C=$E(A,X),AS=$A(C)
	.I AS'<96,AS'>122 S B=$C(215)_$C(144-96+AS)_B Q
	.I C=" " S B=C_B_C
	.S B=B_C
	Q B
ENC(A) ; e.s. (c)2021
	N B,METH,R,X S B=""
	S METH=$R(12)+1
	F X=1:1:$L(A) S R=$R(METH*10),B=B_"/"_R_"/"_(R+$A($E(A,X)))
	Q "#"_METH_"#"_B
	Q
DEC(A) ; e.s. (c)2021
	N B,METH,X,R,C
	S METH=$P(A,"#",2)
	I METH="",A'?1"##".E Q A
	S B=""
	I METH="T1" D  Q B
	.S A=$P(A,"#",3,99999)
	.F X=1:1:$L(A) S B=B_$C($A($E(A,X))-1)
	S A=$P(A,"#",3)
	I METH<13 F X=2:2 S R=$P(A,"/",X) Q:R=""   S C=$P(A,"/",X+1),B=B_$C(C-R)
	Q B