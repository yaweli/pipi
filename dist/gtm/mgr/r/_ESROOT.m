%ESROOT ; RUN AS ROOT . mumps command
    Q
BG  ;
    D START^%ZU
    I $$USER^%ESF'="root" ZT  ;"only root"
    K ^["MGR"]RUN
    S JB=$J,D="_"
    ZA ^%ESROOT
    F  H 1 ZA ^%B:0 S T=$T D
    .I $T=1 ZD ^%B Q
    .I $T=0 D RUN
    .ZD ^%B
    Q
RUN ;
    N I S I=""
    F  S I=$O(^RUN(I))  Q:I=""  D
    .S A=^(I),U=$P(A,"_",1)
    .D DO^%ZU(U,"RUN1^%ESROOT("_I_")")
    Q
RUN1(I) ;
    S A=^["MGR"]RUN(I),X=$P(A,"_",2,999)
    S ^(I,"RUN")=$H_"_"_$J
    K INP
    M INP=^("INP")
    K ANS
    X X
    M ^["MGR"]RUN(I,"ANS")=ANS
    S ^["MGR"]RUN(I,"END")=$H_"_"_$J
    Q
SET(X,UCI,INP,ANS) ;
    N RUN,OK S ERR="",ANS=""
    S RUN=$I(^["MGR"]RUN)
    S ^["MGR"]RUN(RUN)=UCI_"_"_X
    I $D(INP) D
    .S INP=$G(INP)
    .M ^["MGR"]RUN(RUN,"INP")=INP
    S OK=0
    F F=1:1:10 ZA ^%B:0 H 1 I $D(^["MGR"]RUN(RUN,"END")) D END Q
    ZD ^%B
    I 'OK S ERR="NO RUN"
    Q
END ;
    K ANS
    M ANS=^("ANS") 
    K ^["MGR"]RUN(RUN) S OK=1 Q
    Q