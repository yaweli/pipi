### accessing the GPIO on the pi
Raspberry pi computers have pins you can connect and attach a hardware , Leds lights , engines , sensors



[Read more for support micro computers](pi.MD)

```html
GPIO	;
	S GL=$NA(^W(JB,11)) K @GL
	D ACTIV(GL)
	w "<TABLE BORDER=2>" D  W "</TABLE>"
	.W "<TR><TH>GPIO</TH><TH>DIR</TH><TH>Current Value</TH><TR>"
	.FOR I IN @GL D
	..S X=^(I)
	..W "<TR>" D  W "</TR>"
	...W "<TD>",X,"</TD>" ; /sys/class/gpio/gpio14 
	...W "<TD>",$$DIR(X),"</TD>" ; in / out
	...W "<TD>",$$VAL(X),"</TD>" ; 0/1
	Q
BACK ;
	D GO^%ESLJX("start.html")
	Q
FLASH ;  FLASH THE RED LIGHT - RUN THIS IN JOB CMD
	;
	D EXP(14)
	D SETDIR(14,"out") H 1
	F  D FLASH1
	Q
FLASH1	;
	D SETVAL(14,1) H 1
	D SETVAL(14,0) H 1
	Q
	#INCLUDE %ESGPI
	Q
	;
</m>

<HR>
<button type="button" class="btn btn-primary" onclick="mLabel('BACK','b')">Back</button>

<BR>
to make the red light on the pi flash every second<br>
bash script code example:
<pre>
#!/bin/sh
cd /sys/class/gpio
echo "14" > unexport
echo "14" > export
cd gpio14
echo out > direction
sleep 1
while true
do
        echo "1" > value
        sleep 1
        echo "0" > value
        sleep 1
done
```



![](https://github.com/yaweli/pipi/blob/master/led.png)

[see it works:](https://drive.google.com/file/d/1-1Cs0CPVFwJA_8xEhxe5D6U4bHGuoUnG/view?usp=sharing)


One way is to run a bash script , to flash the light every second , also add it to the linux startup (using /etc/rc.local) the pi will flash the light forever

###  gpio support:


With %ESGP you can control the gpio pin , read there value and set a new value


action|description|same as command
--|--|---
$$VAL(gpio)|get the value or direction for each gpio|cat value
$$DIR(gpio)|get the direction for each gpio|cat direction
D ACTIV(GLO)|get a list of all live gpio|ls gpio*
D SETDIR(gpio,"out")|set the value of the direction of the pin|echo out>direction
D SETVAL(gpip,"1")|set the value of the pin|echo "1" > value
D EXP(gpio)|start gpio pin by export function|echo "14">export
D UNEXP(gpio)|stop gpio pin by export function|echo "14">unexport

[learn more about GPIO](https://www.makeuseof.com/tag/raspberry-pi-gpio-pins-guide/)
