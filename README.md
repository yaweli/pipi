# pipi
mFrame project include a full mumps framework running on the Raspberry pi
accessed by the browser (desktop or mobile) 
it's a platform to develop a web apps / desktop apps and websites with mumps as a code 
that will generate nice web ui using latest bootstap 

His big brother runs this same framework on a docker , or on any Linux machine.
![](https://pandao.github.io/editor.md/images/logos/editormd-logo-180x180.png)
### Features
#### mumps extension commands
####   a. for loop
      instead of those line:
```
      N I
      S I=""
      F  S I=$O(^MYGLO(V1,V2,V3,I)) Q:I=""  D SOMTHING(I)
      Q
    SOMTHING(I) ;
      : 
      Q
```

just use this:
```
      FOR I IN ^MYGLO(V1,V2,V3) D SOMETHING(I)
```
this new smart for loop can work on locals and on globals with any variations including indirection like this :
```
      FOR J IN @GLO D IT
```
####    b. #INCLUDE routineName
this will merge the routineName into my routine, 
you can find this usefull when writing tools , and need to access a lot of labels of the tool during the entire routine , so including it will a) keep its current version and b) will let you reference the labels without label^routine - just the "label" which make a routine more clean. 
       
####    c. auto versioning 
 each time you save the routine (whith changes) if you have a label name VERSION() the tool will automatically increment the subVersion , and add a timestamps , for example :
```
VERSION()  Q "1.01.006" ;14/03/2019 18:06:52
```

[Learn more](mext.md)

## the framework
html + mumps - one place development of your application

#### exmaple 1 - simple html
A mix of an html page +  javascript + a mumps code , which will run during the load of the page
```html
<h2> Hello world </h2>
<3> multiplication table </h3>
<hr>
<m>
START	;
	W !,"DATE: ",$H,!
	W !,"<div class=card>"
	W !,"<div class=card-body>"
	F LIN=1:1:10 W "<BR>" F ROW=1:1:10 W " ",ROW*LIN
	W !,"</div>"
	W !,"</div>"
  Q   
</m>  
```
result: 

![](https://github.com/yaweli/pipi/blob/master/example1.png)
#### exmaple 2 - interact with forms
somtimes on application you need to check and validate a form fields

```html
	<form>
		enter number: <input id=id100 type="text" value=80 name=var1 onChange="mLabel('CHECKN',this)" /> <br/>
		enter number: <input id=id101 type="text" value=80 name=var2 /> <br/>
		enter name: <input id=id102 type="text" value=80 name=name1 /> <br/>
	</form>
<m>
START ;
   Q
CHECKN ;
	I M>100 D ALERT("BIG"),FOCUS("id100")
	I M<100 D ALERT("SMALL"),FOCUS("id100") ;>
	I M=100 D SETV("id100","CORRECT")
	I M=100 D FOCUS("id102")
	I M=90  D GO("next.html")
	Q
	#INCLUDE %ESLJXI
</m>
```
use onChange=mLabel("LABEL",this) to instruct the browser to come check the field value in the mumps !


actions  | description
--------  | -------------
ALERT | show an error message
FOCUS|restore focus to a field
SETV|replace a value inside a form field
GO|jump to a new url
|...more to come

The #INCLUDE will help us reference the labels without the name of the routine. 
instead of : 
```mumps
D GO^%ESLJX("aaa.html")
```
just write:
```mumps
D GO("aaa.html")
```

#### exmaple 3 - links
```html
<center>
Click on image: 
<img src=/images/tree.jpg onclick="mLabel('TREE','T')" />
<br>
Click on a link:
<a href=# onclick="mLabel('GOINFO','G')">Info</a>
<m>
START	;
	Q
GOINFO	;
	D GO("info.html")
	Q
TREE	;
	D GO("tree.html")
	Q
	#INCLUDE %ESLJXI
</m>
```

### Embeded bootstrap
it will be nice if the farmework will include support for bootstrap and include
the js files and the css files without the need to enter a long lines. 
So the framework come the packs. 
####  bootstrap 4 + jquery +popper
```html
<m#import mpak1 />
```

__mpak1__ : This will include all the html need to use the bootstrap + jquery 

##### example 1 - simple bootstrape button
```html
<m#import mpak1 />

INFO PAGE:<BR>
<m>
START	;
	Q
BACK	;
	D GO^%ESLJX("start.html")
	Q
</m>
<HR>
<button type="button" class="btn btn-primary" onclick="mLabel('BACK','b')"">Back</button>
<hr>
```

![](https://github.com/yaweli/pipi/blob/master/EXAMPLE2.png)


##### example 2 - more nice bootstrap elements
```html
<m#import mpak1 />


<form>
<div class="pos-f-t">
  <div class="collapse" id="navbarToggleExternalContent">
    <div class="bg-dark p-4">
		<div class="btn-group bg-dark p-4" role="group" aria-label="Button group">
		  <button type="button" class="btn btn-secondary"><img width=30 class="img-fluid" src=/im/set.png /></button>
		  <button type="button" class="btn btn-secondary" onclick="mLabel('GOINFO','i')" ><img width=30 class="img-fluid" src=/im/inf.png /></button>  
		</div>
    </div>
  </div>
  <nav class="navbar navbar-dark bg-dark">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggleExternalContent" aria-controls="navbarToggleExternalContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span> 
    </button>
    <h5 class="text-white h4">Pi zero W board manager</h5>
  </nav>
</div>
</form>
<m>
START	; next screen
	D CARD("QUOT","BODY","W30%")
	D CARD("JOBH","JOBB","W30%")
	D CARD("IPH","IPB","W30%")
	Q
JOBH	W "Job" Q
JOBB	W JB    Q
IPH	W "I.P" Q
IPB	W VRU("REMOTE_ADDR") Q
	; 
QUOT ;
	W "Horolog"
	Q
BODY ;
	W $H
	Q
GOINFO ;
	D GO("pizinfo.html")
	Q
	#INCLUDE %ESBSI
	#INCLUDE %ESLJXI
</m>
```
this time the mumps also generated a bootstrap elements with it's library.
you can combine BS elements as html and also BS generated inside the mumps , it's up to you.


![](https://github.com/yaweli/pipi/blob/master/EXAMPLE3.png)
note:
to use and include mumps bootstrap library : #INCLUDE %ESBSI then you can use the
```
 D CARD()
``` 

### accessing the GPIO on the pi
Raspberry pi computers have pins you can connect and attach a hardware , Leds lights , engines , sensors
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


####  cgi environment
the mumps include the VRU() vectore with all the linux environment where the cgi include environment for the session posted from your browser. 

examples: 
```mumps
VRU("QUERY_STRING")="a=Start&REDUCI=ELI"
VRU("REMOTE_ADDR")="192.168.88.9"
VRU("REMOTE_PORT")=62994
VRU("REQUEST_METHOD")="GET"
VRU("REQUEST_SCHEME")="http"
VRU("REQUEST_URI")="/cgi-bin/es?a=Start&REDUCI=ELI"
VRU(:)..more
```
the form variables from the url: mypi/cgi-bin/es?a=Start&REDUCI=ELI

```mumps
%PARK("REDUCI")="ELI"
%PARK("a")="Start"
```
headers
```mumps
VR("Referer")="http://elilap/proj/piz/"
VR("User-Agent")="Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:66.0) Gecko/20100101 Firefox/66.0"
```
..and more, depends on the apache webserver


### Mumps environment system wide

connect by ssh to get into the linux environment
to log into the gtm (mumps) enter __m__
```sh
eli@eli-laptop:~/projects/mumps$ m

MGR>
```

This mumps is DSM style which have a subdivisions of database OR namespaces we call UCI. 
first login will take you to the MGR uci
all routines from MGR can be see on all other uci's

switch between uci's  enter __D ^%UCI__ then the 3 upper case uci name
```mumps
MGR>D ^%UCI

GT.M V6.3-005 Linux x86_64 JOB 26712
UCI : ELI
WELCOME TO E.S. GTM 1.01
J26712 I/dev/pts/3
----------------------------
ELI>
```

view the uci's globals:  __D ^%G__

```mumps
ELI>D ^%G


Global ^W()
        W()
Global ^%ZUCI
        %ZUCI
^%ZUCI("ELI") =
^%ZUCI("ELI","G") = /gtm/ELI.gld
^%ZUCI("ELI","R") = /gtm/eli/r/ /gtm/mgr/r/ /gtm/
^%ZUCI("MGR") =
^%ZUCI("MGR","G") = /gtm/MGR.gld
^%ZUCI("MGR","R") = /gtm/mgr/r/ /gtm/
Global ^
```
we are using dsm style global listing , include a lot of extensions , [learn more](gdsm.md)


### gtm management
login with ssh to the linux
enter __gman__
```sh
eli@eli-laptop:~/projects/mumps$ gman
Mumps manager
1 - gtm system
2 - uci
options :
1
 1 - start gtm
 2 - stop gtm
 option?
1 - gtm system
2 - uci
N - CREATE NEW UCI
D - DELETE UCI
F - FIRST TIME CREATE MGR
S - SHOW UCI INFO
M - MOUNT UCI
options:
```

Gtm management will be documented later

management gtm will let you
1. start and stop gtm
2. create remove or mount a uci
3. first time create the MGR uci 



### routine utilities
in addition to the GTM own utility (like %RO/%RI/%RD/%RSE/....)
the m framework come with a set of % utility routines. part of them are the source of the framework engine and other part is the mumps general utility
routines:

routine name | description
--------------- | ----
%ESD|date and time manipulation
%ESS|string and general manipulation
%ZU|UCI manipulation
%ESF|Files manipulations
%ESLIB|Html web development
%ESGP|Pi GPIO utility
%ESBS|bootstrape web utility
%ESLJX|ajax
%ESLJXI|ajax include
%ESDEV|m framework internal routine
%ESET|Error trap
%ESRL|mumps macro extensions .mes
%ESWS|cgi engine
%ZGL|D ^%G source
%UCI|mapped to D ^%ZU
%G|mapped to D ^%ZGL
%MGR|switch to uci MGR

__MGR__ uci will contain all the %routines + all the %globals

note the prompt will point to the current uci.

## mumps programing good practice

- use the UCI structure for a large projects , each project it's own UCI
- session : you have a JB in the partision which is unique to the browser page , each entry , it's own JB. use this session number to save local information for the user , we like to use the W global for a temporary area. ^W(JB, (put here all the user temp data)
- each restart to the system the ^W will be cleaned
- make sure to clean it on first entry
- using upper case/lower case command in mumps - up to you. macros only on upper case



## create new project

To create a new project , follow those guides :
[Guide](newproject.md)

## M framework on a docker

Full guide coming soon 


<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE4ODAyNDI0MDAsMTY0Mjg2MDIyOF19
-->