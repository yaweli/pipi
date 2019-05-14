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
CHECKN ;
	I M>100 D ALERT^%ESLJX("BIG"),FOCUS^%ESLJX("id100")
	I M<100 D ALERT^%ESLJX("SMALL"),FOCUS^%ESLJX("id100") ;>
	I M=100 D SETV^%ESLJX("id100","CORRECT")
	I M=100 D FOCUS^%ESLJX("id102")
	I M=90  D GO^%ESLJX("next.html")
	Q
</m>
```


