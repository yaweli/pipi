## Short style


```HTML
<div ||T0/L20/BR6||>Hello</div>
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
|W  |  | yes|
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
|H  | top | yes|

		I A?1"DS".E D AT2("display:"_N2) Q
		I A?1"CL".E D AT2("color:"_N2) Q
		I A?1"ZI".E D AT2("z-index:"_N2) Q
		I A?1"SZ".E D PX,AT2("font-size:"_N2PX) Q
		I A?1"RTL".E I $G(MY("LD"))="RTL" D AT2("text-align:right") Q
		I A?1"R".E D PX,AT2("right:"_N1PX) Q
		I A?1"POS".E S N3=$S(N3="A":"absolute",N3="R":"relative",1:N3) D AT2("position:"_N3) Q
		I A?1"IMP"  D AT2("!important") Q
		I A?1"MA".E D AT2("margin:"_N2) Q
		I A?1"MORE".E S MORE=" "_$P(A,"MORE:",2) Q
		I A?1"MUST".E S MORE=" required class="_$S(VL="":"is-invalid",1:"is-valid") Q
		I A?1"DISA".E S MORE=$G(MORE)_" disabled" Q
		I A?1"SSV".E  S IVALID=1 Q
		I A?1"MXH".E D PX,AT2("max-height:"_N3PX) Q
		I A?1"MNH".E D PX,AT2("min-height:"_N3PX) Q
		I A?1"JC".E D AT2("justify-content:"_N2) Q
		I A?1"#BO"    S CL=CL_"border " Q                            ; "/#BO"
		I A?1"#BO=".E S N=$P(A,"=",2),CL=CL_"border-"_$$CLS(N)_" " Q  ; "/#BO=P" ; Border color
		I A?1"#BO:".E S N=$P(A,":",2),CL=CL_"border-"_N_" " Q
		I A?1"#RO".E  S N=$P(A,"=",2),CL=CL_"rounded"_$S(N'="":"-"_N,1:"")_" " Q  ; "/#RO" ; Border rounded ; https://getbootstrap.com/docs/4.0/utilities/borders/#border-radius
		I A?1"#CL=".E S N=$P(A,"=",2),CL=CL_"text-"_$$CLS(N)_" " Q
		I A?1"#FL:".E S N=$P(A,":",2),CL=CL_"float-"_N_" " Q
		I A?1"#TX:".E S N=$P(A,":",2),CL=CL_"text-"_N_" " Q
		I A?1"#CO:".E S N=$P(A,":",2),CL=CL_"col-"_N_" " Q  ; 	col-sm-auto


advance users: see source code at routine %ESBS for more styles
