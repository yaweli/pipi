%ESRLM(F,UCI,UCI1)	; RELOAD *.MES ROUTINE FROM /m/ DIRECTORY
	;(C) 2019 ELI SMADAR (C)
	;MUMPS MACRO
	; called from /gtm/bin/reloadmes
	; 
	S $eT="S ^ELI1=$ZS Q"
	I F'?.E1".m".2l S ^ELI1="FILE "_F Q
	S RUT=$P(F,".",1) ;compile will be done by the incrone script
	D READ           Q:ERR'=""
	D CMPL^%ESRL(GL,"MES1",RUT) Q:ERR'=""
	D SAVE^%ESRL     Q:ERR'=""
	K @GL
	S RUT=$P(F,".",1) ;compile will be done by the incrone script
	ZL RUT
	zsy "chgrp gtm /gtm/"_uci_"/r/"_RUT_".*" ; m runtime code
	zsy "chmod 744 /gtm/"_uci_"/r/"_RUT_".m"
	zsy "chmod 777 /gtm/"_uci_"/r/"_RUT_".o"
	zsy "chgrp gtm /gtm/"_uci_"/mes/"_RUT_".*" ; Source m-framework code
	zsy "chmod 775 /gtm/"_uci_"/mes/"_RUT_".*"
	Q
READ	;   
	S ERR="",GL=$NA(^W(JB,"I")) K @GL
	D G^%ESF("/gtm/"_UCI1_"/mes/"_F,GL) Q:ERR'=""
	Q
VERSION() Q "1.01"
