%ZMNDAT ; jix`z ly zeiweg zwica [ 04/29/89  2:18 PM ] <28.05.92 12:01 PM>
1 S XR=1,TD=0 G:DT'?6N 3
    S QD=+$E(DT,1,2),QM=+$E(DT,3,4),QY=+$E(DT,5,6)
    G:QD<1!(QM<1)!(QM>12)!(QY<20)!(QY>99) 3
    S QL=31 S:QM=4!(QM=6)!(QM=9)!(QM=11) QL=30
    I QM=2 S QL=28 S:QY\4*4=QY QL=29
    G:QD>QL 3
2 S QJ=QY-60,TD=$J(QJ/400,0,3),TD=3.65*QJ+$E(TD,1,$L(TD)-1)+(QD/100)
    S:QM>2!'(QJ\4*4=QJ) TD=TD+.01
    S QK="0/.31/.59/.9/1.2/1.51/1.81/2.12/2.43/2.73/3.04/3.34"
    S XR=0,TD=TD+$P(QK,"/",QM)
3 K QD,QM,QY,QL,QJ,QK
    Q
    ;---------------------------------------------------------------------|
DAT ;DONE FOR UCI SIT ; CONVERT $H DATE TO DD-MMM-YY AND MM/DD/YY
    ;--- INPUT=$H
    ;--- OUTPUT=  %DIT - NORMAL FOR ISRAEL     - 26/01/86
    ;---          %DIT1- FOR DATE IN LETTERS   - 1986 x`epia 26
    ;---          %DAT -        FOR U.S.A.     - 1/26/1986
    ;---          %DAT1- AS IN U.S.A. WITH MMM - 26-JAN-86
NOHOR ; HOROLOG IS NOT DEFF.
    S %DT=+$H
YESHOR ; HOROLOG IS DEFF.
    D %CDS^%ZESDAH I '$D(%NP) S %DIT=$P(%DAT,"/",2)_"/"_$P(%DAT,"/",1)_"/"_$E($P(%DAT,"/",3),3,4)
HEBREW ;HEBREW WRITING
    S MACH="x`epi,x`exat,uxn,lixt`,i`n,ipei,ilei,hqebe`,xanhtq,xaehwe`,xanaep,xanvc"
    S %DIT1=$P(%DAT,"/",3)_" "_$P(MACH,",",+$P(%DAT,"/",1))_"a "_$P(%DAT,"/",2)
    K %DAT1,%DT,%NP,MACH
    Q
    ;---------------------------------------------------------------------|
DAY ;
    R !," jix`z =",DT
    I DT="" S END=1 Q
    S END=0
    D 1 I XR W " zerh " G DAY
    S %DT=+$E(DT,3,4)_"/"_+$E(DT,1,2)_"/"_+$E(DT,5,6) D %CDN^%ZESDAH
    S DAY=$E("y`abcde",((%DAT+5)#7)+1)
    S DAT=$E(DT,1,2)_"/"_$E(DT,3,4)_"/"_$E(DT,5,6)
    S %SDT=$E(DT,5,6)_$E(DT,3,4)_$E(DT,1,2)
    Q
VT100 ; READ ESC'S
    N (ELC,CUP)
    D ^%ZVT100
    Q
TIME1 ;
    D VT100
    S END=0
    U 0:(::::64),0:0
    W !
TT1 W *13,?17,"jix`zn = < " D DAT W %DIT," >  " U 0:(::7) R DT
    S ZB=$ZB\256
    I DT="^"!(ZB=17)!(DT=" ") S END=1 Q
    I DT="" S NO1=+$H
    I DT?1"+"1N!(DT?1N)!(DT?1"+"2N)!(DT?2N) S (NO1,%DT)=+$H+DT D YESHOR S DT=""
    I DT?1"-"1N!(DT?1"-"2N) S (NO1,%DT)=+$H+DT D YESHOR S DT=""
    I DT'="",DT'?6N W "  !! cala zextq 6 wx",?77,*7 G TT1
    I DT'="" D 1 I XR W "  !! iweg `l jix`z",?77,*7 G TT1
    I DT'="" S %DT=$E(DT,3,4)_"/"_$E(DT,1,2)_"/"_$E(DT,5,6) D %CDN^%ZESDAH S (NO1,%DT)=%DAT D YESHOR
    W ?43,"  ....... ",%DIT,?79
    S %DIET=%DIT
TIME2 ;
    W !!
TT2 W *13,"(mini qn + e`) jix`z cr = < ",%DIET," >  " U 0:(::7) R DT
    S ZB=$ZB\256
    I DT="^"!(ZB=17) F A=1:1:3 W @ELC,@CUP G:A=3 TIME1
    I DT="" S NO2=NO1
    I DT?1"+"1N!(DT?1N)!(DT?1"+"2N)!(DT?2N) S (NO2,%DT)=NO1+DT D YESHOR S DT=""
    I DT?1"-"1N!(DT?1"-"2N) S (NO2,%DT)=NO1+DT D YESHOR S DT=""
    I DT'="",DT'?6N W "  !! cala zextq 6 wx",?77,*7 G TT2
    I DT'="" D 1 I XR W "  !! iweg `l jix`z",?77,*7 G TT2
    I DT'="" S %DT=$E(DT,3,4)_"/"_$E(DT,1,2)_"/"_$E(DT,5,6) D %CDN^%ZESDAH S (NO2,%DT)=%DAT D YESHOR
    I NO1>NO2 W "  oey`xdn lecb zeidl jixv ipyd jix`zd",?77,*7 G TT2
    W ?43,"  ....... ",%DIT,?79
    S N=NO2-NO1+1
    D HID,KILL
    Q
HID ;
    K DAY
    W !!,"("
% S DAEL=0 F AA=NO2:-1:NO1 S %DT=AA D DTH,%CDS^%ZESDAH S DAY(AA,$P(%DAT,"/",2)_"/"_$P(%DAT,"/",1)_"/"_$E($P(%DAT,"/",3),3,4))=%HDATH W "-",$E("y`abcde",(%DT+5)#7+1) I (%DT+5)#7+1=1 S DAEL=1
    W "  ",$S(N=1:":cg` mei",N=2:":miinei",1:":mini "_N)," )"
    I DAEL=1 W !!,"! zezay llek `l :dxrd"
    Q
KILL W ! ;D ^HTS ;SET TABES TO 8 COL.
    K NO1,NO2,N,IND,DT,TD,XR,AA,%DAT,%DIT,%DIET,%DAT1,%DT,DAEL,%HDATH
    Q
DTH ; ixarl ifrel jix`z zkitd
    ; INPUT - %DT (%DT=+$H)
    ; OUTPUT- %HDATH
    N %GER S %GER="“"
    S %D=67660+%DT D D,HEB
    Q
D   ;
    S %CTYP="7,9,10,12,13,14,15,0,1,2,4,5,6,8,9,11,12,13,14,15,0,1,3,4,5,6,8"
    S %YOM=%D+6#7+1
    F %CY=1:1:27 S %DY=6939+$E("0011010021000121",$P(%CTYP,",",%CY)+1) Q:%D<%DY  S %D=%D-%DY
    F %YR=1:1:19 D DYSIZ Q:%D<%DY  S %D=%D-%DY
    S %YR=%CY+284*19+%YR,%YC=%DY#30-24,%QUIT=0
    F %M=1:1:12 D MONTH Q:%QUIT
    S %D=%D+1,%HDATE=%D_"."_%M_"."_%YR_"."_%EXT_"."_%YOM
    K %DY,%CTYP,%QUIT,%YC,%CY
    Q
HEB ;
    S %AN=%D D TN S %D=%HN
    ;S %D=$S(%D="הי":"טו",%D="יו":"טז",1:%D)
    N %X1,%X2,%X3,%X4
    S %X1="הי"
    S %X2="וט"
    S %X3="וי"
    S %X4="זט"
    S %D=$S(%D=%X1:%X2,%D=%X3:%X4,1:%D)
    ;S %AN=%YR#1000 D TN S %YR=$E(%HN,1)_""""_$E(%HN,2,6)
    S %AN=%YR#1000 D TN S %YR=$$RE(%HN) ;$E(%HN,1,2)_""""_$E(%HN,2,16)
    S %YR=$E(%YR,0,$L(%YR)-2)_%GER_$E(%YR,$L(%YR)-1,999)
    N %X S %X="תישרי,חשון,כסלו,טבת,שבט,אדר,ניסן,אייר,סיון,תמוז,אב,אלול"
    ;S %HDATH=%YR_$P(" '`, 'a",",",%EXT)_" "_$P("ixyz,oeyg,elqk,zah,hay,xc`,oqip,xii`,oeiq,fenz,a`,lel`",",",%M)_"a"_" '"_%D_" ,"_$P("'`,'a,'b,'c,'d,'e,zay",",",%YOM)_" mei"
    S %MON=$P(%X,",",%M)
    S %YIR=%YR
    ;S %DAY=$E(%D,3,4)_$E(%D,1,2)
    S %DAY=$$RE(%D)
    S %DAY0=%DAY
    I $L(%DAY)=4 S %DAY=$E(%DAY,1,2)_%GER_$E(%DAY,3,4)
    S %HDATH=%YR_$P(" '`, 'a",",",%EXT)_" "_$P(%X,",",%M)_"ב"_" '"_%D_" ,"_$P("'א,'ב,'ג,'ד,'ה,'ו,שבת",",",%YOM)_" יום"
    ; תישרי,חשון,כסלו,טבת,שבט,אדר,ניסן,אייר,סיון,תמוז,אב,אלול
    K %D,%EXT,%AN,%YR,%HN,%YOM,B,%HDATE,%,%ERR,%M,%DM,DLN,TTY
    Q
MONTH ;
    S %EXT=0,%DM=%M#2+29 S:((%M=2)&(%YC>0))!((%M=3)&(%YC<0)) %DM=%DM+%YC
    I %M=6,%DY'<365 S %EXT=1 G:%D<30 M9 S %D=%D-30,%EXT=2
    G:%D<%DM M9 S %D=%D-%DM Q
M9  ;
    S %QUIT=1
    Q
DYSIZ S %DY=354 S:%YR*7+1#19<7 %DY=%DY+30
    S %DY=%DY+$E($P($T(TBL+%YR),";",2),$P(%CTYP,",",%CY)+1)-1
    Q
TN  ;TRANSLATE BETWEEN HEBREW & ARAB NUMBRES
%AH S:%AN>999 %AN=%AN#1000
    S %=%AN D A S %HN=%1
    K %0,%1
    Q
A   ; 
    N TAF S TAF="ת"
    S %1="" F %0=0:0 Q:%<400  S %1=%1_TAF,%=%-400
    S A="000"_% D INV S A=$E(B,1,3) D INV S %=B
    ;S %1=$E("`abcdefgh",$E(%,3))_$E("iklnpqrtv",$E(%,2))_$E("wxyz",$E(%,1))_%1
    ;S %1=$E("אבגדהוזחט",$E(%,3))_$E("יכלמנסעפצ",$E(%,2))_$E("קרשת",$E(%,1))_%1
    N %2 S %2=%1,%1=""
    I $E(%,3)=1 S %1="א"
    I $E(%,3)=2 S %1="ב"
    I $E(%,3)=3 S %1="ג"
    I $E(%,3)=4 S %1="ד"
    I $E(%,3)=5 S %1="ה"
    I $E(%,3)=6 S %1="ו"
    I $E(%,3)=7 S %1="ז"
    I $E(%,3)=8 S %1="ח"
    I $E(%,3)=9 S %1="ט"
    I $E(%,2)=1 S %1=%1_"י"
    I $E(%,2)=2 S %1=%1_"כ"
    I $E(%,2)=3 S %1=%1_"ל"
    I $E(%,2)=4 S %1=%1_"מ"
    I $E(%,2)=5 S %1=%1_"נ"
    I $E(%,2)=6 S %1=%1_"ס"
    I $E(%,2)=7 S %1=%1_"ע"
    I $E(%,2)=8 S %1=%1_"פ"
    I $E(%,2)=9 S %1=%1_"צ"
    I $E(%,1)=1 S %1=%1_"ק"
    I $E(%,1)=2 S %1=%1_"ר"
    I $E(%,1)=3 S %1=%1_"ש"
    I $E(%,1)=4 S %1=%1_"ת"
    S %1=%1_%2
    Q
INV ;
    S B="" F %F=1:1:$L(A) S B=$E(A,%F)_B
    K %F,A
    Q
TBL ;
    ;1222121022112210
    ;0100212110221221
    ;2011022221000022
    ;1222101222112102
    ;2122210112221210
    ;0000222000002221
    ;1211021221210122
    ;2222100002122000
    ;0122212110221212
    ;2011221221002121
    ;1200002222110002
    ;2122120112221212
    ;0211212001222121
    ;1020221220000220
    ;2102122112112012
    ;2211010221221201
    ;0022201002222120
    ;1220122110110212
    ;2102000222001022
    Q
RE(A) ; UNICODE REVERSE
    N B S B=""
    F  Q:A=""  S B=B_$E(A,$L(A)-1,$L(A)),A=$E(A,0,$L(A)-2)
    Q B