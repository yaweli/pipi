%ZGL	; GLOBAL LIST , ORG DSM , GOOD FOR ALL MUMPS
	;#POINTER /air/MGR/
	;#POINTER /airtst/MGR/
	;#POINTER /ptc/MGR/
	;#POINTER /ptctst/MGR/
	;#POINTER //MGR/
	;#POINTER //MGR/
	;#POINTER //MGR/
	; FIX ABD ADDED BY ELI SMADAR 2007
%GDSM	;GENERAL GLOBAL UTILITY (LIST, ETC) @SMB@ ; 10 Jun 92   3:39 PM
	N %S,YMD,D,C S YMD=$$YMD,D="_",C=":"
	;I $$ZV^%ZCAVV="MVX" U 0:(:) C 0
	D KILL^%ZGL1
	D SCREEN
	N QQ,%RET,%CHK
0	S %GIOD=0,%RET="^%ZGL"
	;I $$ZV^%ZCAVV="GTM" N $ES,$ET S $ET="G TRAPG^%ZGL1" ;%ERG^%ZGL" ;N $ZT S $ZT="G %ERG^%ZGL"
	N $ES,$ET S $ET="G TRAPG^%ZGL1" ;%ERG^%ZGL" ;N $ZT S $ZT="G %ERG^%ZGL"
1	D ^%ZGL1 G KQ:"^"[% S %("X")="G W" D GO G 1
%ER	U 0 W !,$ZE,! S $ZT="%ER^%ZGL" G 1
	Q
%ERG	S $EC="" U 0 W !,$ZS S %ER=1 Q  G 1
ZN	S %ZN=%N_%SS,%G=%ZN_""""")",%ZL=$L(%ZN),%DF=1
ZN1	S %G=$Q(@%G) G POP:$E(%G,1,%ZL)'=%ZN S %D=@%G D:%CHK CHK X %("X") Q:%Q  G ZN1
IO	S %QTY=2,%DEF=0 D ^%IOS G KQ:'$D(%DEV)
	;I $$ZV^%ZCAVV="MVX" S $ZT="TRAP^%ZGL"
	;I $$ZV^%ZCAVV="GTM" N $ZT,$ES S $ZT="G TRAPG^%ZGL"
	N $ZT,$ES S $ZT="G TRAPG^%ZGL"
	S %GIOD=%DEV O %DEV::3 K %DTY,%DEV G 1
CHK	I %D?.E1C.E F %I=0:1:31,127 I %D[$C(%I) G REMOV
	Q
REMOV	U 0 W !,%G," = ",%D,!?5,"Control character ",%I," in position ",$F(%D,$C(%I))-1
	S %D="Control characters in data, data not transferred" W !?5,%D Q
GO	S %Q=0 U %GIOD F %GP=1:1 Q:'$D(%(0,%GP))  D GP Q:%Q
	U 0 Q
GP	;
	S %GN=%(0,%GP,"S")
	D  Q:%Q
	.Q:%GN="^"
	.Q:%GN?1"^[".E1"]"
	.I $D(@%GN) D G
GP1	Q:%GN=%(0,%GP)  S %GN=$O(^UTILITY($J,0,%GN)) Q:%GN=""!(%GN]%(0,%GP))
	D G Q:%Q  G GP1
G	;*;Q:'$D(@%GN)  U 0 W:'%("X")["EDIT" !,"Now copying global : ",%GN U %GIOD S %C=$V(83,$J)#2,%L=0,%SS=""
	Q:'$D(@%GN)  U 0 W:'%("X")["EDIT" !,"Now copying global : ",%GN U %GIOD S %C=0,%L=0,%SS=""
	S %C1=0
	;;; S %G=%GN,%DF=$D(@%G),%N=%G_"(",%D=@%G S:'$D(%CHK) %CHK=0 D:%CHK CHK X:'%("P") %("X") Q:%Q
	S %G=%GN,%DF=$D(@%G),%N=%G_"(" S:%DF#2 %D=@%G S:'$D(%CHK) %CHK=0 I %DF#2 D:%CHK CHK X:'%("P") %("X") Q:%Q
L	S %L=%L+1 G POP:%L>%("M")&(%("M")>-1),ZN:%L>%("C")&%("D")&(%("M")<0) S %P=1
P	S %S=$S(%L'>%("C"):%(%L,%P,"S"),1:""),%DF=0
	D Q I %S]"" S %DF=$D(@(%N_%SS_%SQ_")")) G NX1:%DF
NX	I $D(%(%L,%P)),%S=%(%L,%P) G P1
	; %N="^W("  %SS=""   %SQ=text
	;S %N1=$TR(%N,"(","") S %S=$O(@%N1@(%SS_%SQ))
	I %SQ[$C(13)  S %N1=$TR(%N,"(","") S %S=$O(@%N1@(%SS_%SQ)) G NX0 ;E.S
	I $A($E(%SQ,1))=0 S %S=$TR(%SQ,$C(0),"") G NX0
	S %S=$O(@(%N_%SS_%SQ_")"))
NX0	G P1:%S="" I $D(%(%L,%P)) D T G P1:%X
	S %DF=$D(^(%S))
NX1	I '$D(%(%L,%P,"C")) D N Q:%Q  G PUSH:%DF\10,NX
	D Q S %D=$S(%DF#10:^(%S),1:""),%G=%N_%SS_%SQ_")"
	I @%(%L,%P,"C") D N0 Q:%Q  G PUSH:%DF\10
	G NX
P1	S %P=%P+1 G P:$D(%(%L,%P,"S"))
POP	Q:%L=1  S %L=%L-1,%P=%L(%L),%S=%L(%L,0),%SS=%L(%L,1),%SQ=%L(%L,2) G NX
PUSH	S %L(%L)=%P,%L(%L,0)=%S,%L(%L,1)=%SS,%L(%L,2)=%SQ,%SS=%SS_%SQ_"," G L
T	I %C S %X=%S]%(%L,%P) Q
	K %X S (%X(%S),%X(%(%L,%P)))="",%X=$O(%X(""))'=%S Q
N	D Q
N0	Q:%("P")>%L  I %DF#10=0 Q:%("D")
	S %D=$S(%DF#10:^(%S),1:""),%G=%N_%SS_%SQ_")" D:%CHK CHK X %("X") Q
W	;
	S %LG=%G
	I %DF#10 W !,%G," = ",%D Q
	W !,%G Q
Q	S %SQ=%S,%X=0
Q1	;;S %X=$F(%SQ,"""",%X) I %X S %SQ=$E(%SQ,1,%X-1)_$E(%SQ,%X-1,999)
	S %X=$F(%SQ,"""",%X) I %X D Q2
	I $L(%S)>27 K %X S %X(%S)="" S:$O(%X(" "))'="" %SQ=""""_%SQ_"""" Q
	I %SQ?1N.N1"E".E!%C1 S %SQ=""""_%SQ_"""" Q
	I %SQ?1N.N1"e".E!%C1 S %SQ=""""_%SQ_"""" Q
	S:+%SQ'=%SQ %SQ=""""_%SQ_""""
	Q
Q2	N I F I=$L(%SQ):-1:1 D
	.I $E(%SQ,I)=$C(34) S %SQ=$E(%SQ,1,I-1)_$C(34,34)_$E(%SQ,I+1,$L(%SQ))
	Q
KQ	K %,%C,%C1,%D,%DF,%G,%GN,%GP,%L,%N,%P,%Q,%S,%SQ,%SS,%X,%ZL,%ZN
KQ1	U 0 I $D(%GIOD),%GIOD'=$I,%GIOD C %GIOD
	D echo
	K %GIOD Q
TRAP	U 0 W !,$ZE G KQ1
TRAPG	Q:$ES  S $EC="" U 0 W !,$ZS G KQ1
CHKHLP	W !,?5,"Answer ""Y[ES]"" if you want to include a check for"
	W !,?5,"control characters in the global data. If  included"
	W !,?5,"each record containing control characters   will be"
	W !,?5,"displayed on your terminal so that they can be  re-"
	W !,?5,"stored manually. The control character check   will"
	W !,?5,"impact the speed of global save." Q
echo u 0:echo q
noecho u 0:noecho q
SCREEN	;
	W *27,*91,1,*59,66,*114 ;REG
	W *27,*91,66,*59,1,*72,!
	Q
YMD()	;
	I $ZV?1"Cach".E Q $TR($ZD(+$H,3),"-")
	Q $ZD(+$H,"YYYYMMDD")
VER()	Q "5.08"
	;Q "5.07.001" ; bug 1e313 - <maxnumber> Q1+4 ;#  eli=24/09/17.
	;Q "5.06.003" ;#  eli=10/05/16. sid=19/02/17. eli=25/04/17.
