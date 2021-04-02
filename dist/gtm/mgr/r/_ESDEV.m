%ESDEV(F)	; COMPILE SINGLE HTML FILE
	; VER 2.04
	; (C) ELI SMADAR
	N R,%GL
	S $ET="S ^%LASTE=$ZS U 0 W !,$ZS Q"
	I $I(%PAGE)
	S %GL=$NA(^W(JB,"P"_%PAGE,"F"))
	D G^%ESF(F,%GL) I ERR'="" W ERR Q
	S RUT=$RE($P($RE(F),"/",1))       ; start.html
	S RUM=$$CAPS^%ESS($P(RUT,".",1))  ; START
	N %SUPER I $D(^MES(2,"S:"_RUT)) S %SUPER=1
	;
	N M,I,LN,A,MJ,ATSOF,%I
	;
	S M=0,%I="",MJ=0
	F  S %I=$O(@%GL@(%I)) Q:%I=""  D 1
	D SOF
	Q
1	;
	S A=^(%I),A=$tr(A,$c(13))
	N %I,%GL
	I M=0 I A?." "1"<m>".E   D STARTM    S M=1 Q
	I M=0 I A?." "1"<p4m>".E D STARTP    S M=2 Q
	I M=0 I A?." "1"<m#".E   D HASH            Q
	I M=0 W A,! Q
	I M=1 I A?." "1"</m>".E  D STOPM     S M=0 Q
	I M=1 D INM Q
	I M=2 I A?." "1"</p4m>".E D STOPP     S M=0 Q
	I M=2 D INP Q
	Q
INM	;
	S ^W(JB,"X1",$I(LN))=A 
	I $$DEV W $TR(A,"<>","()"),!
	Q
INP ;
	S ^W(JB,"X2",$I(LN))=A 
	I $$DEV W $TR(A,"<>","()"),!
	Q
STARTM	;
	K ^W(JB,"X1") S LN=0
	W !,"<!-- START M CODE ",!
	Q
STARTP ;
	K ^W(JB,"X2") S LN=0
	W !,"<!-- START PYTHON 4 MUMPS CODE ",!
	Q
STOPP ;
	S M=0 
	; ** run **
	D CMPL^%ESRLP($NA(^W(JB,"X1")),"DEV") ;->@GLO,CS
	;
	S R="mes"_CS
	I $D(^MES(10,R)) D PRUN Q  ; ** SECOND TIME, RUN SAME ROUTINE **
	;
	; ** FIRST TIME = COMPIL NEW ROUTINE **
	K ^W(JB,"M")
	M ^W(JB,"M")=@GLO
	;
	N F,FO,dir
	s dir="/gtm/"_LUCI_"/p/"
	S F=dir_R_".py3"
	S FO=dir_R_".pyc"
	;W " FILE="_F
	D P^%ESF($NA(^W(JB,"M")),F)
	D COM^%ESF("chmod 775 "_F)
	D COM^%ESF("chgrp gtm "_F)
	D COM^%ESF("chmod 775 "_FO)
	D COM^%ESF("chgrp gtm "_FO)
	H 0
	;ZL R
	zsy "cd "_dir_" ; /usr/bin/python3.6 -m compileall "_F
	zsy "cd "_dir_" ; cp __pycache__/"_FO_" .."
	zsy "cd "_dir_" ; rmdir __pycache__"
	H 0
	;
	; clean all old
	N I S I=""
	F  S I=$O(^MES(11,RUM,I)) Q:I=""  D  ; I="mes12345678" ; RUM="AI"
	.N A,F S A=^(I),F=$P(A,"_",4) ; A="65324,62490_HJQIKHPPECldyrlvgils778_AI"
	.;s ^LOG($I(^LOG))=$H_"_try erase RUM="_RUM_" I="_I_" F="_F
	.N ERR I F="" S F=$P(^MES(10,I),"_",4)
	.;s ^LOG($I(^LOG))=$H_"_erase RUM="_RUM_" I="_I_" F="_F
	.D RM^%ESF(F)
	.D RM^%ESF($P(F,".",1)_".pyc")
	.S ^MES("H",11,RUM,I)=^MES(11,RUM,I)
	.S ^MES("H",10,I)=^MES(10,I)
	.K ^MES(11,RUM,I)
	.K ^MES(10,I)
	; save new
	S ^MES(10,R)=$H_"_"_JB_"_"_RUM_"_"_F
	S ^MES(11,RUM,R)=$H_"_"_JB_"_"_RUM_"_"_F
PRUN	;BBB
	w !,"(c) e.s. 2020 p4m = "_$r_" source html="_RUM
	W !," -->",!
	ZSY "/gtm/bin/p4mrun.pyc "_LUCI_" "_R
	;X "D ^"_R
	Q
STOPM	;
	S M=0 
	; ** run **
	I $$DEV s ^LOG("DEV",$I(^LOG))=$H_"_CMPL"
	D CMPL^%ESRL($NA(^W(JB,"X1")),"DEV") ;->@GLO,CS
	;
	S R="mes"_CS
	I $$DEV s ^LOG("DEV",$I(^LOG))=$H_"_R R="_R
	I $D(^MES(0,R)) D RUN Q  ; ** SECOND TIME, RUN SAME ROUTINE **
	;
	; ** FIRST TIME = COMPIL NEW ROUTINE **
	K ^W(JB,"M")
	M ^W(JB,"M")=@GLO
	;
	N F,FO
	S F="/gtm/"_LUCI_"/r/"_R_".m"
	S FO="/gtm/"_LUCI_"/r/"_R_".o"
	W " FILE="_F
	D P^%ESF($NA(^W(JB,"M")),F)
	D COM^%ESF("chmod 775 "_F)
	D COM^%ESF("chgrp gtm "_F)
	D COM^%ESF("chmod 775 "_FO)
	D COM^%ESF("chgrp gtm "_FO)
	H 0
	ZL R
	H 0
	;
	; clean all old
	N I S I=""
	F  S I=$O(^MES(1,RUM,I)) Q:I=""  D  ; I="mes12345678" ; RUM="AI"
	.N A,F S A=^(I),F=$P(A,"_",4) ; A="65324,62490_HJQIKHPPECldyrlvgils778_AI"
	.s ^LOG("DEV",$I(^LOG))=$H_"_try erase RUM="_RUM_" I="_I_" F="_F
	.N ERR I F="" S F=$P(^MES(0,I),"_",4)
	.s ^LOG("DEV",$I(^LOG))=$H_"_erase RUM="_RUM_" I="_I_" F="_F
	.D RM^%ESF(F)
	.D RM^%ESF($P(F,".",1)_".o")
	.S ^MES("H",1,RUM,I)=^MES(1,RUM,I)
	.S ^MES("H",0,I)=^MES(0,I)
	.K ^MES(1,RUM,I)
	.K ^MES(0,I)
	; save new
	S ^MES(0,R)=$H_"_"_JB_"_"_RUM_"_"_F
	S ^MES(1,RUM,R)=$H_"_"_JB_"_"_RUM_"_"_F
RUN	;BBB
	w !,"routine= "_$r_" source html="_RUM
	W !," -->",!
	X "D ^"_R
	Q
HASH ; <m#import mpak1 />  ; will import at top mpak1.start.html at end mpak1.end.html
	N GL
	I A?1"<m#import ".e D IMP Q
	Q
IMP ;
	N FF S FF=$P($P(A,"#import ",2)," ")
	D IMP1(FF)
	Q
IMP1(FF) ;
	S F1=$P(FF," from ",1)
	S F2=$P(FF," from ",2)
	S FF=F1 I F2'="" S FF=F2
	;
	I F2="" S ATSOF($I(ATSOF))=FF_".end"
	D IMP2(FF_".start")
	Q
IMP2(FF) ;
	D FULPAT
	S FF=FF_".html"
	N GL1 S GL1=$NA(^W(JB,"GL1")) K @GL1
	N ERR D G^%ESF(FF,GL1) I ERR'="" W "<BR>"_ERR Q
	N I S I="" F  S I=$O(@GL1@(I)) Q:I=""  W ^(I),!
	Q
FULPAT	;
	I FF'?1"/".E S FF=$P(F,"/",1,$L(F,"/")-1)_"/"_FF Q  ; pure name = current dir
	S FF="/var/www/html"_FF ; EX F="/proj/piz/next.html" -> /var/www/html/proj/piz/next.html
	Q
SOF	;
	D SOF1
	D SOF2
	Q
SOF2 ;
	N I S I="" F  S I=$O(ATSOF(I)) Q:I=""  D IMP2(ATSOF(I))
	Q
SOF1 ;
	;
	i '$d(R) Q
	D INITAJAX^%ESLJX
	D SET^%ESWSE("%CONT^"_R)
	S SId=SId+1
	D SUBSAV^%ESWSE("%RUT") ; SAVE ROUTINE NAME
	W !,"<script>"
	W !,"function c(a) { console.log(a);}"
	W !,"function mLabel(lab,itm) {"
	W !,"   itmId='';"
	w !,"   if(!lab.includes('^')) lab+='^"_R_"';"
	W !,"   if ( itm.id != 'undefine' ) itmId=itm.id;"
	w !,"   val='';"
	w !,"   if (typeof itm !== 'undefined') {"
	w !,"       val=itm;"
	w !,"       if (typeof itm.value !== 'undefined') {"
	w !,"           val=itm.value;"
	w !,"           if(itm.type=='checkbox' && itm.checked==false) val='off';"  ;= on/off or if have value="x" return "x"
	w !,"           }"
	w !,"   }"
	w !,"   if (val=='')  val=itm;"
	w !,"   if (val===""*ALL"") val=mAll();"
	w !,"   c('ajax lab='+lab+' val='+val+' itmid='+itmId);" 
	W !,"   callAjax('"_SId_"',lab,val,itmId);" ; see %ESLJX.m
	w !,"   c('ajax ends');"
	W !,""
	W !,"}"
	W !,"function mAll() {" ; // return all fields in the form , ex: fld1:val1/fld2:val2/...
	W !,"	var s='*all'"
	W !,"   for(i=0;i<document.forms[0].elements.length;++i) {"
	W !,"	   fff=document.forms[0].elements[i];"
	W !,"      if(fff.type=='checkbox' && fff.checked==false) continue;"
	W !,"      if(fff.type=='radio' && fff.checked==false) continue;"
	W !,"	   nam=fff.name;"
	W !,"	   if (nam!='') { "
	W !,"	      val=fff.value;"
	W !,"	      s+= '*'+nam+':'+val;"
	W !,"	      }"
	W !,"	   }"
	W !,"	return s;"
	W !,"}"
	W !,"</script>"
	Q
DEV() ; If system is no production , system is dev
	I $G(^["MGR"]CURRENT("NAME"))["DEV" Q 1
	Q 0
VER() ; 09/12/2020 - support checkbox return off/on/value
	Q