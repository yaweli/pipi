%ESLJX	; AJAX CALL FOR GTM
	;(C) ELI SMADAR 2019
	Q
	;WAS %ESLJX	; AJAX TECH 4CACHE 4SPORT
	;ELI SMADAR (C)
	;VER +0.1 - RESTYLE SUPPORT DELTA
	Q
INITX	;
	W !,"var http_request;"
	W !,"var http_stat=0;"
	W !,"http_request = new XMLHttpRequest();"
	Q
INITAJAX ; INIT THE HTTP REQ AJAX TECH
	W !,"<script type=""text/javascript"">"
	W !," // (c) all ajax codes are copyrights to e.s. 2006 , 2019//"
	D INITX
	W !,"http_request.onreadystatechange = handleAnswers ;"
	W !,"function handleAnswers() {"
	W !,"   if (http_request.readyState == 4) {"
	W !,"      if (http_request.status == 200) {"
	;
	w !,"stopaj=0 ;" ; flag control by collar to ONE time click (D STOPAJ)
	W !," c('res: '+http_request.responseText);"
	W !," eval(http_request.responseText);"
	W !,"if (stopaj == 0) http_request.onreadystatechange = handleAnswers ;"
	w !,"http_stat=0;" ;//end of com
	w !,"http_max=0;"
	;
	;// http_request.responseXML - as an XMLDocument object you can traverse using the JavaScript DOM
	;                              functions
	W !,"      } else {"
	;// there was a problem with the request,
	;// for example the response may be a 404 (Not Found)
	;// or 500 (Internal Server Error) response codes
	W !,"         alert('COMMUNICATION PROBLEM , there was a problem with the request');"
	W !,"      }"
	W !,"   }"
	W !,"}"
	;                  uri = https://www.dev.aws.4m-a.org/cgi-bin/es?Id=OhyQyL6eJ5YPEDkFMiPQhaU4q4lv&REDUCI=FOR&SId=9&Info=HHH^mes18849859&itmVal=AA%002bAAA&ajmode=1&itmId=HHH
	W !,"function uuuu(uri){"
	w !,"   http_stat=1;"
	W !,"   http_request.open('GET', uri, true);"
	W !,"   http_request.send(null);"
	w !,"}"
	W !,"function callAjax(sid,INFO,itmVal,itmId) {"
	;w !,"   alert(document.getElementById('aj').src);"
	;W !," alert('ca0');"
	W !,"   ur=document.location;"
	W !,"   url = ur + "" "" ; " ; https://www.kkkk.com/cgi-bin/Es?ID=121212
	W !,"   vec = url.split(""/"") ;"
	W !,"   var uri= vec[0] ;" ;            https
	W !,"   uri += '/' + vec[1] ; " ; 
	W !,"   uri += '/' + vec[2] ; " ; www.kkkk.com
	W !,"   uri += '/' + vec[3] ; " ; cgi-bin
	W !,"   uri += '/' + 'es' ; "
	W !,"   uri += '?Id="_Id_"' ;"
	I $D(REDUCI) W !,"   uri += '&REDUCI="_REDUCI_"' ;"
	W !,"   uri += '&SId=' + sid ;"
	W !,"   if (typeof(INFO) != ""undefined"") { "
	w !,"      if( INFO.length) uri += '&Info=' + fullhex(INFO) ;"
	w !,"      }"
	;W !,"c(itmVal);" ; AAA+AA
	;W !,"c(itmVal.length);" ; AAA+AA
	W !,"   if (typeof(itmVal) != ""undefined"") { "
	w !,"      if( itmVal.length || itmVal) uri += '&itmVal=' + fullhex(itmVal) ;" ; itmVal=AAA%002bAA
	w !,"      }"
	W !,"   uri += '&ajmode=1' ;" ; SILENCE MODE
	W !,"   if (typeof(itmId) != 'undefined') uri += '&itmId='+itmId;"
	W !,"   c('uri: '+uri);"
	;W !,"   c('prev stat='+http_stat);"
	I $D(%SUPER) W !,"uuuu(uri);"
	E  D
	.w !,"   if(http_stat==0) uuuu(uri);"
	.w !,"   else {"
	.w !,"      var im1=setInterval(function() {"
	.w !,"         if(http_stat==0 || (++http_max>90)) {"
	.w !,"            clearInterval(im1);"
	.w !,"            uuuu(uri);"
	.w !,"            if(http_max>90) { c('max>90 - timeout'); };"
	.w !,"         } else {"
	.w !,"              c('still waiting for http_stat '+http_stat);"
	.w !,"         }"
	.w !,"       },1000);"
	.;w !,"      http_stat=1;"
	.;W !,"      http_request.open('GET', uri, true);"
	.;W !,"      http_request.send(null);"
	.W !,"   }"
	W !,"}"
	W !,"function fullhex(a) {"
	W !,"  b='';"
	W !,"  for (i=0 ; i<a.length ; ++i) {"
	W !,"    b += toHex(a,i);"
	W !,"  }"
	W !,"  return b;"
	W !,"}"
	W !,""
	w !,"String.prototype.padLeft = function (length, character) { "
    w !," return new Array(length - this.length + 1).join(character || '0') + this; "
	w !,"}"
	w !,""
	W !,"function toHex(f,i) {"
	w !,"    var ff=f.charCodeAt(i);"
	w !,"    var cc=String.fromCharCode(ff);"
	w !,"    if(cc==' ') return '+';"
	W !,"    if(ff>31 && ff<127 && cc!='&' && cc!='%' && cc!='#' && cc!='+') return cc;"
	W !,"   return ""%"" + ff.toString(16).padLeft(4, '0') ;"
	W !,"   }"
	W !,"function removeElement(id) {"
	W !,"    var elem = document.getElementById(id);"
	W !,"    return elem.parentNode.removeChild(elem);"
	W !,"}"
	W !,"</script>"
	;
	Q
STOPAJ	;
	W !,"stopaj=1;"
	Q
TIMEAJ(MS,%RUT,ACT) ; call LABEL on the server side on time, MS=miniseconds
	;            ACT=1 , inside a <script>
	S SId=SId+1000,ACT=$G(ACT)
	D SUBSAV^%ESWSE("%RUT") ; SAVE ROUTINE NAME
	N VAR,VAL S VAR="MS" D SUBSAV^%ESWSE(VAR) ; SAVE VAR/VAL
	I 'ACT W !,"<script>",!
	;I ACT w "alert('setNewtimeout');"
	N CM
	S CM="  setTimeout('"
	S CM=CM_"callAjax("_SId_")" ;,"""")"
	S CM=CM_"',"_MS_");"
	;S CM="  setTimeout("
	;S CM=CM_"callAjax,"
	;S CM=CM_MS_","
	;S CM=CM_SId_");"
	W CM ;S ^%ELI=CM
	I 'ACT D
	.W !,"</script>",!
	.D IMG00
	I ACT D
	.w "   document.getElementById('aj').src='/images/plus.gif';"
	Q
AJLINK(VAR,VAL,%RUT,TEXT,ALT,APR,%ST,%EV,ID) ; HYPER LINK
	W !?($$LEV^%ESLIB),"<A"
	S SId=SId+1
	D SUBSAV^%ESWSE("%RUT") ; SAVE ROUTINE NAME
	S TARG="" I VAR["/" S TARG=$P(VAR,"/",2),VAR=$P(VAR,"/",1)
	X "N "_VAR_" S "_VAR_"=VAL D SUBSAV^%ESWSE(VAR)" ; SAVE VAR/VAL
	N ACT S ACT=$$SVAR^%ESLIB("Id",Id)_"&SId="_SId
	D FIXACT^%ESLIB
	W " HREF=""javascript:callAjax("_SId_")"""
	I $L($G(ID)) W " ID="""_ID_""""
	D %ST^%ESLIB
	D %EV^%ESLIB
	I $L(TARG) W " TARGET="""_TARG_""""
	W ">"
	D W(TEXT),SPACE
	D IMG00
	W "</A>"
	Q
SETV(VAR,VAL) ;
	W "   document.getElementById('"_VAR_"').value='"_VAL_"';"
	Q	
FOCUS(VAR) ;
	W "   document.getElementById('"_VAR_"').focus();"
	Q	
FLDOK(VAR) ;
	W " var el1=document.getElementById('"_VAR_"').classList;"
	W " el1.add('is-valid');"
	W " el1.remove('is-invalid');"
	Q
FLDERR(VAR,ERR) ;
	W " var el1=document.getElementById('"_VAR_"').classList;"
	W " el1.add('is-invalid');"
	D SELE(VAR_"err",ERR)
	W " el1.remove('is-valid');"
	S ERRF=ERR
	Q
EVENT(EV,VAR,VAL,%RUT,info) ; RETURN ON EVENT ACTION
	; EV=onChange  or OnClick 
	; info = javascript return value, ex: document.form1.filed1.value
	S SId=SId+1
	D SUBSAV^%ESWSE("%RUT") ; SAVE ROUTINE NAME
	S TARG="" I VAR["/" S TARG=$P(VAR,"/",2),VAR=$P(VAR,"/",1)
	X "N "_VAR_" S "_VAR_"=VAL D SUBSAV^%ESWSE(VAR)" ; SAVE VAR/VAL
	i '$d(info) Q EV_"=""javascript:callAjax("_SId_")""" ; '
	i $d(info) Q EV_"=""javascript:callAjax("_SId_","_info_")"""
	Q
RMELE(DNAME) ; REMOVE DIV
	W !,"dname='"_DNAME_"';"
	W !,"    var element = document.getElementById(dname);"
	W !,"    element.parentNode.removeChild(element); "
	Q
SELE(DNAME,V) W "document.getElementById('"_DNAME_"').innerHTML='"_V_"';" Q
NELE(DNAME) ; add free html text to an element (div)
	W !,"   document.getElementById('"_DNAME_"').innerHTML += '"
	Q
EELE()	;
	W "';"
	Q       
ATEXT(A) ;
	D NELE(%DNAME) D  D EELE()
	.D W(A)
	Q
AJPOINT(DNAME) ; 
	S %DNAME=DNAME
	Q
AJ(CMD)	;
	D NELE(%DNAME) D  D EELE()
	.D @CMD
	Q
MKELE(TYPE,VEC) ; CREATE ELEMENT AND APPEND IT AFTER ELEMENT
	W !,"   var IELE = document.createElement('"_TYPE_"');"
	N A,I S I=""
	F  S I=$O(VEC(I)) Q:I=""  S A=VEC(I) d
	.W !,"      IELE.setAttribute("""_$P(A,D,1)_""","""_$P(A,D,2)_""");"
	W !,"   document.getElementById('"_%DNAME_"').appendChild(IELE);"
	Q
IMG00	;
	D IMG("/images/plus.gif","","IDaj/BO0")
	Q       
ALERT(A) W "alert('"_A_"');" Q
	Q
GO(HTML) ;
	D SAVE1^%ESWSE H 0 ; save variables , e.s. 28/03/2020
	S VAR="NEXT",VAL=REDUCI_":"_HTML,%RUT="GOR^"_$T(+0)
	W "document.location='"_$$ACT^%ESLIB_"';"
	Q
GOR	;
	S REDUCI=$P(NEXT,":",1),HTML=$P(NEXT,":",2)
	S %FF=HOME_DIR_HTML
	D DO^%ZU(REDUCI,"^%ESDEV(%FF)")
	Q
INITAJT(ROAT) ; AJAX TABLES
	;ROAT(1)="bgcolor_ORANGE"
	;     :
	W !,"<script>"
	W !,"function insertTextCell(text,row) {"
	W !,"  var cellLeft = row.insertCell(row.cells.length);"
	W !,"  var textNode = document.createTextNode(text);"
	W !,"  cellLeft.appendChild(textNode);"
	W !,"}"
	W !,"function addRowToTable(tb,current_element,mat)"
	W !,"{"
	W !,"  var tbl = document.getElementById(tb);"
	;W !,"  var RowIndex = current_element.parentNode.parentNode.rowIndex;"
	W !,"  var RowIndex = current_element;" ; current-element is 0,1,2, - the index row
	W !,"  var row = tbl.insertRow(RowIndex);"
	N I S I=""
	F  S I=$O(ROAT(I)) Q:I=""  D
	.W !,"  row.setAttribute('"_$P(ROAT(I),D,1)_"', '"_$P(ROAT(I),D,2)_"');"
	;W !,"  row.setAttribute('bgcolor', 'orange');"
	;W !,"  row.setAttribute('align', 'right');"
	W !,"   for( var i=0;i<mat.length;++i) { "
	W !,"      insertTextCell(mat[i],row) "
	W !,"   }"
	W !,"}"
	W !,"function deleteRow(tb,r)"
	W !,"{"
	;W !,"   var i=r.parentNode.parentNode.rowIndex;"
	W !,"   var i=r;" ; r=0,1,2,.... this is the rowindex
	W !,"   document.getElementById(tb).deleteRow(i);"
	W !,"}"
	W !,"</script>"
	Q
	;
    ;function px(n) { return ((n | 0)+'px') ;};
    ;function nn(s) { return parseFloat(s);};
	;
RESTYLE(ID,STYLE,VAL) ; change style of element
	;I '$D(CSS) D CSS0^%ESBS
	K CSS D CSS0^%ESBS
	I VAL?1"+".E!(VAL?1"-".E) D DELTA Q  ; for += value ; add/substruct prev value
	I VAL?1"**".E D EX3($E(VAL,3,99)_"+""px""") Q  ; expression numeric (we add 'px')
	I VAL?1"*".E D OF Q  ; copy from style of id "*id"
	I VAL?1"=".E D EX Q  ; net expresion / or variavle
	;
	w "document.getElementById("""_ID_""").style."_CSS(STYLE)_"="""_VAL
	I $D(CSS(STYLE,"S")) W CSS(STYLE,"S")
	W """;"
	S ^W(JB,"STY",ID,STYLE)=VAL
	Q
DELTA ;
	W "document.getElementById("""_ID_""").style."_CSS(STYLE)_"=(parseFloat(getComputedStyle(document.getElementById("""_ID_"""))."_CSS(STYLE)_")"_VAL_")"
	I $D(CSS(STYLE,"S")) W "+"""_CSS(STYLE,"S")_""""
	W ";"
	Q
OF  ;
	W "document.getElementById("""_ID_""").style."_CSS(STYLE)_"=getComputedStyle(document.getElementById("""_$E(VAL,2,99)_"""))."_CSS(STYLE)_";"
	Q
EX  ;
	W "document.getElementById("""_ID_""").style."_CSS(STYLE)_"="_$E(VAL,2,99)_";"
	Q
EX3(A) ; expresion
	W "document.getElementById("""_ID_""").style."_CSS(STYLE)_"="_A_";"
	Q
GSTYLE(AT) ;
	N B,MORE,CL
	Q $$AT^%ESBS
	;
FORMC(ZN,FF) ; usage: D FORMC("ROLE/EMAIL") Q:ERR'="" 
	N NN,F,M,ERRF
    S ERRF="",ERR=""
    F NN=1:1:$L(FF,"/") S F=$P(FF,"/",NN),M=@F,M("ID")=F X "D "_F_"^"_ZN Q:ERRF'=""  S @F=M
    I ERRF'="" S ERR="Form wrong fields"
	Q
MLATER(ZN,LAB,SEC) ;
	W "setTimeout(mLabel,"_SEC_","""_LAB_"^"_ZN_""",1);"
	Q
W(A)	D W^%ESLIB(A) Q
SPACE	W $$SP Q
SP()	Q $$SP^%ESLIB() Q
IMG(A,ALT,FF) D IMG^%ESLIB(A,$G(ALT),$G(FF)) Q
B	D BOLD^%ESLIB() Q
	Q