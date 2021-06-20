## Short style


```HTML
<div ||T0/L20/BR6/POSA||>Hello</div>
```
Will become
```HTML
<div style="top:0px;left:20px;border-radius:6px;position:absolute">Hello</div>
```

Each shortcut represent a style. T for top:0px , L for left:20px , etc


|shortcut       | style                   | automatic px |
|---------------|-------------------------|--------------|
|T  | top | yes|
|L  | left | yes|
|B  | buttom | yes|
|R  | right | yes|
|W  | width | yes|
|H  | height | yes|
|A  | align | no|
|BR  | border-radius | yes|
|BG  | backgroud|no|
|BC  | backgroud-color|no|
|BW | border-width|yes|
|MXW | max-width | yes|
|MNW | min-width | yes|
|FF  | font-family|no|
|FW  | font-weight|yes|
|VA | vertical-align|no|
|DS | display | no|
|CL | color | no|
|ZI | z-index|no|
|SZ | font-size|yes|
|RTL | text-align:right|no|
|POSA|  position:absolute||
|POSR|  position:relative|
|POSR|  position:relative|
| IMP| !important|no|
| MA| margin|yes|
| MXH| max-height|yes|
| MNH| min-height|yes|
| JC |justify-content |no|


advance users: see source code at routine %ESBS for more styles


Automatic px:

Using the pixel mesurment attributes style (width,height,left,right...) you don't need to specify the 6px , just use 6

## Why doing that?
Mumps methodolgy is not to float the screen with code , make a nit clean code, Make long commands short: (W instead of WRITE).

So to do the same with those long decleration of style - use the style short method. 

## Indirection
Not allways the style is known during coding , sometimes it know only during runtime. 

To use mumps variable as a value to the Styling, you can emmbeded the '_' to indicate its a variable.

```HTML
<div ||L30/T"_TOPWINDOW_"/POSA||>Hello</div>
```

Will be translated to mumps
```HTML
W "<div style=left:30px;top="_TOPWINDOW_";position:absolute>Hello</div>"
```

another example:

```HTML
    ....S COLOR="GREEN"
    ....<span ||CLBLACK/BG"_COLOR_"/BR6||>D  </span>
```
This will be converted to : 
```HTML
	....S COLOR="GREEN"
	....W "<span style=color:BLACK;background:"_COLOR_";border-radius:6px>" D  W "</span>"
```
Very usfull in runtime. 


