## new project guide


1. create new directory in 
```
/var/www/html/proj/mygame
```
2. create landing page index.html with this form:
```html
index.html:
<html>
<center>
start from here
<br><br>
<Form action=/cgi-bin/es>
<input style="font-size:80px" type=submit name=a value=Start>
<input type=hidden name=REDUCI value=ELI>
</Form>
<img src=pz.jpg />
<br>
http://pi-zero-ip/proj/mygame/
<br><br><h6>(c) e.s. 2019</h6>
```
Design it as you like ,
submitting the form will run the first html page which is 
```
start.html
```

This start.html will be page number one for the m-framework software

#### use the advance template with bootstrap 
```
<m#import mpak1 />
```

#### add upper toolbar for salability and smart devices support
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
    <h5 class="text-white h4">2019</h5>
  </nav>
</div>
</form>
<center>
<br>
<m>
START	; next screen
</m>
```

#### you may duplicate this page for all other pages , or create a one page design

####  interact with the mumps to check for data entry with:
```html
<form>
<input id=id100 type="text" value=80 name=var1 onChange="mLabel('CHECKN',this)" /> <br/>
</form>
<w>
START	;
	Q
CHECKN	;
	I M'=^MYDATA D ALERT("Wrong input"),FOCUS("id100") Q
	S ^W(JB,"MYFORMDATA","NUM")=M
	D GO("next.html")
	Q
	#INCLUDE %ESLJXI
</w>
```

####  make use of the bootstrap to produce good ui
```html
<div class="container-fluid">
	 <span class="alert alert-primary">
Some kind of error message
	</span>
	<span class="alert alert-success">
Hi, this is a message
	</span>
</div>
```



<!--stackedit_data:
eyJoaXN0b3J5IjpbLTE2ODc0MjQwODAsMzAzNzgzMjI1XX0=
-->