ZSTU	; (C) ELI SMADAR
	; STARTUP PROCEDURE EVERY TIME GTM IS STARTED
	K ^%WJ ; job exame
	S JB=$J_":ZSTU"
	S CUST=^CURRENT("NAME") ; "DEV"
	D MFRAME
	D CLEAN   ; CLEAN ^W
	D CLNESV  ; CLEAN ^%ESV(9,sessions)
	I CUST="DEV" w !,"run hold ...."
	I CUST="DEV" D JOB^%ZU("MGR","HOLD^ZSTU",0)
	w !,"run bg as root ..."
	D JOB^%ZU("MGR","BG^%ESROOT",0)
	I CUST="DEV" w !,"run daily ..."
	I CUST="DEV" D JOB^%ZU("FOR","^DAILY",0)
	Q
MFRAME ; init framework (c) eli smadar
	I $$PIPE^%ESF("uname -a | grep buntu|wc -l") S ^CURRENT("OS.TYPE")="U" ; Ubuntu
	E  S ^CURRENT("OS.TYPE")="C" ; Centos
	Q
CLEAN ;
	S U=""
	F  S U=$O(^%ZUCI(U)) Q:U=""  D U
	Q
CLNESV ;
	K STAY
	S X=""
	F  S X=$O(^%ESV(9,X)) Q:X=""  D
	.I $D(^(X,"A"))#2=0 K ^%ESV(9,X) W "." Q
	.I $H-^("A")>14     K ^%ESV(9,X) W "K" Q
	.I $I(STAY) W "S" ;W !,^("A")
	W !,"STAY="_$G(STAY)
	Q
U	;
	K ^[U]W
	Q
HOLD	;
	; STAY IN BG ALL THE TIME
	; WILL HANDLE THE LOCKS
	ZA ^HOLD
	F  H 60 I $P($$NOW^%ESD,":",2)="00" D HOURLY
	Q
HOURLY ;
	D JOB^%ZU("FOR","HOURLY^DAILY",0)
	D JOB^%ZU("FOR","^LOCKS",0)
	Q
