%ZHAG ; was HAG from uci ELI was ESBHL from sitrin
ESBHL ; ziz`nehe` l`xyi ibg dpy gel zipa <05.04.02 8:16 AM>
    ; (C) oixhiq iav xtkl zexeny ef zipkzl zeiekfd lk
    ; BASED ON MENACHEM BURSTAIN ^%ZMNDAT CONVERT TO HEBREW DATE
    ;S DATE=$E($$YMD^%ZH,1,4)_"0101"
    ;S DATE=20080901
    ;S TDATE="20151231"
    D START^%ZU
    S DATE=20190101
    S TDATE=20901231
LOOP ;
    D CDN ; DATA(YMD) -> DT(AB)
    S (%DT,DT)=DT
    D DTH^%ZMNDAT
    S A1=$P(%HDATH," ,",1)
    S A2=$P(%HDATH," ,",2)
    S A=$P(A1," ",2,999)
    S DAY=$$DAYU^%ESD(DT) ; $$DAY^%ZCAVV(DT) ;%ZH(DT)
    I $D(^TBL("HAGU",%MON,%DAY0)) D IN
    S DT=DT+1
    D CND
    I DATE=TDATE D HHH Q
    G LOOP
    Q
IN ;
    ;W "  ***  ",@$ZR
    S V=^(%DAY0)
    S NAME=$P(V,"_",1)
    S CHANGE=$P(V,"_",2) ; אם החג חל ביום מסויים הזז אותו
    S TO=$P(V,"_",3)
    S SUG=$P(V,"_",4) ; 1=full day holiday 2=half a day
    S SHA=$P(V,"_",5) ; not in use
    ;W !,$$DATE^%ZDT(DATE,".")_" : "_NAME_"   meia "_DAY
    I CHANGE="" D SAVE Q
    I DAY'=CHANGE D SAVE Q
    W !,"CHANGE : "_NAME_" "_DATE_" -> ",CHANGE," TO ",TO
    ;W *7,!!
    S R=DT
    N DT,DATE
    S DT=R+TO
    D CND
    D SAVE
    Q
SAVE ; gqt_y_1_1    iriay axr___2    zaha dxyr mev_y_1   fenza f"i mev_y_1  gqt iriay_ _ _1
    ; dpyd y`x axr_ _ _2_3.5
    W "(S)"
    S S=50 I SUG=1 S S=0
    S ^HAGS(DATE)=NAME_"_"_SUG_"_"_SHA ; SITRIN
    ;S ^HAGC(DATE)=S_D_NAME_D_$$DATE^%ZDT(DT,-2) ; CAV
    Q
CDN ;
    S DT=$$DT^%ESD(DATE,8,0) ;$$DATE^%ZDT(DATE,0)
    Q
    S DT=$$RAB^%ZH(DATE)
    Q
CND ;
    ;
    S DATE=$$DT^%ESD(DT,0,8) ;$$DATE^%ZDT(DT,-2) ;$$YMD^%ZH(DT)
    Q
TTT ; TBL BUILD 7BIY TO UNICODE - ONE TIME E.S. 16.2.2020
 S D="_"
 N X
 s X="" F  S X=$O(^TBL("HAG",X)) Q:X=""  D
 .S A=^(X)
 .;W !,X
 .S Y=$$C72U^%ESS(X)
 .;W " // ",Y
 .S MON=$P(X," ",1) W " =="_MON
 .S MON=$E(MON,0,$L(MON)-1)
 .;W " -- ",$$C72U^%ESS(MON)
 .;
 .S DAY=$P(X," ",2),DAY=$TR(DAY,"'""")
 .;W " || ",DAY
 .S DAYU=$$C72U^%ESS(DAY)
 .S MONU=$$C72U^%ESS(MON)
 .S DAYU=$$RE^%ZMNDAT(DAYU)
 .S MONU=$$RE^%ZMNDAT(MONU)
 .S B=A
 .S $P(B,D,1)=$$C72UL^%ESS($P(A,D,1))
 .S $P(B,D,2)=$$C72U^%ESS($P(A,D,2))
 .S ^TBL("HAGU",MONU,DAYU)=B
 .W !,MONU," // ",DAYU," // ",B
 Q
EDIT ;
    ;
    S M="" F  S M=$O(^TBL("HAGU",M)) Q:M=""  D
    .S DY="" F  S DY=$O(^TBL("HAGU",M,DY)) Q:DY=""  D
    ..S A=^(DY)
    ..S NM=$P(A,D,1)
    ..W !,M," // ",DY," = ",!,NM
    ..R !,AA I AA="" Q
    ..S $P(^TBL("HAGU",M,DY),D,1)=AA
    Q
SP ;
    S M="" F  S M=$O(^TBL("HAGU",M)) Q:M=""  D
    .S DY="" F  S DY=$O(^TBL("HAGU",M,DY)) Q:DY=""  D
    ..S A=^(DY)
    ..S NM=$P(A,D,1)
    ..S NM=$$CUTLT^%ESS(NM)
    ..S $P(A,D,1)=NM
    ..S ^TBL("HAGU",M,DY)=A
    Q
HHH ;
    S D="_"
    K ^HAGZ
    S DD=""
    F  S DD=$O(^HAGS(DD)) Q:DD=""  D H1
    Q
H1  ;
    S A=^(DD)
    S YR=$E(DD,1,4)
    S NM=$P(A,D,1)
    I NM="" Q
    S ^HAGZ(YR,NM)=DD
    Q
