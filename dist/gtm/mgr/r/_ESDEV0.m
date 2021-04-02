%ESDEV0	; main entry point , mumps framework , eli smadar (c) ; DEV0
	;
	; FIRST PROG ON GTM ON ELI PLATFORM
	; UCI: ELI
	; CALLED BY http://127.0.0.1/proj/dev/
	N F
	S JB=$$NEWJB
	S ^W(JB,0)=$H_D_"ENTER"
	S LUCI=$$LOWER^%ESS(REDUCI)
	D SET
	D ^%ESDEV(F)
	Q
SET ;
	N A,DIF,START
	;DONT NEW DIR,HOME
	;zwr
	; VR("Referer")="http://127.0.0.1/proj/dev/"
	S A=VR("Referer") ;="http://127.0.0.1/proj/dev/"
	S DIR=$P(A,"/",4,99) ;                ^^^^^^^^^^^^^^^
	S DIF=$P(DIR,"/",$L(DIR,"/")) ; en.html
	S $P(DIR,"/",$L(DIR,"/"))=""  ;  /var/www/html/proj/form/en.htmlstart.html 
	S HOME="/var/www/html/"
	S START="start.html"
	I DIF'="" S START=$P(DIF,".",1)_"start.html"
	S F=HOME_DIR_START
	Q
	;
	;S ^%ESV(2,"INTERNET","PROJ/DEV/")="^DEV0" ; ROUTNEI
	;FOR UCI SEE THE HTML
 ;HTML start page
 ;
 ;<Form action=/cgi-bin/es>
 ;<input type=submit name=a value=Start>
 ;<input type=hidden name=REDUCI value=ELI> <!-- redirect proj to uci -->
 ;</Form>
 ;         
 ;
 ;http://127.0.0.1/proj/dev/
	Q
NEWJB()	;
	N B,X,C
	S B=""
	F X=1:1:10 S C=$C($A("A")+$R(26)) S B=B_C
	F X=1:1:10 S C=$C($A("a")+$R(26)) S B=B_C
	F X=1:1:3 S C=$R(10) S B=B_C
	Q B
