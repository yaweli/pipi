%ESD	; DATE
	Q
CHKDMY(A) ; S="DD.MM.YYYY" -> %DT,ERR,%PDAT
	N DD,MM,YYYY K %DT,%PDAT
	S ERR=""
	I A["/" D
	.S A=$TR(A,"/",".")
	.I A'["+" S A=$P(A,".",1,2)_"."_(1900+$P(A,".",3)) Q
	.S A=$TR(A,"+",".")
	.S A=$P(A,".",1,2)_"."_(2000+$P(A,".",3)) Q
	I A'?2N1"."2N1"."4N S ERR="(DD.MM.YYYY) :äøåöá êéøàú"
	S YYYY=$P(A,".",3)
	S MM=$P(A,".",2)
	S DD=$P(A,".",1)
	S $ZT="CONT^"_$ZN
	D
	.S %DT=$ZDH(YYYY_MM_DD,8)
CONT	;   
	I '$D(%DT) S ERR=A_" é÷wåç àì êéøàú" Q
	S %PDAT=A
	Q
TIMS(%TM) ;
	I '$L($G(%TM)) S %TM=$P($H,",",2)
	I ZV="GTM" Q $ZDATE("0,"_%TM,"24:60:SS")
	Q $ZT(%TM,1)
TIM(%TM) ;
	I '$L($G(%TM)) S %TM=$P($H,",",2)
	I ZV="GTM" Q $ZDATE("0,"_%TM,"24:60")
	Q $ZT(%TM,2)
RTIM ; TIMAB()
	Q
TIMAB(HHMMSS) ; HH:MM  OR HH:MM:SS
	I ZV="GTM" Q $$CTN(HHMMSS)
	Q $ZTH(HHMMSS) ;ABSULE TIME "HH:MM" -> NNNNN
CTN(tm) ;
	n h,m,s
	s h=+tm,m=$p(tm,":",2),s=$p(tm,":",3)
	i h'<0,h<24,m'<0,m<60,s'<0,s<60 q h*60+m*60+s
	q ""
NOW()	I ZV="GTM" Q $ZDATE(+$H,"DD/MM/YYYY")
	Q $ZD(+$H,4) ;DD/MM/YYYY
NOWS()	;
	I ZV="GTM" Q $ZDATE(+$H,"YYYYMMDD")
	Q $ZD(+$H,8)
NOWD()	;
	I ZV="GTM" Q $ZDATE(+$H,"DD.MM.YYYY")
	Q $TR($ZD(+$H),"/",".")
TS()	; return time stamps
	Q $$NOWS_"T"_$$TIMS
DAY(A)	;
	Q $E("àáâãäåù",A+4#7+1)
DAYU(A)	;
	S A=A+4#7+1
	I A=1 Q "א"
	I A=2 Q "ב"
	I A=3 Q "ג"
	I A=4 Q "ד"
	I A=5 Q "ה"
	I A=6 Q "ו"
	I A=7 Q "ש"
	ZT
DATE(%H,%S) ; DD/MM/YYYY
	Q $ZD(+%H,4)
DAT(%H)	;
	I '$L($G(%H)) S %H=+$H
	N A S A=$ZD(+%H,8)
	I $ZV["MSM" D  Q A
	.S A=$ZD(%H,3)
	.S A=$P(A,"/",1)_"."_$P(A,"/",2)_"."_$E($P(A,"/",3),3,4)
	S A=$E(A,7,8)_"."_$E(A,5,6)_"."_$E(A,3,4)
	Q A
DOT(%H)	; DD.MM.YYYY
	I '$L($G(%H)) S %H=+$H 
	Q $TR($ZD(+%H,4),"/",".")       
	Q
AB(DAT)	;
	I DAT["/" S DAT=$TR(DAT,"/",".")
	I DAT'?2N1"."2N1"."4N ZT
	I ZV["GTM" Q $$CDN^%H($P(DAT,".",2)_"/"_$P(DAT,".",1)_"/"_$P(DAT,".",3))
	Q $ZDH($P(DAT,".",2)_"/"_$P(DAT,".",1)_"/"_$P(DAT,".",3))
UNIX(OP) ; op="-u" ; universal = Fri Jul  5 12:26:26 UTC 2002 
	;      -R  ; rfc-822   = Fri,  5 Jul 2002 15:27:46 +0300
	N A,B
	I $ZV["UNIX" S A="/bin/date "_OP O A:"QR" U A R B C A
	I $ZV'["UNIX" Q "Sat May 25 18:42:13 IDT 2002" ;T.B.C
	Q B
DT(A,FROM,TO) ; CONVERT FROM FORMAT TO FORMAT   S ANS=$$DT^%ESD("21.07.2001","D.M.Y","YMD")
	;                                         ANS=20010721
	; E.S. (2002) TOM2000(C)
	; FROM= 
	;  0 ABS
	;  . 15.06.2002
	;  1 06/15/2002 
	;  3 2002-06-15
	;  4 15/06/2002
	;  5 Jun 15, 2002
	;  8 20020615      yyyymmdd
	;  9 28122002      ddmmyyyy
	;  10 unix time (second from 01/01/1970)
	;
	; TO= 
	;  0 ABS
	;  . 15.06.2002
	;  1 06/15/2002 
	;  2 15 Jun 2002
	;  3 2002-06-15
	;  4 15/06/2002
	;  5 Jun 15, 2002
	;  6 Jun 5 2002
	;  7 Jun 05 2002
	;  8 20020615
	;  9 June 15, 2002
	; 10 unix time
	;
	N C D INIT
	D CAB
	D CCONV
	Q A
CAB	; CONVER TO ABS
	I ".1023456789"'[FROM ZT
	I "..1023456789"'[TO ZT
	I FROM=1 S A=$P(A,"/",2)_"."_$P(A,"/",1)_"."_$P(A,"/",3)
	I FROM=3 S A=$P(A,"-",3)_"."_$P(A,"-",2)_"."_$P(A,"-",1)
	I FROM=5 S A=$$ZERO2($P($P(A," ",2),",",1))_"."_$$ZERO2($$GMON($P(A," ",1)))_"."_$P(A," ",3)
	I FROM=8 S A=$E(A,7,8)_"."_$E(A,5,6)_"."_$E(A,1,4)
	I FROM=9 S A=$E(A,1,2)_"."_$E(A,3,4)_"."_$E(A,5,8)
	I FROM=10 S A=$$S1970(A)
	I FROM=0 Q
	S A=$$AB(A)
	Q
ZERO2(A) ;
	I $L(A)=2 Q A
	Q "0"_A
CCONV	;
	I TO=0 Q
	I TO=".",ZV="GTM"  S A=$ZDATE(A,"DD.MM.YYYY") Q
	I TO=4,ZV="GTM"  S A=$ZDATE(A,"DD/MM/YYYY") Q
	I TO=3,ZV="GTM"  S A=$ZDATE(A,"YYYY-MM-DD") Q
	I TO=2,ZV="GTM"  S A=$ZDATE(A,"DD-MON-YYYY") Q
	I TO="." S A=$ZD(A,4),A=$TR(A,"/",".") D:$P(A,".",3)<101 C1 Q
	I TO=10  S A=$$U1970($$DT(A,0,8),"00:00:00") Q
	I TO=8   S A=$ZDATE(A,"YYYYMMDD") Q
	S A=$ZD(A,TO)
	Q
U1970(DT,TM) ; YYYYMMDD , HH:MM:SS.SS -> SECONDS SINCE 1970.01.01
	N AB0,AB1,A
	S AB0=$$DT(19700101,8,0)
	S AB1=$$DT(DT,8,0)
	S A=AB1-AB0*60*60*24+$$TIMAB(TM)
	Q A
S1970(S) ;
	N TM,DT,AB0,DT1
	S TM=S#(60*60*24)
	S DT=S\(60*60*24)+1
	S AB0=$$DT(19700101,8,0)
	S DT1=AB0+DT
	Q $$DT(DT1,0,".")
C1	;
	S $P(A,".",3)=1900+$P(A,".",3)
	Q
INIT	;
	N C
	S C("ABS")=0
	S C("D.M.Y")="."
	S C("M/D/Y")=1
	S C("D M Y")=2
	S C("Y-M-D")=3
	S C("D/M/Y")=4
	S C("/")=4
	S C("YMD")=8
	S C("DMY")=9
	S C("UNIX")=10
	I $D(C(FROM)) S FROM=C(FROM)
	I $D(C(TO))   S TO=C(TO)
	Q
GMON(NAME) ; RETURN MOINTH NAME -> NUMBER
	S NAME=$$CAPS^%ESS(NAME)
	N OK,I
	F I=1:1:12 I $P("JAN_FEB_MAR_APR_MAY_JUN_JUL_AUG_SEP_OCT_NOV_DEC","_",I)=NAME S OK=I Q
	I '$D(OK) F I=1:1:12 I $P("JANUARY_FEBRUARY_MARCH_APRIL_MAY_JUNE_JULY_AUGUST_SEPTEMBER_OCTOBER_NOVEMBER_DECEMBER","_",I)=NAME S OK=I Q
	Q $G(OK)
MON(M,LANG) ;
	Q $P("øàåðé_øàåøáô_ñøî_ìéøôà_éàî_éðåé_éìåé_èñåâåà_øáîèôñ_øáåè÷åà_øáîáåð_øáîöã",D,M)     
MONE(M)
FIX(A)	; FIX ENTER DATE TO DD.MM.YYYY
	N NOWS S NOWS=$$NOWS
	N NOWSY S NOWSY=$E(NOWS,1,4)
	N REFY S REFY=NOWSY+11#100
	N FULL S FULL=NOWSY\100*100
	N FULL0 S FULL0=NOWSY\100-1*100
	I A?6N D
	.N YY S YY=$E(A,5,6)
	.S A=$E(A,1,4)_$$YFIX(YY)
	I A?8N S A=$E(A,1,2)_"."_$E(A,3,4)_"."_$E(A,5,8)
	S A=$TR(A,"/-","..")
	I $P(A,".",1)?1N S $P(A,".",1)="0"_$P(A,".",1)
	I $P(A,".",2)?1N S $P(A,".",2)="0"_$P(A,".",2)
	I $P(A,".",3)?1N S $P(A,".",3)="0"_$P(A,".",3)
	I $P(A,".",3)?2N S $P(A,".",3)=$$YFIX($P(A,".",3))
	K %ESD
	Q A
YFIX(YY) ; YY -> YYYY
	I YY?4N Q YY
	N DELTA S DELTA=11 ; FUTURE CONSTANT (11 YEARS IN THE FUTURE)
	I $D(^CURRENT("DATE","future")) S DELTA=@$ZR
	I $D(%ESD("DELTA")) S DELTA=%ESD("DELTA")
	N NOWS S NOWS=$$NOWS
	N NOWSY S NOWSY=$E(NOWS,1,4)
	N REFY S REFY=NOWSY+DELTA#100
	N FULL S FULL=NOWSY\100*100
	N FULL0 S FULL0=NOWSY\100-1*100
	I YY<REFY Q FULL+YY
	Q FULL0+YY
	Q       
WEBDATE(H) ;
	S H=$G(H,$H)
	Q $ZD(+H,11)_", "_$ZD(+H,2)_" "_$ZTIME($P(H,",",2))_" EST"
CHKTIM(A) ; A "HH:MM" -> ERR
	S ERR=""
	I A'?2N1":"2N S ERR="HH:MM äøåöá äòù ñðëä ?-"_A Q
	I A>23 S ERR="HH:MM äøåöá äòù ñðëä ?-"_A Q
	I $P(A,":",2)>59 S ERR="HH:MM äøåöá äòù ñðëä ?-"_A Q    
	Q
AGE(BIRTH,INDATE) ; AGE OF PERSON BIRTH IN THE DATE OF "INDATE"
	; BIRTH - 20050101
	; INDATE - 20060101
	Q INDATE-BIRTH\10000
AGES(BIRTH,INDATE) ; AGE OF PERSON BIRTH IN THE DATE OF "INDATE" IN SHNATONIM MANNER
	; BIRTH - 20050101
	; INDATE - 20060101
	Q $E(INDATE,1,4)-$E(BIRTH,1,4)
HEBD(N) ; N=1 SUNDAT
	Q $P("ראשון,שני,שלישי,רביעי,חמישי,שישי,שבת",",",N)
DIFS(T1,T2) ; Difference time HH:MM:SS
	N H1,H2
	S H1=$$TIMAB(T1)
	S H2=$$TIMAB(T2)
	Q H2-H1
DIF(H1,H2) ; return diff in sec between two absolute times ($h)
	; H1 - from time
	; H2 - to time
	I +H1=(+H2) Q $P(H2,",",2)-$P(H1,",",2) ; most of the times, same day
	Q 60*60*24*(H2-H1)+($P(H2,",",2)-$P(H1,",",2))
DIFT(H1,H2,OPT) ; text different between two dates
	;H2 later
	I H2="" S H2=$H
	N A
	S DIF=$$DIF(H1,H2)
	I DIF<(60*60*24),$G(OPT)["MIN" D  Q A
	.I DIF<60 S A="now" Q
	.I DIF<(60*60) S A=DIF\60_" min" Q
	.S A=DIF/(60*60)\1_" hours"
	I DIF<(60*60*24)   Q "Today"
	I DIF<(60*60*24*2) Q "Yesterday"
	I DIF>(60*60*24*365*2) Q "more than "_(DIF\(60*60*24*365))_" years"
	I DIF>(60*60*24*365) Q "more than a year"
	Q DIF\(60*60*24)_" days ago"
	Q
VERSION() Q "2.02"
