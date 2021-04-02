%ESLIB	; HTML LIB
	; E.S. 2001
	; 
	Q
W(A)	;
	N AP
	D CONVERT
	D DISP
	Q
CONVERT	;
	S AP=A
	I %LNG=%DLG Q  ;THE SAME
	I %DLG=7 D  Q
	.I %LNG=1   S AP=$$C72W^%ESS(A) Q   ;SHOW VISUAL HEBREW
	.I %LNG="W" S AP=$$WINH7^%ESS(A) Q  ;SHOW LOGIVAL HEBREW
	I %DLG=1 D  Q
	.I %LNG="W" S AP=$$WINH^%ESS(A) Q   ;SHOW LOGIVAL HEBREW
	ZT "TO BE CONTINUE"
	Q
DISP	;
	W AP
	Q
	
	I %LNG=0 W A Q  ;ENGLISH
	I %LNG=1 D  Q
	.N AP S AP=$$C72W^%ESS(A)
	.W AP
	Q
xBR()	W !?($$LEV),"<BR>" Q
BR()	W "<BR>" Q
BRS()	Q "<BR>" Q
COLOR(A) W !?($$LEV),"<FONT COLOR="""_A_""">" Q
ENDCOLOR(A) D ENDFONT() Q
xFONT(A) W !?($$LEV),"<FONT FACE="""_A_""">" Q
FONT(A)	W "<FONT FACE="""_A_""">" Q
FF(FF)	;
	W !?($$LEV),"<FONT"
	D AT
	W ">"
	Q
xENDFONT(A) W !?($$LEV),"</FONT>" Q
ENDFONT(A) W "</FONT>" Q
HR()	;
	;I %LEV D WOR("Unclosed level ="_%LEV)
	W !?($$LEV),"<HR>"
	Q
ACT()	; RETURN URL TO JUMP TO RUT + VAR + VAL
	N ACT
	S SId=SId+1 
	D SUBSAV^%ESWSE("%RUT") ; SAVE ROUTINE NAME
	S TARG="" I VAR["/" S TARG=$P(VAR,"/",2),VAR=$P(VAR,"/",1)
	X "N "_VAR_" S "_VAR_"=VAL D SUBSAV^%ESWSE(VAR)" ; SAVE VAR/VAL
	S ACT=$$SVAR("Id",Id)_"&SId="_SId
	D FIXACT
	Q ACT ;     4   5   6   7   8   9 10
FLINK(VAR,VAL,%RUT,TEXT,ALT,APR,%ST,%EV,ID,FF) ; HYPER LINK
	W !?($$LEV),"<A"
	;S SId=SId+1 
	;D SUBSAV^%ESWSE("%RUT") ; SAVE ROUTINE NAME
	;S TARG="" I VAR["/" S TARG=$P(VAR,"/",2),VAR=$P(VAR,"/",1)
	;X "N "_VAR_" S "_VAR_"=VAL D SUBSAV^%ESWSE(VAR)" ; SAVE VAR/VAL
	;N ACT S ACT=$$SVAR("Id",Id)_"&SId="_SId
	;D FIXACT
	W " HREF="_$$ACT
	I $L($G(ID)) W " ID="""_ID_""""
	I $L($G(FF)) D AT
	D %ST
	D %EV
	D ALT
	I $L(TARG) W " TARGET="""_TARG_""""
	W ">"
	D
	.I TEXT?1"##/".E D IMGL Q
	.I TEXT?1"!!/".E X "D "_$P(TEXT,"/",2,99) Q
	.D W(TEXT)
	W "</A>"
	Q
IMGL	;
	N AT S AT=""
	N A1 S A1=$P(TEXT,"##",3)
	I $L(A1) S AT="W"_$P(A1,"x",1)_"/H"_$P(A1,"x",2)
	N ID S ID=$P(TEXT,"##",4) I $L(ID) S AT=AT_"/ID"_ID
	D IMG($P(TEXT,"##",2),"",AT_"/BO0")
	Q
FORMPOST() ;
	W !?($$LEV),"<FORM"
	N ACT S ACT="/cgi-bin/EsPost"
	W " ACTION="""_ACT_""""
	W " METHOD=POST"
	W " ENCTYPE=""multipart/form-data"""
	W ">"
	D VALUE("Id")
	Q
FORM(A,B,APR) ;
	W !?($$LEV),"<FORM"
	N ACT S ACT=$$SCRIPT
	D FIXACT
	W " ACTION="""_ACT_""""
	W " METHOD=GET"
	I $L($G(B)) W " NAME="""_B_""""
	W ">"
	D VALUE("Id")
	I $L($G(A)) D
	.;N %RUT S %RUT=A D VALUE("%RUT")
	.S SId=SId+1
	.N %RUT S %RUT=A D SUBSAV^%ESWSE("%RUT") ; SAVE ROUTINE NAME
	.D VALUE("SId")
	Q
ENDFORM() W !?($$LEV),"</FORM>" Q
xSCRIPT() Q "/cgi-bin/Es"
SCRIPT() Q "/cgi-bin/es"
SVAR(VAR,VAL) ;
	Q $$SCRIPT()_"?"_VAR_"="_VAL
FIXACT	;
	I $L($G(APR)) D
	.I $D(^CURRENT("MAIN","URL")) D
	..I APR?1"SSL=ON=".E S ACT="https://"_$P(APR,"=",3)_ACT
	..I APR="SSL=ON" S ACT="https://"_^CURRENT("MAIN","URL")_ACT
	..I APR="SSL=OFF" S ACT="http://"_^CURRENT("MAIN","URL")_ACT
	Q
	; --------- tables --------
LEV()	Q 2*%LEV
INITLEV	;
	S SId=""
	S %LEV=""
	Q
	; 
	;S %LNG=0 ; Display Lang: English
	;S %LNG=1 ;               Hebrew visual
	;S %LNG=2 ;               Hebrew Logical
	;S %DLG=1 ; Database Languge: Hebrew visual
	;S %DLG=7 ;                   Hebrew old code (7 bit)
	;S %DLG=7,%LNG=1 ; Old code 
	;S %DLG=1,%LNG=1 ; hebrew visual
	;
INIT(A,B) ;
	D INITLEV
	S %DLG=A,%LNG=B
	D SAV^%ESWSE("%DLG")
	D SAV^%ESWSE("%LNG")
	K %GEN
	S JB=$R(1111111111111111)
	Q
NEWTABLE(FF,%ST) ;
	W !?($$LEV),"<TABLE"
	I $L($G(FF)) D AT
	I $L($G(%ST)) D %ST
	W ">"
	S %LEV=%LEV+1
	Q
DO(RUT)	;
	D REM("RUN "_RUT)
	X "D "_RUT
	Q
REM(A)	W !,"<!-- "_A_" -->",! Q
ENDTABLE() ;
	S %LEV=%LEV-1
	W !?($$LEV),"</TABLE>"
	Q
NEWLINE(FF,MORE,%ST) ;
	W !?($$LEV),"<TR"
	D AT
	D %ST
	I $L($G(MORE)) W " "_MORE
	W ">"
	S %LEV=%LEV+1
	Q
ENDLINE() ;
	S %LEV=%LEV-1
	W !?($$LEV),"</TR>"
	Q
NEWCOL(FF,MORE,%ST) ;
	W !?($$LEV),"<TD"
	D AT
	D %ST
	I $L($G(MORE)) W " "_MORE
	W ">"
	S %LEV=%LEV+1
	Q
ENDCOL() ;
	S %LEV=%LEV-1
	W "</TD>"
	;W !?($$LEV),"</TD>"
	Q
AT	;
	N ZFF,G,ZFF2,ZFF3 Q:'$L($G(FF))
	F G=1:1:$L(FF,"/") D
	.S ZFF=$P(FF,"/",G)
	.I ZFF="" Q
	.S ZFF2=$E(ZFF,2,999)
	.S ZFF3=$E(ZFF,3,999)
	.I ZFF2="" Q
	.I ZFF?1"ID".E D
	..W " ID=""",ZFF3,""""
	.I ZFF?1"TI".E D
	..W " TITLE=""",ZFF3,""""
	.I ZFF?1"FF".E D
	..W " FACE=""",ZFF3,""""
	.I ZFF?1"FS".E D
	..W " SIZE=",ZFF3
	.I ZFF?1"AL".E D
	..W " ALIGN=",ZFF3
	.I ZFF?1"VA".E D
	..W " VALIGN=",ZFF3
	.I ZFF?1"W".E D
	..W " WIDTH=",ZFF2
	.I ZFF?1"H".E D
	..W " HEIGHT=",ZFF2
	.I ZFF?1"CL".E D
	..W " COLOR=",ZFF3
	.I ZFF?1"BC".E D
	..W " BGCOLOR=",ZFF3
	.I ZFF?1"BO".E D
	..W " BORDER=",ZFF3
	.I ZFF?1"CS".E D
	..W " COLSPAN=""",ZFF3,""""
	.I ZFF?1"CP".E D
	..W " CELLPADDING=""",ZFF3,""""
	.I ZFF?1"CA".E D
	..W " CELLSPACING=""",ZFF3,""""
	.I ZFF?1"BG".E D
	..S ZFF3=$TR(ZFF3,"#","/")
	..W " BACKGROUND=""",ZFF3,""""
	.I ZFF?1"RS".E D
	..W " ROWSPAN="_ZFF3
	.I ZFF?1"RC".E D
	..W " BORDERCOLOR=""",ZFF3,""""
	.I ZFF?1"LM".E D
	..W " LEFTMARGIN=""",ZFF3,""""
	.I ZFF?1"TM".E D
	..W " TOPMARGIN=""",ZFF3,""""
	.I ZFF?1"RM".E D
	..W " RIGHTMARGIN=""",ZFF3,""""
	.I ZFF?1"MW".E D
	..W " MARGINWIDTH=""",ZFF3,""""
	.I ZFF?1"MH".E D
	..W " MARGINHEIGHT=""",ZFF3,""""
	.I ZFF?1"LS".E D
	..W " CLASS=""",ZFF3,""""
	.I ZFF?1"ST".E D
	..W " STYLE=""",ZFF3,""""
	.I ZFF?1"LN".E D
	..W " LINK=""",ZFF3,""""
	.I ZFF?1"LV".E D
	..W " VLINK=""",ZFF3,""""
	.I ZFF?1"LA".E D
	..W " ALINK=""",ZFF3,""""
	.I ZFF?1"NA".E D
	..W " NAME=""",ZFF3,""""
	.I ZFF?1"DS".E D
	..W " DISABLED"
	.I ZFF?1"DI".E D
	..W " DIR=""",ZFF3,""""
	.I ZFF?1"NB".E D
	..W " NOBR"
	.I ZFF?1"OC".E D  ;BLOCK SAVE IMAGE IN I.E. ICON
	..W " oncontextmenu=""return false"""
	.I ZFF?1"RE".E D
	..W " rel=""",ZFF3,""""
	.I ZFF?1"PH".E D
	..W " placeholder=""",ZFF3,""""
	Q
H(A)	W "<H"_A_">" Q
ENDH(A)	W "</H"_A_">" Q
	;
WOR(A)	;
	W !,"<!-- Es Warning: "_A_" -->",!
	Q
FIX	;
	I '$D(%GEN("BRO")) Q
	I $D(VAR),VAR["EEE" Q
	S DP=$$RWINH^%ESWSE(DP,0)
	Q
HEB	;
	I '%DLG Q
	I $$ISIE Q  ; NO FOR I.E.
	I $$BVER'<5 S TEXT=$$REV(TEXT) Q
	W "<FONT FACE=GLOBES>"
	Q
HEB1	;
	I '%DLG Q
	I $$ISIE Q  ; NO FOR I.E.
	I $D(VAR),VAR["EEE" Q
	W "<FONT FACE=""Arial (Hebrew)"">"
	Q
ENDHEB	;
ENDHEB1	;
	I $$ISIE Q  ; NO FOR I.E.
	D ENDFONT()
	Q
TEXT(TEXT) ;
	N VP
	S VP=TEXT
	I $$ISIE S VP=$$RWINH^%ESWSE(VP,0)
	I $$ISCHROME S VP=$$RWINH^%ESWSE(VP,0)
	W " VALUE="_$$G(VP)
	Q
RESET(TEXT) ;
	D HEB
	W !?($$LEV),"<INPUT"
	W " TYPE=RESET"
	D TEXT($G(TEXT))
	W ">"
	D ENDHEB
	Q
BUT(VAR,TEXT,JS,%ST,FF) ;
	D HEB
	;W !?($$LEV),"<INPUT"
	W "<INPUT"
	W " TYPE=SUBMIT"
	W " NAME="_VAR
	I $L($G(FF)) D AT
	D TEXT($G(TEXT))
	I $L($G(JS)) D JS
	I $L($G(%ST)) D %ST
	W ">"
	D ENDHEB
	Q
aBUTI(VAR,IMG,VAL,ALT) ;
	W !?($$LEV),"<BUTTON"
	W " TYPE=SUBMIT"
	W " NAME="""_VAR_""""
	D TEXT($G(VAL))
	W ">"
	W "<IMG"
	W " SRC="""_IMG_""""
	W " BORDER=0"
	I $L($G(ALT)) D
	.I $$ISIE S ALT=$$RWINH^%ESWSE(ALT,0)
	.W " ALT="""_ALT_""""
	W ">"
	W "</BUTTON>"
	Q
BUTI(VAR,IMG,TEXT,ALT,KEY,IMG2) ;
	W !?($$LEV),"<input"
	W " TYPE=IMAGE"
	W " BORDER=0"
	W " NAME="_VAR
	I $L($G(KEY)) W " ACCESSKEY="""_KEY_""""
	W " SRC="""_IMG_""""
	D TEXT($G(TEXT))
	I $L($G(ALT)) D
	.I $$ISIE S ALT=$$RWINH^%ESWSE(ALT,0)
	.W " ALT="""_ALT_""""
	.W " TITLE="""_ALT_""""
	I $L($G(IMG2)) D
	.W " OnMouseOver='document.getElementsByName("""_VAR_""")[0].src="""_IMG2_"""' "
	.W " OnMouseOut='document.getElementsByName("""_VAR_""")[0].src="""_IMG_"""' "
	W ">"
	Q
BUTS(TEXT,JS) ;
	D HEB
	W !?($$LEV),"<input"
	W " TYPE=BUTTON"
	D TEXT(TEXT)
	I $L($G(JS)) W " "_JS
	W ">"
	D ENDHEB
	Q       
VALUE(VAR) ;
	W !?($$LEV),"<INPUT"
	W " TYPE=HIDDEN"
	W " NAME="_VAR
	W " VALUE="_$$G(@VAR)
	W ">"
	Q
HIDDEN(VAR,VAL) ;
	W !?($$LEV),"<INPUT"
	W " TYPE=HIDDEN"
	W " NAME="_VAR
	W " VALUE="""_VAL_""""
	W ">"
	Q
G(A)	; A -> "A" OR 'A'
	N G S G=""""
	I A[G S G="'"
	Q G_A_G
	Q
INPUT(VAR,DEF,SIZ,MAXLEN,COM,%EV,%ST,FF) ;
	S COM=$G(COM)
	D HEB1
	;W !?($$LEV),"<INPUT"
	W "<INPUT"
	W " TYPE=TEXT"
	W " NAME="""_VAR_""""
	N DP S DP=$G(DEF) D FIX
	I $L($G(FF)) D AT
	I $L($G(DEF)) W " VALUE="_$$G(DP)
	I $L($G(SIZ)) W " SIZE="_SIZ
	I $L($G(MAXLEN)) W " MAXLENGTH="_MAXLEN
	I COM["RTL" W " STYLE=""COLOR:GREEN;DIRECTION:RTL"""
	D %EV
	D %ST
	W ">"
	D ENDHEB
	Q
PASS(VAR,DEF,SIZ,MAXLEN) ;
	D HEB1
	W !?($$LEV),"<INPUT"
	W " TYPE=PASSWORD"
	W " NAME="_VAR
	I $L($G(DEF)) W " VALUE="_$$G(DEF)
	I $L($G(SIZ)) W " SIZE="_SIZ
	I $L($G(MAXLEN)) W " MAXLEN="_MAXLEN
	W ">"
	D ENDHEB
	Q
FILE(VAR,DEF,SIZ,MAXLEN) ;
	W !?($$LEV),"<INPUT"
	W " TYPE=FILE"
	W " NAME="_VAR
	I $L($G(DEF)) W " VALUE="_$$G(DEF)
	I $L($G(SIZ)) W " SIZE="_SIZ
	I $L($G(MAXLEN)) W " MAXLEN="_MAXLEN
	W ">"
	Q
NEWP(FF) ;
	W !?($$LEV),"<P"
	D AT
	W ">"
	Q
ENDP()	W "</P>"
CENTER() W "<CENTER>" Q
ENDCENTER() W "</CENTER>" Q
	Q
LOGO	;
	W !
	D COLOR("RED"),W(">")
	D COLOR("BLUE"),W(">")
	D COLOR("YELLOW"),W(">")
	D COLOR("GREEN"),W(">")
	D COLOR("BROWN"),W(">")
	D ENDCOLOR()
	D ENDCOLOR()
	D ENDCOLOR()
	D ENDCOLOR()
	Q
DD(%)	;
	I $D(@%)>1 D WWEB1 Q
	W "<BR>"_%_": *"
	I $D(@%)#2 W $G(@%)
	I '$D(@%) W "(UNDEF)"
	W "*<BR>"
	Q
WWEB1	;
	W "<TABLE BGCOLOR=PINK><TR><TD><PRE>"
	ZW @%
	W "</PRE></TD></TR></TABLE>"
	Q
BVER()	Q $G(%GEN("VER"))
ISIE()	Q $G(%GEN("BRO"))=2
ISCHROME() Q $G(%GEN("FVER"))?1"Chrome".E
ISNS()	Q $G(%GEN("BRO"))=1
SP()	Q "&nbsp;"
DDL(DGLO,VAR,DEF,MORE,VDEF,OPT1,%ST,%EV) ;
	N VP,VK
	S OPT1=$G(OPT1)
	D HEB1
	W !?($$LEV),"<SELECT"
	I $L($G(VAR)) W " NAME="""_VAR_""""
	I $L($G(MORE)) W " "_MORE
	I OPT1["RTL" W " DIR=RTL"
	I OPT1["SUB" D SUBONC^%ESLIBJ
	D %ST
	D %EV
	W ">"
	S %LEV=%LEV+1
	D LOOP
	S %LEV=%LEV-1
	W !?($$LEV),"</SELECT>"
	D ENDHEB
	Q
LOOP	;
	D LOOPDEF
	N I S I=""
	F  S I=$O(@DGLO@(I)) Q:I=""  D LOOP1
	Q
LOOP1	;
	N V S V=$G(@DGLO@(I))   
	S DP=V I OPT1["VPIC" S DP=$P(DP,D,1)
	S VK=I
	I OPT1["DISP=" S DP=$P(V,D,+$P(OPT1,"DISP=",2))
	I OPT1["VARP=" S VK=$P(V,D,+$P(OPT1,"VARP=",2))
	I OPT1["DISS=" S DP=$P(I,D,+$P(OPT1,"DISS=",2))
	I OPT1["DIKK=" S VK=$P(I,D,+$P(OPT1,"DIKK=",2))
	I OPT1["DISK" S DP=I
	D OPT(VK,DP)
	Q
OPT(VK,DP) ;
	D FIX ;(DP)
	W !?($$LEV),"<OPTION"
	W " VALUE="_$$G(VK)
	I $G(DEF)=VK W " SELECTED"
	W ">" 
	D LOOP2
	W "</OPTION>"
	Q
LOOP2	;
	D W(DP)
	Q
LOOPDEF	;
	D OPT("",$G(VDEF))
	Q
IMG(P,ALT,FF) ;
	W !?($$LEV),"<IMG"
	W " SRC="""_P_""""
	I $L($G(ALT)) W " ALT=""" D W(ALT) W """"
	I $L($G(FF)) D AT
	W ">"
	Q
LINK(LINK,DESC,%ST,MORE,OPT) ;
	W !?($$LEV),"<A "
	W " HREF="""_LINK_""""
	I $L($G(%ST)) D %ST
	I $L($G(MORE)) W " "_MORE
	W ">"
	D
	.I $G(OPT)["IMG" D IMG(DESC,"","BO0") Q
	.D W(DESC)
	W "</A>"
	Q               
KIL(VAR) ;
	I VAR["." Q
	I VAR[D Q
	D KIL^%ESWSE(VAR)
	K @VAR
	Q
RADIO(VAR,VAL,DEF,MORE,%ST,%EV) ;
	D KIL(VAR)
	W !?($$LEV),"<INPUT"
	W " TYPE=RADIO"
	W " NAME="""_VAR_""""
	W " VALUE="_$$G(VAL)
	I $G(DEF) W " CHECKED"
	I $L($G(MORE)) W " "_MORE
	D %ST
	D %EV
	W ">"
	Q
CBOX(VAR,VAL,DEF,COM,MORE) ;
	;W !?($$LEV),"<INPUT"
	W "<INPUT"
	W " TYPE=CHECKBOX"
	W " NAME="_VAR
	W " VALUE="_$$G(VAL)
	I $G(DEF) W " CHECKED"
	I $L($G(COM)) D COM
	I $L($G(MORE)) W " "_MORE
	W ">"
	Q
COM	;
	I COM["SUBMIT" W " OnClick=""javascript:submit();"""
	Q
L1	;
	S ID=^%ESV("LAST","ID")
	N I S I=""
	F  S I=$O(^%ESV(9,ID,"A",I)) Q:I=""  D
	.W !,I," = "_$G(^(I))
	W !,"========[ "_ID_" ]==========="
	Q
BOLD()	W "<B>" Q
ENDBOLD() W "</B>" Q
BODY(FF,%ST) ;
	W !?($$LEV),"<BODY" D AT
	I $L($G(%ST)) D %ST
	W ">"
	Q
ENDBODY() ;
	W !?($$LEV),"</BODY>"
	Q
JS	;
	N ZFF2
	I JS?1"CF".E D
	.S ZFF2=$E(JS,3,999)
	.W " OnClick=""javascript:"_ZFF2_";return false;"""
	I JS?1"CC".E D
	.S ZFF2=$E(JS,3,999)
	.W " OnClick=""javascript:return "_ZFF2_";"""
	Q
%EV	; Events
	I '$L($G(%EV)) Q
	N A
	S A=$$EV(%EV)
	I $L(A) W " "_A
	Q
EV(FF)	;
	N A S A=""
	N ZFF,G,ZFF2,ZFF3,ZFF4
	F G=1:1:$L(FF,"/") D
	.S ZFF=$P(FF,"/",G)
	.I ZFF="" Q
	.S ZFF2=$E(ZFF,2,999)
	.S ZFF3=$E(ZFF,3,999)
	.S ZFF4=$E(ZFF,4,999)
	.I ZFF2="" Q
	.I ZFF?1"CH".E D
	..S A=A_" OnChange="""_ZFF3_""""
	.I ZFF?1"OE".E D
	..S A=A_" onkeypress=""if(event.keyCode==13) "_ZFF3_""""
	.I ZFF?1"SL".E D
	..S A=A_" OnSelect="""_ZFF3_""""
	.I ZFF?1"CL".E D
	..S A=A_" OnClick="""_ZFF3_""""
	.I ZFF?1"OMI".E D
	..S A=A_" OnMouseOver="""_ZFF4_""""
	.I ZFF?1"OMO".E D
	..S A=A_" OnMouseOut="""_ZFF4_""""
	.I ZFF?1"OF".E D
	..S A=A_" OnFocus="""_ZFF3_""""
	Q A
%ST	; STYLE
	I '$L($G(%ST)) Q
	N A
	S A=$$ST(%ST)
	I $L(A) W " "_A
	Q
ST(FF)	;
	N A S A=""
	N ZFF,G,ZFF2,ZFF3,ZFF4
	F G=1:1:$L(FF,"/") D
	.S ZFF=$P(FF,"/",G)
	.I ZFF="" Q
	.S ZFF2=$E(ZFF,2,999)
	.S ZFF3=$E(ZFF,3,999)
	.S ZFF4=$E(ZFF,4,999)
	.I ZFF2="" Q
	.I ZFF?1"CL".E D
	..S A=A_"COLOR:"_ZFF3_";"
	.I ZFF?1"FL".E D
	..S A=A_"FLOAT:"_ZFF3_";"
	.I ZFF?1"W".E D
	..S A=A_"WIDTH:"_ZFF2_";"
	.I ZFF?1"H".E D
	..S A=A_"HEIGHT:"_ZFF2_";"
	.I ZFF?1"FS".E D
	..S A=A_"FONT-SIZE:"_ZFF3_"pt;"
	.I ZFF?1"FF".E D
	..S A=A_"FONT-FAMILY:"_ZFF3_";"
	.I ZFF?1"FW".E D
	..S A=A_"FONT-WEIGHT:"_ZFF3_";"
	.I ZFF?1"TA".E D
	..S A=A_"TEXT-ALIGN:"_ZFF3_";"
	.I ZFF?1"TD".E D
	..S A=A_"TEXT-DECORATION:"_ZFF3_";"
	.I ZFF?1"BL".E D
	..S A=A_"border-collapse:collapse;"
	.I ZFF?1"BTW".E D
	..S A=A_"border-top-width:"_ZFF4_";"
	.I ZFF?1"BBW".E D
	..S A=A_"border-bottom-width:"_ZFF4_";"
	.I ZFF?1"BRW".E D
	..S A=A_"border-right-width:"_ZFF4_";"
	.I ZFF?1"BLW".E D
	..S A=A_"border-left-width:"_ZFF4_";"
	.I ZFF?1"BS".E D
	..S A=A_"border-style:"_ZFF3_";"
	.I ZFF?1"BC".E D
	..S A=A_"border-color:"_ZFF3_";"
	.I ZFF?1"BP".E D
	..S A=A_"background-position:"_ZFF3_";"
	.I ZFF?1"BR".E D
	..S A=A_"background-repeat:"_ZFF3_";"
	.I ZFF?1"BG".E D
	..S A=A_"background:"_$TR(ZFF3,"#","/")_";"
	.I ZFF?1"GL".E D
	..S A=A_"background-color:"_ZFF3_";"
	.I ZFF?1"VS".E D
	..S A=A_"visibility:"_ZFF3_";"
	.I ZFF?1"POS".E D
	..S A=A_"position:"_ZFF4_";"
	.I ZFF?1"YY".E D
	..S A=A_"top:"_ZFF3_";"
	.I ZFF?1"XX".E D
	..S A=A_"left:"_ZFF3_";"
	.I ZFF?1"OV".E D
	..S A=A_"overflow:"_ZFF3_";"
	.I ZFF?1"BDL".E D
	..S A=A_"border-left:"_ZFF4_";"
	.I ZFF?1"BDR".E D
	..S A=A_"border-right:"_ZFF4_";"
	I $L(A) S A=" style="""_A_""""
	Q A
TEXTAREA(VAR,DEF,ROWS,COLS,MORE) ;
	D HEB1 ;S VAR=VAR_".z"
	W !?($$LEV),"<TEXTAREA"
	I $L($G(VAR)) W " NAME="""_VAR_""""
	I $L($G(ROWS)) W " ROWS="_ROWS
	I $L($G(COLS)) W " COLS="_COLS
	I $L($G(MORE)) W " "_MORE
	W ">"
	I $D(DEF)>2 D  Q  ;IF HAVE PREV VALUE OF TEXT AREA
	.N DP S DP=$$V2TE^%ESLJ(.DEF,1) ; (,1 FOR DISPLAY
	N DP S DP=$G(DEF) D FIX
	W DP
	Q
ENDT()	;
	W "</TEXTAREA>"
	D ENDHEB
	Q
VER()	Q "2.07"
DAYS(VAR,DEF) ;
	I '$L($G(VAR)) S VAR="DAY"
	W !?($$LEV),"<SELECT"
	I $L($G(VAR)) W " NAME="""_VAR_""""
	W ">"
	N I F I=1:1:31 W "<OPTION>"_I
	W "</OPTION>"
	W !?($$LEV),"</SELECT>"
	Q
MONS(VAR,DEF) ;
	I '$L($G(VAR)) S VAR="MON"
	W !?($$LEV),"<SELECT"
	I $L($G(VAR)) W " NAME="""_VAR_""""
	W ">"
	N I F I=1:1:12 W "<OPTION>"_I
	W "</OPTION>"
	W !?($$LEV),"</SELECT>"
	Q
YEARS(VAR,DEF,FROM,TO) ;
	I '$L($G(VAR)) S VAR="YEAR"
	I '$L($G(FROM)) S FROM=$P($$NOW^%ESD,"/",3)
	I '$L($G(TO)) S TO=$P($$NOW^%ESD,"/",3)+2
	I TO?1"+".E S TO=FROM+$E(TO,2,99)
	W !?($$LEV),"<SELECT"
	I $L($G(VAR)) W " NAME="""_VAR_""""
	W ">"
	N I F I=FROM:1:TO W "<OPTION>"_I
	W "</OPTION>"
	W !?($$LEV),"</SELECT>"
	Q
MAILUS(MAIL,TEXT,%ST) ;
	I $L($G(TEXT))=0 S TEXT=MAIL
	W "<A HREF=""mailto:"_MAIL_""""
	D %ST
	W ">"
	D W(TEXT)
	W "</A>"
	Q
REV(A)	;
	N C,B,I
	S B=""
	F I=1:1:$L(A) S C=$E(A,I),CA=$A(C) D
	.I C=" " S B=" "_B_" " Q
	.I CA>$A("ú")!(CA<$A("à")) S B=B_C Q
	.S B=C_B
	Q B
DONEXT(%N1) ; IF $ZN="RACE3" -> D DO("^RACE4")
	N %N S %N=""
	I $E(%N1,$L(%N1))?1N S %N=$E(%N1,$L(%N1))_%N,%N1=$E(%N1,0,$L(%N1)-1)
	I $E(%N1,$L(%N1))?1N S %N=$E(%N1,$L(%N1))_%N,%N1=$E(%N1,0,$L(%N1)-1)
	D DO("^"_%N1_(%N+1))
	Q
TE(A,VEC) ; A ="TEXT AREA LONG TEXT"
	; VEC(1)=LINE 1
	;     2       2
	;     :
	N DL,NEWA1
	K VEC
	S A=$TR(A,"+"_$C(13)," ")
	S DL=$C(10)
	F I=1:1:$L(A,DL) D
	.S A1=$P(A,DL,I)
	.S NEWA1=$$RWINH^%ESWSE(A1,0)
	.S NEWA1=$$CUTLT^%ESS(NEWA1)
	.S NEWA1=$$REP^%ESS(NEWA1,"  "," ")
	.S VEC(I)=NEWA1
	F  S N=$ZP(VEC("")) Q:N=""  S A=VEC(N) Q:$L(A)  K VEC(N)
	Q       
TEDRAW(VEC) ;
	N A,J
	N I S I=""
	F J=0:1 S I=$O(VEC(I)) Q:I=""  D
	.S A=VEC(I)
	.S A=$$RWINH^%ESWSE(A,0)
	.I J W !
	.W A
	Q
WORD(TEXT,LEN,VEC) ; CONVERT ONE LONG HEBREW TEXT TO VECTOR OF SENTENCES
	K VEC
	N L,A,M S D="_",M=0
	S A=""
	D LOP
	;I $L(A) D PR(A)
	D PR(A)
	Q
LOP	;
	S L=$L(TEXT," ")
	S A=$P(TEXT," ",L)_" "_A
TG	I A?.E1" " S A=$E(A,0,$L(A)-1) G TG
	Q:L=1
	S TEXT=$P(TEXT," ",0,L-1)
	S L=$L(TEXT," ")
	I $L(A_" "_$P(TEXT," ",L))>LEN D PR(A) S A=""
	G LOP
	Q
PR(A)	;
	S M=M+1
	S VEC(M)=A                                            
	Q
HWRITE(TEXT,LEN) ;
	N VEC
	D WORD(TEXT,LEN,.VEC)
	N I S I=""
	F  S I=$O(VEC(I)) Q:I=""  D W(VEC(I)),BR()
	Q
WR(A)	;
	D D^%EST0(A)
	Q
WRS(A)	Q $$REL^%EST0(A)
	Q
NEWDIV(FF,%ST) ;
	W !?($$LEV),"<DIV"
	D AT
	D %ST
	W ">"
	S %LEV=%LEV+1
	Q
ENDDIV() ;       
	S %LEV=%LEV-1
	W !?($$LEV),"</DIV>"
	Q
ALT	;
	I '$L($G(ALT)) Q
	W " TITLE="""
	D W(ALT)
	W """"
	Q
LEG(TX,LAB) ;
	W "<FIELDSET><LEGEND>"
	D W(TX)
	W "</LEGEND>"
	X LAB
	W "</FIELDSET>"
	Q
