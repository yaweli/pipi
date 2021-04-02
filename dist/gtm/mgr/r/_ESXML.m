%ESXML ; E.S. (C)
T   ;
    S JB=$J
    S GLX="^W(JB,1)" K @GLX
    S @GLX@(1)="<?xml version=1><lev1 PAR1='VAL1'>data</lev1><same>data2</same>"
    S GLM=$NA(^W(JB,2)) K @GLM
    ;
    D XML2GL(GLX,GLM)
    Q
XML2GL(GLX,GLM,C) ;
    ; 
    ;LSTRIP(A,GLO,COM,GLOA) ; A ="<xml ..." -> @GLO@(LEV1,LEV2,...)
    N GLOA,GLO,COM,A
    S A=""
    S GLOA=GLX
    S GLO=GLM
    S COM="NOPS/"_$G(C)
    ;
    ; COM = NOPS - DONT SAVE PARAMETER STRING @GLO@(.."PS")=(PPP=1 CCC=2)
    ;       BYNUM - SAVE ITEMS BY ORDER NUMBERS "NNN_ITEM")=...
    ;          <DEFAULT> IS BY NAME        "ITEM_NNN")=...
    ;       NONUM                "ITEM")=...
    ;       IC=(:) IGNORE CONTAIN ":"
    ;       FLAT - FLAT MODE (FOR GTM 255C LIMITS)
    ; GLOA - INPUT GLOBAL INSTEAD OF "A" (OPTION) FOR LONG XMLS
    ;        (IF EXIST A SHOULD BE A="")
    K @GLO
    N L,I,M,C,S,SAVE,DIGIT,NO,D,IGNORE,MI,M1,ZIP,ZIPL S I=0,IGNORE="",VAL=""
    N GLO0 S GLO0=GLO,ZIP=""
    S DIGIT=4,NO=0,D="_",COM=$G(COM)
    I COM["IC=(" S IGNORE=$P($P(COM,"IC=(",2),")",1)
    I $D(%LP("DIGIT")) S DIGIT=%LP("DIGIT")
    K %LP
    I $L(A),A'?1"<?xml ".E ZT
    S M=0 ; =0 INSIDE XML TAG 1=IN CONTENT
    S MI=0 ; =0 FINE TO SET VALUE
    S A=$TR(A,$C(13))
GO       ;
    D FEED(0)
    F I=1:1 Q:I>$L(A)  D  D FEED(1)
    .S C=$E(A,I),C1=$E(A,I+1)
    .I M=0 D  Q
    ..I C=">" S M=1 Q  ;WAIT FOR END OF <XML>
    .I M=1 D  Q
    ..I C="<" D TAG0 Q
    ..I C=" " Q
    ..I C=$C(9) Q
    .I M=2 D  Q  ;INSIDE <TAG>
    ..I C=">" D TAG Q
    ..S S=S_C
    .I M=3 D  Q  ;INSIDE VALUE
    ..I C="<",S="",C1="!" S M=4 Q  ; <![CDATA[Outdoor pool]]>
    ..I C="<" D VAL,TAG0 Q
    ..S S=S_C
    .I M=4 D  Q  ;INSIDE CDATA VALUE
    ..I C=">" D M4 Q
    ..S S=S_C I $L(S)>6000 Q  ;ZT
    I $D(GLOA),$D(@GLOA) S A="",I=0 G GO
    Q
TAG0     ; START <TAG>
    ;       ^
    S M=2
    S S=""
    Q
M4       ; END OF CDATA VALUE
    I S?1"![CDATA[".E1"]]" D  Q
    .S VAL=$P(S,"![CDATA[",2,9999)
    .S VAL=$E(VAL,0,$L(VAL)-2)
    .S S=VAL,VAL=""
    .S M=3 ;BACK TO VALUE MODE
    S S=S_C
    Q
TAG      ; END OF <TAG>
    ;       ^
    I S?1"/".E D CLOSE Q  ;    /TAG
    I S?.E1"/" D NULL Q  ;      TAG/
    I S'?1"/".E D OPEN Q  ;     TAG
    Q
NULL     ;
    D OPEN
    I $L(IGNORE),SKEY[IGNORE S M=1 Q
    S S="" D VAL
    S S="/"_SKEY D CLOSE
    Q
OPEN     ; S=TAG
    D SKEY
    I $L(IGNORE),SKEY[IGNORE S M=3 S MI=1 Q
    S MI=0
    N I S I=1+$ZP(SAVE("")),SAVE(I)=GLO ; SAVE OLD GLO ; PUSH
    D
    .I COM["NONUM" S KEY=SKEY Q
    .I COM["BYNUM" S KEY=$$LEV_D_SKEY Q
    .S KEY=SKEY_D_$$LEV
    ;
    D 
    .I COM["FLAT" D  Q
    ..N RUN S RUN=1+$ZP(@GLO0@("ZX",""))
    ..N GLO1 S GLO1=$NA(@GLO0@("ZX",RUN))
    ..S @GLO@("T",KEY,"TX")=GLO1
    ..S GLO=GLO1
    .S GLO=$NA(@GLO@("T",KEY))
    ;
    ;
G   I $D(@GLO) S GLO=$NA(@GLO@("..")) G G
    I $L(SPAR) D SPAR
    S M=3
    Q
CLOSE    ; S=/TAG
    S S=$E(S,2,9999) D SKEY
    I $L(IGNORE),SKEY[IGNORE S M=1 Q
    N I S I=$ZP(SAVE(""))
    I $L(I) S GLO=SAVE(I) K SAVE(I)
    S M=1
    Q
SPAR     ;
    I COM'["NOPS" S @GLO@("PS")=SPAR
    N M,I,C,G,A,VAR,VAL,G1
    S M=0,G="""",G1="'",A=SPAR,VAR="",VAL=""
    F I=1:1:$L(A) S C=$E(A,I) D
    .I M=0,C=" " Q
    .I M=0,C="=" S M=1,VAL="",M1=0 Q
    .I M=0 S VAR=VAR_C Q
    .I M=1,C=G!(C=G1),M1=0 S M1=1 S:C=G G1="" S:C=G1 G="" Q
    .I M=1,C=G!(C=G1),M1=1 S M1=0 S G="""",G1="'" Q
    .I M=1,M1=0,C=" " S M=0 D ADD Q
    .I M=1,M1=0,C="/" S M=0 D ADD Q
    .I M=1 S VAL=VAL_C
    .I M=3 S VAL=VAL_C
    D ADD
    Q
ADD      ;
    I VAR="" Q
    I $L(VAR)>80 S VAR=$E(VAR,0,80)_"~"
    I VAL?1"'".E1"'" S VAL=$E(VAL,2,$L(VAL)-1)
    S @GLO@("P",VAR)=VAL
    S VAR=""
    Q
SKEY     ;
    S SKEY=$P(S," ",1) I SKEY?.E1"/" S SKEY=$E(SKEY,0,$L(SKEY)-1)
    S SPAR=$P(S," ",2,999999) I SPAR="/" S SPAR=""
    S S=""
    Q
VAL      ;
    I MI S S="" Q
    I $D(@GLO)#2 ZT
    I S?1"'".E1"'" S S=$E(S,2,$L(S)-1)
    S @GLO=S
    S S=""
    Q
LEV()    ;
    S NO=NO+1
    Q $E("00000000000000000",1,DIGIT-$L(NO))_NO
    ;Q $$ZERO^%ZCAVS(NO,DIGIT)
    ;
    Q
GETVAL(GLO,ST) ; -> N="LEVEL" RETURN=VALUE (SEE TEST1)
    N C
    N I F I=1:1:$L(ST,",") S C=$P(ST,",",I) D  Q:N=""
    .S N=$O(@GLO@("T",C)) Q:N=""
    .S GLO=$NA(@GLO@("T",N))
    I N="" Q
    Q @GLO
BLD(GLO,GLO1) ;
    K @GLO1 N LN S LN=0
    N LV S LV=0
I        ;
    N A
    S LV=LV+1
    N I S I=""
    F  S I=$O(@GLO@(I)) Q:I=""  D
    .S A=$G(^(I))
    .I I'="T",I'="P" D A("<"_I_">")
    .I $L(A) D A(A)
    .I $D(@GLO@(I))>2 N GLO S GLO=$NA(^(I)) D I
    S LV=LV-1
    Q
A(A)     ;
    N Z S Z=60
    N A1,R
    F R=0:1 S A1=$E(A,R*Z+1,R+1*Z) Q:A1=""&R  D
    .S LN=LN+1
    .S @GLO1@(LN)=$S(R:"..",1:"")_$E("        ",0,LV)_": "_$TR(A1,D,"^")
    Q
FEED(FR) ; TAKE FROM GLOA NEXT STRING TO "A"
    I '$D(GLOA) Q
    I '$D(@GLOA) Q  ; NO MORE TO FEED
    N J
    F  Q:$L(A)>3000  S J=$O(@GLOA@("")) Q:J=""  D FEED1
    I I>199 D
    .S A=$E(A,I-1,$L(A)) ;CUT A FROM LEFT
    .S I=2
    Q
FEED1    ;
    S A=A_$TR(@GLOA@(J),$C(13)) ; FEED A FROM RIGHT
    K @GLOA@(J)
    Q