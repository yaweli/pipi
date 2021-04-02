%ESGP ; GPIO CONTROL
	Q
ACTIV(GL1) ; RETURN ACTIVE PORTS
	S ERR=""
	D LIST^%ESF("/sys/class/gpio/gpio*",GL1)
	N I S I="" F  S I=$O(@GL1@(I)) Q:I=""  S ^(I)=$P(I,"/gpio/gpio",2)
	Q
DIR(GP) ;
	Q $$C1^%ESF("cat /sys/class/gpio/gpio"_GP_"/direction")
VAL(GP) ;
	Q $$C1^%ESF("cat /sys/class/gpio/gpio"_GP_"/value")
SETVAL(GP,ONE) ;
	S ERR=""
	I ONE'=1,ONE'=0 S ERR="ERROR MUST 1/0" Q
	D COM^%ESF("echo -n """"_ONE_"""" > /sys/class/gpio/gpio"_GP_"/value")
	Q
SETDIR(GP,DIR) ;
	S ERR=""
	I DIR'="in",DIR'="out" S ERR="ERROR MUST in/out" Q
	D COM^%ESF("echo -n """"_DIR_"""" > /sys/class/gpio/gpio"_GP_"/direction")
	Q
EXP(GP) ; START GPIO
	S ERR=""
	D COM^%ESF("echo -n """"_GP_"""" > /sys/class/gpio/export")
	Q
UNEXP(GP) ; STOP GPIO
	S ERR=""
	D COM^%ESF("echo -n """"_GP_"""" > /sys/class/gpio/unexport")
	Q


