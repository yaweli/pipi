%ZMNDAT2 ;   ccea jix`z z`ixw [ 05/01/89  12:16 AM ] <31.03.94 12:57 PM>
PRO ;
 ;   INPUT = %TXT1 - ('te`) dpey`x hqwh zxey
 ;           %TXT2 - ('te`)   dipy hqwh zxey
 ;           %LL   - ('te`) miil`ny miiley (MARGIN LEFT)
 ;           %DT   - .890414 oebk zpiienn dxeva jix`z
 ;                   ly jxrd z` lawi %DT if` ,xcben `l %DT m`
 ;                   .lcgnd zxixa jix`zk ynyn %DT .sheyd jix`zd
 ;
 ;  OUTPUT = %DT   - zpienn dxeva jix`z
 ;           %DAT  - 8/20/1990 a"dx`ak jix`z
 ;           %DAT1 - 20.8.90 l`xyiak
 ;           %DIT  - 20/8/90 l`xyiak
 ;           END   - FLEG=0/1
 ;           NEWHOR- NEW VALUE OF HOROLOG
IKAR ;
 N (%TXT1,%TXT2,%LL,%DT,%DAT,%DAT1,%DIT,END,NEWHOR)
 S ODT=$G(%DT)
 D PARAM ; CHK FOR PARAMETERS
IKAR1 ;
 I $D(%DT) D YESDAT,MAIN Q
 E  D NODAT Q
 Q
PARAM ;
 I '$D(%TXT1) S %TXT1=""
 I '$D(%TXT2) S %TXT2="jix`z qpkd"
 I '$D(%LL) S %LL=2
 S LEN=$L(%TXT2) I $L(%TXT1)>$L(%TXT2) S LEN=$L(%TXT1)
 Q
YESDAT ; miiw %DT  ------------------
 S %DT=$E(%DT,3,4)_"/"_$E(%DT,5,6)_"/"_$E(%DT,1,2) D %CDN^%ZESDAH
 S (%DT,HOR)=%DAT D YESHOR^%ZMNDAT
 Q
NODAT ; xcben `l %DT  --------------
 S (%DT,HOR)=+$H D YESHOR^%ZMNDAT
 D MAIN
 Q
MAIN ;
 S END=0
 U 0:(::::64),0:0
 W ?(LEN+17)
 I '$D(REP) W !,$J(%TXT1,LEN+%LL),!
TT W *13,$J(%TXT2,LEN+%LL),"  < ",%DIT," >  " R DT#15
 S ZB=$ZB\256
 I DT="^"!(ZB=17) S END=1 Q
 I $G(^%ZKEY(ZB))["F4" S END=1 Q
 I $G(^%ZKEY(ZB))["UP" S END=1 Q
 I DT="" S NEWHOR=HOR
 I DT?1"+"1N.N S NEWHOR=HOR+DT S DT=""
 I DT?1"-"1N.N S NEWHOR=HOR+DT S DT=""
 I DT["." D ADDP
 I DT["/" D ADDS
 I DT?1N!(DT?2N) D ADDAY
 I DT?3N!(DT?4N) D ADDMON
 I DT'="",DT'?6N W "  !! cala zextq 6 ywd",?77,*7 G TT
 I DT'="" D 1^%ZMNDAT I XR W "  !! iweg `l jix`z",?77,*7 G TT
 I DT'="" S %DT=$E(DT,3,4)_"/"_$E(DT,1,2)_"/"_$E(DT,5,6) D %CDN^%ZESDAH S NEWHOR=%DAT
 S %DT=NEWHOR D YESHOR^%ZMNDAT
 W " ... ",%DIT,"   "
 S (YYY,YYY1)=$P(%DIT,"/",1) I YYY?1N S YYY1=0_YYY
 S (MMM,MMM1)=$P(%DIT,"/",2) I MMM?1N S MMM1=0_MMM
 S %DT=$P(%DIT,"/",3)_MMM1_YYY1
 S %DAT1=YYY_"."_MMM_"."_$P(%DIT,"/",3)
 S DAY=$E("y`abcde",((NEWHOR+5)#7)+1)
 W DAY," mei (l/k) <k> " R F
 I $G(^%ZKEY($ZB\256))["UP"!("lK"[F&($L(F))) W *13,?77 S REP=1,%DT=ODT K:$L(ODT)=0 %DT G IKAR1
 Q
ADDAY ;
 N (DT,%DIT)
 S A=$P(%DIT,"/",2)
 I A<10 S A="0"_(+A)
 S B=$P(%DIT,"/",3)#100
 I B<10 S B="0"_(+B)
 I DT<10 S DT="0"_(+DT)
 S DT=DT_A_B
 Q
ADDMON ;
 N (DT,%DIT)
 I DT?3N S DT=$E(DT,1,2)_"0"_$E(DT,3)
 S B=$P(%DIT,"/",3)#100
 I B<10 S B="0"_(+B)
 S DT=DT_B
 Q
ADDP ;
 N (DT,%DIT)
 S R="."
 D ADDD
 Q
ADDS ;
 N (DT,%DIT)
 S R="/"
ADDD ;
 S A=$P(DT,R,1)
 I A<10 S A="0"_(+A)
 S B=$P(DT,R,2)
 I B<10 S B="0"_(+B)
 I $L($P(DT,R,3)) S C=$P(DT,R,3)#100 S:C<10 C="0"_(+C) S DT=A_B_C Q
 S DT=A_B
 Q
