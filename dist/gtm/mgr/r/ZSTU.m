ZSTU	; (C) ELI SMADAR
	; STARTUP PROCEDURE EVERY TIME GTM IS STARTED
	K ^%WJ ; job exame
	S JB=$J_":ZSTU"
	S CUST=^CURRENT("NAME") ; "DEV"
	D MFRAME
	D CLEAN   ; CLEAN ^W
	D CLNESV  ; CLEAN ^%ESV(9,sessions)
	I CUST="DEV" w !,"run recount...."
	I CUST="DEV" I $D(^["FOR"]SRC) D JOB^%ZU("FOR","RECOUNT^FORML",0) ; COUNT AMOUNT OF RECORDS EACH SOURCE 4M ^SRC HAVE
	I CUST="DEV" w !,"run hold ...."
	I CUST="DEV" D JOB^%ZU("MGR","HOLD^ZSTU",0)
	w !,"run bg as root ..."
	D JOB^%ZU("MGR","BG^%ESROOT",0)
	I CUST="DEV" w !,"run daily ..."
	I CUST="DEV" D JOB^%ZU("FOR","^DAILY",0)
	I CUST="DEV" w !,"run PULL ..."
	I CUST="DEV" D JOB^%ZU("FOR","^PULL",0)
	I CUST="DEV" w !,"run clean snap ..."
	I CUST="DEV" D JOB^%ZU("FOR","CSNAP^AWS",0)
	I CUST="DEV" w !,"run CORONA LAYER ..." ; DETAIELD
	I CUST="DEV" D JOB^%ZU("FOR","CORONABG^SRC034",0)
	;shutdown;I CUST="DEV" w !,"run CORONA1"
	;I CUST="DEV" D JOB^%ZU("FOR","BG^SRC036",0)
	I CUST="DEV" w !,"run CORONA3"
	I CUST="DEV" D JOB^%ZU("FOR","BG^SRC037",0)
	;I CUST="DEV" W !,"BG WAZE"
	;I CUST="DEV" D JOB^%ZU("ELI","BG^WAZE",0)
	I CUST="DEV" W !,"COUNTER"
	I CUST="DEV" D JOB^%ZU("ELI","^COUNT",0)
	I CUST="DEV" W !,"GET VTOOL LICENSE PLATE INFO"
	I CUST="DEV"!(CUST="PROD") D JOB^%ZU("FOR","DAILY^TABVTOOL",0)
	I CUST="DEV"!(CUST="PROD") D JOB^%ZU("FOR","BG^FORDIG",0)
	I CUST="DEV"!(CUST="PROD") D JOB^%ZU("FOR","CLN^FORDIGM",0)
	I CUST="DEV" W !,"LOG"
	I CUST="DEV" D JOB^%ZU("FOR","L1^LOGBG","") ; ACCESS_LOG
	I CUST="DEV" D JOB^%ZU("FOR","L2^LOGBG","") ; ERROR_LOG
	I CUST="DEV" D JOB^%ZU("FOR","BG^FILE","")  ; Delete link directory
	I CUST="DEV" D JOB^%ZU("FOR","BG^EVN","")   ; load images EXIF data
	I CUST="DEV" D JOB^%ZU("FOR","ORDBG^FORMAP","") ; 4MAP Q ORDER MANAGER
	I CUST="DEV" D JOB^%ZU("FOR","^LOCKS","") ; WATCH DOG
	I CUST="DEV" w !,"run AI at bg ..." ; FOR LANDMINES
	I CUST="DEV" D JOB^%ZU("FOR","JOB^AI",0) ;
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
