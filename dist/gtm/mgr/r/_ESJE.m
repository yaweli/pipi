%ESJE ; JON EXAME
    D START^%ZU
1   D ^%SS
2   R !!,"JOB: ",J 
    I J="?" G 1
    I J="" Q
    D INTER(J)
    F K=1:1:10 H 0.2 I $D(^%WJ(J)) Q
    I $D(^%WJ(J)) D SHOW G 2 Q
    W " ..NO RESPONSE .."
    D LOOP G 1
    Q
SHOW ;
    ;ZWR ^%WJ(J,*)
    D ST
LOOP ;
    R !,"WHAT: [S/V/I/K] -> ",W
    I W="S" D ST G LOOP
    I W="V" D VV G LOOP
    I W?1"V".E D VVV G LOOP
    I W="I" D INTER(J) W " !INT! " G LOOP
    I W="K" D K(J) Q
    I W="" Q
    Q
ST  ;
    N X,A,UCI
    W !,"-----------[STACK]----------"
    S X="" F  S X=$O(^%WJ(J,"I",X)) Q:X=""  D
    .S A=^(X)
    .I A["$ZPROMPT" S UCI=$P($P(A,"""",2),">",1)
    S X="" F  S X=$O(^%WJ(J,"R",X)) Q:X=""   W !,^(X) I X=1 S A=^(X) D
    .D DO^%ZU(UCI,"J^%ESJE")
    W !,"----------------------------"
    Q
J   ; A = SAVE+5^mes272477537    ($ZINTERRUPT)
    S B=$P(A," ",1)
    W " // "
    X "W $T("_B_")"
    Q
VVV ;
    S VV=$P(W,".",2) I VV="" Q
    W !,VV,"=",$G(^%WJ(J,"VV",VV),"<UNDEF>")
    Q
VV  ;
    W !,"-----------[VAR]----------"
    S X="" F  S X=$O(^%WJ(J,"V",X)) Q:X=""   W !,^(X) D
    .S A=^(X)
    .S VAR=$P(A,"=",1)
    .S VAL=$P(A,"=",2,999)
    .I VAR'="" S ^%WJ(J,"VV",VAR)=VAL
    W !,"----------------------------"
    Q
INTER(J) ;
    D INT(J)
    W !,ERR,!
    Q
INT(J) ;
    D CG^%ESF("/gtm/mupip intrpt "_J)
    S ERR=""
    I $G(ANS(1))'["INTRPT issued" S ERR="JOB NOT GOT THE INTR"
    Q
K(J) ;
    I J<80    ZT
    I J'?2.6N ZT
    ZSY "kill -15 "_J
    Q
