# pipi
This project include a full mumps framework running on the Raspberry pi
accessed by the browser (desktop or mobile) 
it's a platform to develop a web apps / desktop apps and websites with mumps as a code 
that will generate nice web ui using latest bootstap 

futures: 
1. mumps extension commands
   a. for loop
      instead of those line:
      N I
      S I=""
      F  S I=$O(^MYGLO(V1,V2,V3,I)) Q:I=""  D SOMTHING(I)
      Q
    SOMTHING(I) ;
      : 
      Q
     
    just use this:
      FOR I IN ^MYGLO(V1,V2,V3) D SOMETHING(I)
      
    this new smart for loop can work no locals and on globals with any variations including indirecion like this :
    
      FOR J IN @GLO D IT
      
    b. #INCLUDE routineName
    
       this will merge the routineName into my routine, 
       i found this usefull when writing tools , and need to access a lot of labels of the tool during the entire routine , so including it will a) keep its current version and b) will let you reference the labels without label^routine - just the "label" which make a routine more clean. 
       
    c. auto versioning 
       each time you save the routine (whith changes) if you have a label name VERSION() the tool will automatically increment the subVersion , and add a timestamps , for example :
       VERSION()  Q "1.01.006" ;14/03/2019 18:06:52
       
       
   2. html + mumps - one place development of your application
   
   
<a href="next.html" class="badge badge-primary">link to Primary</a>

   exmaple 1 - simple html: A mix of an html page + it's javascript + a mumps code , which will run during the load of the page

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
