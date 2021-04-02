%ZGL1 ;
	;#POINTER /miki/MGR/
%G1 ;GLOBAL READ @SMB@ ; 10 Jun 92   3:39 PM
	;I $$USER^%ZCAVV="danielle" D ^%ZGL11 Q
1 S %DIR=0 D R K %DIR G KQ
R I $D(%CM) I %CM'="" W !,"["_%CM_"]"
	K % W !,"Global ^"
	D READ
	;R %
	W !
	Q:"^"[%  I %="?" D GD G R
	S QQ=", probably forgot quotes in subscript."
	I %="*D"!(%="?") X "N  D ^%GD" G R ;;;D GETDIR,DIS G R
	I %="??" D HELP G R
	I %?1"?"1A.NA!(%?1"?%".NA) D GETDIR,DISP G R
	D SRC
	S %WRT=1 D GO G R:%ER D GETDIR:%GD Q
GO S %("M")=-1,(%("C"),%("P"))=0,%("D")=1,(%P,%CP,%GD,%L,%ER)=0 W:%WRT ?8
GN D NM I $E(%N,2)'="%",$E(%N,2)'="[",$E(%N,2)'?.A,%N'="^ " G ER2
	G GN:%C=" "
L G P1:")"[%C,ER:"(,"'[%C S %L=%L+1,%("P")=%L,%P=0
P S %P=%P+1 Q:$E(%,%CP+1)=""  S %("C")=%L D E,SET Q:%ER
	I %C=":" S %(%L,%P)=$C(127) D E S:%O]"" @("%(%L,%P)="_%O)
	I %C=":" D E S:%O]"" %(%L,%P,"C")=%O
	G P:%C=" ",L:")"'[%C
P1 Q:%C=""  G ER:$E(%,%CP+1)]"" S %("M")=%L,%("D")=0 Q
E S %F=%CP+1,%PR=0
E1 D N I %PR=0!(%C="")," ),:"[%C S %O=$E(%,%F,%CP-1) Q
	I "()"[%C S %PR=%PR+$S(%C="(":1,1:-1) G E1
	G E1:%C'=""""
F D N G E1:""""[%C,F
N S %CP=%CP+1,%C=$E(%,%CP) W:%WRT %C Q
NM ;
	I $E(%)="(" S %4N=$E($ZR,2,999) S:$E(%4N,$L(%4N))=")" %4N=$E(%4N,1,$L(%4N)-1) S %=%4N_$E(%,2,999) K %4N
	I $E(%)="@" S %4N=@$P(%,"@",2),%=$S($E(%4N,$L(%4N))'=")":%4N_$P(%,"@",3,999),1:$E(%4N,1,$L(%4N)-1)_$S($P(%,"@",3,999)="":"",1:","_$E($P(%,"@",3,999),2,999)))
	D N0 S %P=%P+1,%(0,%P,"S")=%N
	I %C="*" S %(0,%P)=%N_"zzzzzzzz",%GD=1 D N Q
	I %C'=":",%C'="-" S %(0,%P)=%N Q
	S %GD=1 D N0 I %N="" S %(0,%P)="zzzzzzzzz" Q
	S %(0,%P)=%N Q
N0 D UP S %N="^" I %C="%" S %N="^%" D N
N1 I %C?1AN!(%C="%") S %N=%N_%C D N G N1
	I %C="("!(%C'="[") D  Q
	.S %Z=%N_"("""")",%Z=$Q(@%Z)
	.I $E(%Z,2)="[",$E(%N,2)'="[" S %N=$E(%Z,1,$F(%Z,"]")-1)_$E(%N,2,$L(%N))
	I $F(%,"]")=0 Q
	S %A=$E(%,$F(%,"["),$F(%,"]")-2)
	S %A1=$P(%A,","),%A2=$P(%A,",",2)
	I %A1?1A.NA,$L(%A1)'>8,$E(@%A1) S %A1=""""_@%A1_""""
	I %A2?1A.NA,$L(%A2)'>8,$D(@%A2) S %A2=""""_@%A2_""""
	S %A="["_%A1 S:%A2'="" %A=%A_","_%A2 S %A=%A_"]",%N=%N_%A
	S %CP=%CP+$F(%,"]")-2 W:%WRT $E(%A,2,255) D N G N1
	Q
UP D N G UP:%C="^" Q
ER S %ER=1 W:%WRT " ?",*7 Q
ER2 W " - Global name must begin with alphabetic or ""%""",*7 S %ER=2 Q
KQ K %C,%CP,%ER,%F,%GD,%L,%N,%O,%P,%PR,%WRT,%IEX
	I %="" S %G=""
	Q
DIS S %N="" F %I=1:1 S %N=$O(^UTILITY($J,0,%N)) Q:%N=""  W:%I#8=1 ! W ?%I-1#8*10,%N
	K %I,%N Q
DISP S %N="^"_$E(%,2,$L(%)-1)_$C($A(%,$L(%))-1)_"z",%S="^"_$E(%,2,99)
	F %I=1:1 S %N=$O(^UTILITY($J,0,%N)) Q:$E(%N,1,$L(%S))'=%S  W:%I#8=1 ! W ?%I-1#8*10,%N
	K %I,%N,%S Q
GETDIR Q:%DIR  S %GZE=$ZT,$ZT="TRAP^%ZGL1" O 63::1 G GET:$T W " <View buffer wait>" O 63
GET K ^UTILITY($J,0)
	I %["[" D
	.S %ALTUCI=$P($P(%,"]",1),"[",2)
	.S @("%UCI=$ZU("_%ALTUCI_")"),%ALTUCI="["_%ALTUCI_"]"
	.S %SN=$P(%UCI,",",2),%UCI=$P(%UCI,",")
	.S %=$P(%,"]",2,$L(%))
	E  S %UCI=$P($ZU(""),","),%SN=$P($ZU(""),",",2),%ALTUCI=""
	S %STB=$V(44)
	S %MM=$V(%SN*($V(%STB+34)#256)+$V(%STB+12)+2)
	S %BLK=$V(%UCI-1*20+4,%MM)#256*65536+$V(%UCI-1*20+2,%MM)
	S %VS="S"_%SN
	S %CT=0
%VIEW V %BLK:%VS
	S %END=$V(1022,0),%NAM="",%PT=0
%NXT G %PTR:%END'>%PT
%C S %A=$V(%PT,0)#256,%PT=%PT+1,%NAM=%NAM_$C(%A\2) G %C:%A#2
	S ^UTILITY($J,0,"^"_%ALTUCI_%NAM)=""
	S %CT=%CT+1,%PT=%PT+8,%NAM="" G %NXT
%PTR S %BLK=$V(1016,0)#256*65536+$V(1014,0) I %BLK G %VIEW
%PTR1 C 63 K %A,%ALTUCI,%CT,%NAM,%PT,%BLK,%END,%GZE,%LST,%STB,%UCI,%UCN,%UCIN S %DIR=1 Q
TRAP U 0 W !,$ZE G %PTR1
SET ;S $ZT="TRAP1^%ZGL1"
	I $$ZV^%ZCAVV="MVX" S $ZT="TRAP1^%ZGL1"
	;I $$ZV^%ZCAVV="GTM" N $ET S $ET="G %ERG^%ZGL"
	S %(%L,%P)=$C(127) S:%O]"" @("%O="_%O),%(%L,%P)=%O S %(%L,%P,"S")=%O Q
TRAP1 U 0 I $ZE["UNDEF" W !!,*7,"Global undefined [",$G(%O),"] ",QQ,!! D UNDEF,KQ G T1
	E  I $ZE["SYNTX" W !!,*7,"Syntax error",QQ,!! D KQ
	E  I $ZE["INRPT" W !,$ZE,! D KQ
	E  W !,$ZE,!
T1 S %ER=1 Q
TRAPG ;
	I $ZS["%GTM-E-UNDEF" W !!,"Global undefined [",$G(%O),"] ",QQ,!! D UNDEF,KQ G G1
	W !,$ZS,!
G1 S $EC=""
	S %ER=1
	Q
GTO D R G KQ
INT S %DIR=0 D INT1 K %DIR Q
INT1 S %P=% K % S %=%P,%WRT=0 D GO I %ER K % S %="" G KQ
	D GETDIR:%GD G KQ
GD ;
	I $$ZV^%ZCAVV="MVX" D INT^%GD Q
	D ^%GD
	Q
READ ;
	N RING,X,C,E,CC,PO,US,MD,ZV S US=$$USER^%ZCAVV,ZV=$$ZV^%ZCAVV,RING=0
	I ZV="GTM" D NOECHO^%ZCAVU,ESC^%ZCAVU W *27,"[?7l" U 0:WIDTH=0
	S %=$G(%DEF),E=0,X=0,MD="I" I $D(%DEF) D SHOW K %DEF
	F  R *CC S C=$C(CC) D READ1 Q:E
	I ZV="GTM" D ECHO^%ZCAVU W *27,"[?7h"
	D SAVE
	Q
READ1 ;
	I CC'=9 S RING=0
	I CC=13 S E=1 Q
	I CC=10 S E=1 Q
	I C=""  S E=1 Q
	I CC=8   D BS Q
	I CC=127 D BS Q
	I CC=9  D TAB  Q
	I CC=27 D ARRW Q
	I CC=21 S %="" D SHOW Q  ;^U
	S X=X+1
	I $L(%)+1=X S $E(%,X)=C W:ZV="GTM" C Q
	I MD="I" S %=$E(%,0,X-1)_C_$E(%,X,$L(%))
	D SHOW1(X)
	Q
BS ;
	I X=0 Q
	S $E(%,X)=""
	D
	.I $L(%)+1=X W *8," ",*8 Q
	.D SHOW1(X-1)
	S X=X-1
	Q
TAB ; ^QWEB("ER","ON.103","AB
	I %="!" D HIS1 Q  ;last full global disp
	I %?.E1"!!".E D HIS3 Q  ;any var
	I %?.E1"!".1N D HIS2 Q  ;last index of last global disp
	I %?1.N.E D SHORT Q
	I %'["(" D FULLG Q
	I %?.E1")" D SHOW W *7 Q  ;ALREAD FULL
	N GLO0,GLL,GLP,L,GL,N,GLLV,Q
	S GL0=$P(%,"(",1) ;QWEB
	S GLP=$P(%,"(",2,999) ;"ER","ON.103","AB
	S GLL="" I $L(GLP) D
	.S L=$L(GLP,",")
	.S GLL=$P(GLP,",",L) ; "AB
	.S GLP=$P(GLP,",",0,L-1) ;"ER","ON.103"
	I $L(GLL),GLL?1"""".E,GLL'?.E1"""" S GLL=GLL_""""
	S DIR=1
	S GL="^"_GL0
	I $L(GLP) S GL=GL_"("_GLP_")"
	S GLLV="" I $L(GLL) D GLL
	;GLP="ER","ON.103"
	;GL=^QWEB("ER","ON.103")
	;W !,"GLLV="_GLLV,!!
	S N=GLLV I $L(GLLV),'$D(@GL@(GLLV)) S N=$O(@GL@(GLLV)) ;,DIR)
	I GLLV="" S N=$O(@GL@(GLLV))
	S L=$L(GLLV)
	I $E(N,0,L)'=GLLV W *7 S N=GLLV D LIST
	S Q="""" I N?.N.".".N,N'?1"0".E S Q=""
	S %=GL0_"("
	I $L(GLP) S %=%_GLP_","
	S %=%_Q_N_Q D SHOW
	Q
GLL ;
	N $ET S $ET="D GLLE^%ZGL1"
	S GLLV=""
	X "S GLLV="_GLL ; AB
	I GLLV=-1 S GLLV=$O(@GL@(""),-1)
GLLE ;
	S $EC=""
	Q
SHORT ;
	I %?.N S %=$G(^%ZCAV("SC",%)) D SHOW Q
	I %[">" S ^%ZCAV("SC",$P(%,">",1))=$P(%,">",2,99) S %=""  W !,"SAVED .. ",! D SHOW
	Q
FULLG ; ^QWE -> ^QWEB ;T.B.C
	S GLIST=$NA(^WW($J,8)) I '$D(@GLIST) D GLIST
	I $D(@GLIST@("^"_%)) D  Q
	.S %=%_"("
	.D SHOW
	S N=$O(@GLIST@("^"_%))
	S N=$E(N,2,99)
	I $E(N,1,$L(%))'=% D  Q
	.D SHOW W *7
	S %=N_"("
	D SHOW
	Q
KILL ;
	S GLIST=$NA(^WW($J,8)) K @GLIST
	Q
GLIST ;
	K @GLIST
	D GLOLIST^%ZCAVL6("*",GLIST)
	D GLOLIST^%ZCAVL6("%*",GLIST,$$MGR^%ZCAVV)
	Q
SHOW1(X) ;
	N G S G=X
	D SHOW
	W *13
	W "Global ^",$E(%,0,G)
	Q
LIST ;
	S RING=RING+1 I RING<3 Q
	N M,I S N=$E(N,0,$L(N)-1),I=N
	F M=1:1:10 S I=$O(@GL@(I)) Q:I=""  Q:$E(I,0,$L(N))'=N  W !,$NA(^(I))
	I M>9 W !,"There is more..."
	W ! D SHOW
	Q
SHOW ;
	W *13
	W "Global ^",%,*27,"[K" S X=$L(%)
	Q
ARRW ;
	N KEY
	S KEY=$E($ZB,2,99)
	I KEY="[A" D UPUP,SHOW Q
	I KEY="[B" D DOWN,SHOW Q
	I KEY="[D" D LEFT Q
	I KEY="[C" D RIGH Q
	Q
LEFT ;
	Q:X=0
	W *8
	S X=X-1
	Q
RIGH ;
	I X=$L(%) Q
	W $E(%,X+1)
	S X=X+1
	Q
UPUP ;
	S PO=$G(PO)
	S PO=$ZP(^mcav("gl",US,PO))
	S %="" I $L(PO) S %=^(PO)
	Q
DOWN ;
	S PO=$G(PO)
	S PO=$O(^mcav("gl",US,PO))
	S %="" I $L(PO) S %=^(PO)
	Q
SAVE ;
	I %="" Q
	N RUN S RUN=1+$ZP(^mcav("gl",US,""))
	I %=$G(^(RUN-1)) Q
	S ^(RUN)=%
	Q
HIS1 ;
	S %=$E($G(%LG),2,$L(%LG)-1) D SHOW Q
	Q
HIS2 ;
	N F,C,I S I=$P(%,"!",2) I 'I S I=1
	S F=$P(%LG,",",$L(%LG,",")-I+1)
	;S F=$E(F,0,$L(F)-1)
	S %=$P(%,"!",1)
	S C="" I %'?.E1"(",%'?.E1"," S %=%_","
	S %=%_C_F
	D SHOW
	Q
HIS3 ;
	N F,D,%G S D="_",%G=$G(%LG)
	S F=$P(%,"!!",2) I F="" S F="%D"
	I F?1.N S F="$P(%D,D,"_F_")"
	S %=$P(%,"!!",1)
	;I F?.E1"_"1.N S F="$P("_$P(F,D,1)_",D,"_$P(F,D,2)_")"
	I F?1"!".E S F=$E(F,2,999)
	X "S %=%_("_F_")" D SHOW
	Q
HELP ;
	W !,"nn>ERR(YMD,,""SP"",      -- save ERR(YMD,,""SP"", as shortcut number nn"
	W !,"nn<tab>                  -- retrive the global shortcut nn -> ERR(YMD,,""SP"","
	W !
	W !,"??                       -- help + list shortcuts"
	W !,"!     (first char)       -- recall last global from the list displayed"
	W !,"global(a,b,!             -- recall last index in global (the last global displayed)"
	W !,"                         ex:                           V"
	W !,"                         -- ^ERR(20130508,'17:25','SP',1) = "
	W !,"global(a,b,!3            -- recall 3'rd index in global from the end of the string (the last global displayed)"
	W !,"                         ex:               VVVVV"
	W !,"                         -- ^ERR(20130508,'17:25','SP',1) = "
	W !,"global(a,b,!!            -- recall last value of the last global displayed"
	W !,"                         ex:                                VVVVVV"
	W !,"                         -- ^ERR(20130508,'17:25','SP',1) = 100200"
	W !,"global(a,b,!!3           -- recall piece 3 of the last value displayed"
	W !,"                         ex:                                     vvvvvv"
	W !,"                         -- ^ERR(20130508,'17:25','SP',1) = 0_HO_123500_RQ_OK"
	W !,"global(a,b,!!_$E(%D,1,3) -- recall any mumps expresion of the last values %D data %G global name"
	W !,"                         ex:                                vvv"
	W !,"                         -- ^ERR(20130508,'17:25','SP',1) = 0_HO_123500_RQ_OK"
	W !,"EXAMPLE: "
	w !," 33>W(JB,AP,SC,LN"
	w !," 33<tab>"
	w !
	W !,"List of shortcuts:"
	N I S I="" F  S I=$O(^%ZCAV("SC",I)) Q:I=""  W !,I," -- ",^(I)
	Q
UNDEF ;
	N US
	S US=$$USER^%ZCAVV
	S %=$$REP^%ZCAVL(%,%O,""""_%O_"""")
	D SAVE
	S %DEF=%
	Q
SRC ;
	I '$D(%CM) S %CM=""
	I %?1"/".E D SRC1 S %=" " Q
	Q
SRC1 ;
	S %CM=$P(%,"/",2,999)
	Q
VER() Q "1.00"

