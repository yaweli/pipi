# html level Import


You can merge html/files to support external frameworks , or js preload scripts. 
tobe able to load content before your project (at the top of the file) and at the end of the project (bottom of the file) 
any include will upload 2 files , at the top and at the end. 

exmaple: 

<m#import /paks/mpak1 />

This will merge the file /paks/mpak1.start.html and /paks/mpak1.end.html like this


 /paks/mpak1.start.html (at the beginning) 
 
 my html content
 
 /paks/mpak1.end.html (at the end)


In this way you can make youself a preLoad project which will be included in your projects