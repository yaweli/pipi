# pipi
This project include a full mumps framework running on the Raspberry pi
accessed by the browser (desktop or mobile) 
it's a platform to develop a web apps / desktop apps and websites with mumps as a code 
that will generate nice web ui using latest bootstap 

His big brother runs this same framework on a docker , or on any linux machine.
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
this new smart for loop can work no locals and on globals with any variations including indirecion like this :
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
-alert  - will show a message
-focus - will restore focus to a field
-setv    - 

actions  | description
--------- | -------------
ALERT | show a message
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
START ;
   Q
GOINFO ;
	D GO("info.html")
	Q
TREE ;
	D GO("tree.html")
	Q
	#INCLUDE %ESLJXI
</m>
```

### Embeded bootstrap
it will be nice if the farmework will include support for bootstrap and include
the js files and the css files without the need to enter a long lines. 
So the framework come the packs. 
#### 1. bootstrap 4 + jquery +popper
```html
<m#import mpak1 />
```

This will include all the html need to use the bootstrap

##### example 1 - simple bootstrape button
```html
<m#import mpak1 />

INFO PAGE:<BR>
<m>
START ;
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
![](https://github.com/yaweli/pipi/blob/master/EXAMPLE2.png)
