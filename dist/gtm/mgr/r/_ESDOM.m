%ESDOM ; manipulating 
    Q
LINH(A) ; parse single HTML line
    N C,EX,G,M,P,T,X
    K V S M=0,EX="",BF="",G=""""
    F X=1:1:$L(A) S C=$E(A,X) D 1
    Q
1   ;
    I M=0 I C="<" S M=1,T="",P="" Q
    I M=0 S BF=BF_C Q
    I M=1 I C=">" S V(T)="" S M=0 Q
    I M=1 I C=" " S V(T)="" S M=2,P="" Q
    I M=1 S T=T_C Q
    I M=2 I C=" " Q
    I M=2 I C="=" S M=3,L="" Q
    I M=2 S P=P_C Q
    I M=3 I C=G S M=4 Q
    I M=3 I C=">" S:P'="" V(T,"P",P)=L S M=0 Q
    I M=3 I C=" " S V(T,"P",P)=L S M=2,P="" Q
    I M=3 S L=L_C Q
    I M=4 I C=G S M=3 Q
    I M=4 S L=L_C Q
    Q

    FOR>R T
    <long1 abc="text text text">clean text</LONG1>
    FOR>D LINH^%ESDOM(T) ZWR V,BF
    V("/LONG1")=""
    V("long1")=""
    V("long1","P","abc")="text text text"
    BF="clean text"
    