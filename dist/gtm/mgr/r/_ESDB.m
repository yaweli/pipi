%ESDB ; database ,(c) eli smadar
    Q
FLDEDT(TB,LV) ; DEF -> M,A,S
    I '$D(FLD) ZT
    I '$D(DB)  ZT
    I '$D(DEF) ZT
    ;
    S M=DEF
    D GETVAR(TB,LV)
    S S=M
    K A S A=""
    I ENV("FTAB")?1"TAB:".E I M'="" D TAB ; M -> A
    Q
TAB ; -> A or A()
    N TAB,CY,I,B
    S TAB=$P(ENV("FTAB"),":",2)
    S CY=$P(ENV("FTAB"),":",3) I CY="" S CY=1
    S A=$P($G(^T(CY,TAB,M)),D,2)
    I M["," D
    .F I=1:1:$L(M,",") D
    ..S B=$P(M,",",I) I B="" W "!! "_M_"!! "
    ..I $D(^T(CY,TAB,B)) S A(B)=$P(^(B),D,2)
    ..E  W "!! UNDEF="_$R_" !!"
    Q
GETVAR(TB,LV) ; ("HAZ",0,.DB,FLD,DEF)
    I '$D(FLD) ZT
    I '$D(DB)  ZT
    I '$D(DEF) ZT
    ;
    S VAR=$P(DB(LV),D,FLD) ; "MODEL"
    K ENV
    M ENV=DB(LV,FLD)
    S ENV("DESC")=$P(ENV,D,1) ; Description
    S ENV("MUST")=$P(ENV,D,2) ; Y if must
    S ENV("FTAB")=$P(ENV,D,3) ; From table TAB:CN
    S ENV("UPDO")=$P(ENV,D,4) ; "INV"
    S ENV("MSKU")=$P(ENV,D,5) ; =1 disable edit 2=disable + don't check entry
    S ENV("MSKH")=$P(ENV,D,6) ; =1 Hidden field 
    S ENV("PLAC")=$P(ENV,D,7) ; Place holder , TEXT
    ;S ENV("")
    Q
GETKEYS ; -> KEYV()
    K KEYV
    N DB,DEF,ENV,FLD
    K DB M DB=^T(0,"DB","HAZ")
    N FLD S FLD="" F  S FLD=$O(DB(0,FLD)) Q:FLD=""  D
    .S DEF=""
    .D GETVAR^%ESDB("HAZ",0)
    .I ENV("UPDO")["K" M KEYV(FLD)=ENV
    Q