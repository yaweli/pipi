%ESBS	; BOOTSTRAP UTIL
	; 
	Q
TR(A) ; Translate item from base lng to my-env-lng
	;see ustart^forml
	I '$D(^DIC(^CURRENT("LNG","BASE"),MY("LN"),A,MY("PR"))) d add Q A
	N AA S AA=^(MY("PR"))
	I AA="-" Q A ;untranslated
	Q AA
WWW(A) ; translate one item
	I A="" Q
	I A["{" D QB Q  ;{var}
	I '$d(MY("LB")) S B=B_A Q
	I MY("LB") S B=B_A Q
	S B=B_$$TR(A)
	Q
WW()  ; INPUT(w1,w2,w3,w4) ; return items in order via dictionary
	; D WR(w1,w2..)  or W $$WW(W1,W2,...)
	N B S B="" D
	.I $g(MY("LD"))="" D  Q  ; English
	..D WWW(w1) Q:'$D(w2)
	..D WWW(w2) Q:'$D(w3)
	..D WWW(w3) Q:'$D(w4)
	..D WWW(w4) Q:'$D(w5)
	.I MY("LD")="RTL" D  ; Hebrew
	..I $D(w4) D WWW(w4)
	..I $D(w3) D WWW(w3)
	..I $D(w2) D WWW(w2)
	..I $D(w1) D WWW(w1)
	Q B
	Q
DD(ZN)	; Do labels by RTL direction
	I MY("LD")="" D  Q  ; English
	.X "D "_w1_"^"_ZN Q:'$D(w2)
	.X "D "_w2_"^"_ZN Q:'$D(w3)
	.X "D "_w3_"^"_ZN Q:'$D(w4)
	.X "D "_w4_"^"_ZN Q:'$D(w5)
	I MY("LD")="RTL" D  ; Hebrew
	.I $D(w4) X "D "_w4_"^"_ZN
	.I $D(w3) X "D "_w3_"^"_ZN
	.I $D(w2) X "D "_w2_"^"_ZN
	.I $D(w1) X "D "_w1_"^"_ZN
	Q
DIR() ;
	I $G(MY("LD"))="RTL" Q " style=text-align:right "
	Q ""
ATLNG() ;
	I $G(MY("LD"))="RTL" Q "Aright"
	Q ""
	;
AHREF ; AHREF(TIT,ID,CLS,ML,OPT) LINK
	; CLS= P/S/C/...   ML=mumps-label
	S OPT=$G(OPT)
	W "<a href=#"
	S CL="badge badge-"_$$CLS(CLS)
	I OPT="STR" S CL="stretched-link text-"_$$CLS(CLS)
	I OPT="EMP" S CL="text-"_$$CLS(CLS)
	W " class="""_CL_""""
	I ID'="" W " id="""_ID_""""
	I ML'="" W " onClick=mLabel("""_ML_""",this.id)"
	W ">" D WR($G(TIT)) W "</a>"
	Q
	;    1   2    3   4   5 
ROW(ZN,COLS,SIZE,P12,OPT,ATV) ;
	; ZN   = $T(+0) routine name
	; COLS = "LAB1/LAB2/.../LABn"
	; SIZE = xs / sm / md / lg / xl
	; P12 = 1/2/3/4/6 ; PART OF 12 WIDTH , or .P12(1)=2,.P12(2)=10
	;
	I $L(COLS,"/")=1,$D(ATV)=1 S ATV(1)=ATV
	N CL
	S OPT=$G(OPT)
	I "1/2/3/4/6/12/auto/push-6"'[P12                   ZT
	I "xs / sm / md / lg / xl / auto"'[SIZE     ZT
	N MORE S MORE=""
	I OPT["SHAD" S MORE=MORE_" shadow p-3 mb-2 bg-white rounded"
	I OPT["FLEXB" W "<div class=""d-flex justify-content-between"">" D ROWIN W "</div>" Q  ; |aaa    bbb    ccc|
	I OPT["FLEXC" W "<div class=""d-flex justify-content-center"">"  D ROWIN W "</div>" Q  ; |aaa    bbb    ccc|
	W "<div class=""container-fluid"_MORE_""">" D  W "</div>"
	.W "<div class=row>" D ROWIN W "</div>"
	Q
ROWIN ;
	F %ROW=1:1:$L(COLS,"/") D ROWIN1
	Q
ROWIN1 ;
	I $D(P12(%ROW)) S P12=P12(%ROW)
	N AT S AT=$G(ATV(%ROW)) ;-> CL
	W "<div "_$$AT
	W " class=""col-"_SIZE
	I P12'="" W "-"_P12
	W CL
	I OPT["RTL" I $G(MY("LD"))="RTL" W " text-right"
	W """"
	W ">" D  W "</div>"
	.X "D "_$P(COLS,"/",%ROW)_"^"_ZN
	Q  ; 2     3  4
CARD(ZN,QUOT,BODY,AT) ;
	W !,"<div class='card' "_$$AT_">"
	W !,"  <div class='card-header' "_$$DIR_" >"
	X "D "_QUOT_"^"_ZN
	W !,"  </div>"
	W !,"<div class='card-body' "_$$DIR_" >"
	W !,"    <blockquote class='blockquote mb-0'>"
	X "D "_BODY_"^"_ZN
    W !,"</blockquote>"
	W !,"  </div>"
	W !,"</div>	"
	Q  ;https://getbootstrap.com/docs/4.3/components/card/
CSS0 ;
    K CSS
    S CSS("X")="left",CSS("X","S")="px"
    S CSS("L")="left",CSS("L","S")="px"
    S CSS("Y")="top",CSS("Y","S")="px"
    S CSS("T")="top",CSS("T","S")="px"
    S CSS("W")="width",CSS("W","S")="px"
    S CSS("H")="height",CSS("H","S")="px"
    S CSS("R")="right",CSS("R","S")="px"
    S CSS("BR")="borderRadius",CSS("BR","S")="px"
    S CSS("A")="textAlign"
    S CSS("VA")="verticalAlign"
    S CSS("DS")="display"
    S CSS("POS")="position"
    S CSS("CL")="color"
    S CSS("ZI")="zIndex"
    S CSS("SZ")="fontSize",CSS("SZ","S")="px"
    S CSS("BO")="border"
    S CSS("BOT")="borderTop",CSS("BOT","S")="px"
    S CSS("BG")="background"
    S CSS("B")="bottom",CSS("B","S")="px"
    S CSS("MXH")="maxHeight",CSS("MXH","S")="px"
    ; see also AT2^%ESBS
	Q
AT(DL) ;
	S CL=" "
	S AT=$G(AT),DL=$G(DL) I DL="" S DL="/"
	N N,B,LN,N1,N2,N3,N1PX,N2PX,N3PX S B="",LN=0
	N I F I=1:1:$L(AT,DL) D AT1($P(AT,DL,I))
	I LN S B=B_""""
	I CL=" " S CL=""
	Q B
PX  ;
	S N1PX=N1 I N1?.e1n S N1PX=N1_"px"
	S N2PX=N2 I N2?.e1n S N2PX=N2_"px"
	S N3PX=N3 I N3?.e1n S N3PX=N3_"px"
	Q
AT1(A)	;
	S N1=$E(A,2,999) I N1?1"@".E S N1=@$E(N1,2,999)
	S N2=$E(A,3,999) I N2?1"@".E S N2=@$E(N2,2,999)
	S N3=$E(A,4,999) I N3?1"@".E S N3=@$E(N3,2,999)
	I A?1"H".E D PX,AT2("height:"_N1PX) Q
	I A?1"W".E D PX,AT2("width:"_N1PX) Q
	I A?1"X".E D PX,AT2("left:"_N1PX) Q
	I A?1"L".E D PX,AT2("left:"_N1PX) Q
	I A?1"A".E D AT2("text-align:"_N1) Q
	I A?1"BO".E D AT2("border:"_N2) Q
	I A?1"BW".E D PX,AT2("border-width:"_N2PX) Q
	I A?1"BR".E D PX,AT2("border-radius:"_N2PX) Q
	I A?1"MXW".E D PX,AT2("max-width:"_N3PX) Q
	I A?1"MNW".E D PX,AT2("min-width:"_N3PX) Q
	I A?1"BC".E D AT2("background-color:"_N2) Q
	I A?1"BG".E D AT2("background:"_N2) Q
	I A?1"FF".E D AT2("font-family:"_N2) Q
	I A?1"FW".E D AT2("font-weight:"_N2) Q
	I A?1"B".E D PX,AT2("bottom:"_N1PX) Q
	I A?1"T".E D PX,AT2("top:"_N1PX) Q
	I A?1"VA".E D AT2("vertical-align:"_N2) Q
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
	Q
AT2(A) ;	
	S LN=LN+1
	I LN>1 S B=B_";"_A
	I LN=1 S B=B_" style="""_A
	Q  ;  2  3   4   5  6   7   8  9
BUT(TEXT,ID,CLS,OUT,ML,DIS,SIZ,PAR,AT) ; https://getbootstrap.com/docs/4.0/components/buttons/
	; TEXT = ON BUTTON TEXT
	; CLS= P/S/C/...  
	; OUT=1 if OUTLINE =YES 
	; SIZ="" - size - ""=defult lg=large sm=small
	; PAR="TIT=bla bla bla"
	; DIS=1 - disabled
	;
	S PAR=$G(PAR)
	N BUTTON,VAL
	S BUTTON="button" I PAR["ASSPAN" S BUTTON="span"
	S VAL="this.id" I PAR["*ALL" S VAL="""*ALL""" 
	W "<"_BUTTON_" type=""button"""
	W $$AT
	W " class=""btn btn-"
	I $G(OUT) W "outline-"
	W $$CLS(CLS) ;Q(CLS)
	I $G(SIZ)'="" W " btn-"_$G(SIZ) I "sm/lg"'[SIZ ZT  ; need only if not defalut
	I PAR["TRA=Y" W " bg-transparent"
	I PAR["FULL"  W " btn-block" ; 100% full width size
	I PAR["HIDE"  W " d-none"
	;I PAR["CIR"   W " rounded-circle" ; !! NOT GOOD
	w """"
	I ML'="" W " onclick=mLabel("""_ML_""","_VAL_")"
	I ID'="" W " id="""_ID_""""
	I DIS'="" W " disabled"
	D PAR
	W ">"
	D WR2(.TEXT)
	I PAR["BAD="  W " <span class=""badge badge-"_$$CLS($E($P(PAR,"BAD=",2),1))_""">"_$P($E($P(PAR,"BAD=",2),2,99),"/",1)_"</span>"
	W "</"_BUTTON_">"
	Q
PAR	;
	I PAR["TIT=" W " title="""_$P($P(PAR,"TIT=",2),"/",1)_""""
	Q
Button(ZN,TEXT,OPT) ;  D Button("Register","ID=bbbb/CLS=P/ML=SIG1/*ALL")
	D OPT2V
	N BUTTON,VAL,EVN S EVN="onclick",VAL="this.id",BUTTON="button"
	I $D(OPT("ASSPAN")) S BUTTON="span"
	I $D(OPT("*ALL"))   S VAL="""*ALL""" 
	I '$D(OPT("CLS")) ZT  ;BUTTON MUST
	;
	W "<"_BUTTON_" type=""button"""
	S AT=$G(OPT("AT")) W $$AT("\")
	W " class=""btn btn-" D OPTCLASS w """"
	D OPTGEN
	W ">"
	;
	D WR2(.TEXT)
	I $D(OPT("BADQ")) W " <span class=""badge badge-"_$$CLS(OPT("BADQ"))_""">"_OPT("BADV")_"</span>" ; Badge (number over button)
	W "</"_BUTTON_">"
	Q
OPTCLASS ;
	I $D(OPT("OUT")) W "outline-"
	I $D(OPT("CLS")) W $$CLS(OPT("CLS"))
	I $D(OPT("SIZ")) W " btn-"_OPT("SIZ") I "sm/lg"'[SIZ ZT  ; need only if not defalut
	I $G(OPT("TRA"))="Y" W " bg-transparent"
	I $D(OPT("FULL"))  W " btn-block" ; 100% full width size
	I $D(OPT("HIDE"))  W " d-none"
	I $D(OPT("TEXT.CL")) W " text-"_$$CLS(OPT("TEXT.CL"))
	I $D(OPT("CLASS")) W " "_OPT("CLASS")
	Q
OPTGEN ;
	I $D(OPT("TYP")) W " type="_OPT("TYP")
	I $D(OPT("ML")) W $$ML(ZN,EVN,OPT("ML"),VAL)
	I $D(OPT("ID")) W " id="""_OPT("ID")_""""
	I $D(OPT("DIS")) W " disabled"
	I $D(OPT("DISA")) W " disabled"
	I $G(OPT("CHK"))  W " checked"
	I $D(OPT("TIT")) W " title="""_OPT("TIT")_""""
	I $D(OPT("NAME")) W " name="""_OPT("NAME")_""""
	I $D(OPT("VL")) W " value="""_OPT("VL")_"""" ; defualt
	I $D(OPT("PH")) W " placeholder="""_$$WW^%ESBSI(OPT("PH"))_""""
	Q
ML(ZN,EVN,ML,VAL) ; 
	I ML["^" S ZN=$P(ML,"^",2),ML=$P(ML,"^",1)
	Q " "_EVN_"=mLabel("""_ML_"^"_ZN_""","_VAL_")"
	;
Input(ZN,OPT) ; D Input("ML=CHECK/ID=inp/PH=enter your name/VL=moshe/SSV")
	D OPT2V
	N VAL,EVN,AT S EVN="onchange",VAL="this" I '$D(OPT("TYP")) S OPT("TYP")="text"
	S AT=$G(OPT("AT"))
	W "<input "_$$AT("\")
	W " class=""form-control" D OPTCLASS W """"
	D OPTGEN
	W "	/>"
	I $D(OPT("SSV")) W "<div id="_OPT("ID")_"err class=invalid-feedback>-</div>"
	Q
INPUT(NAME,ID,PH,ML,VL,AT) ;
	N MORE,IVALID
	W "<input "_$$AT_" type=""text"""
	N CL S CL="class=form-control"
	W " "_CL_$g(MORE)
	I NAME'="" W " name="""_NAME_""""
	I ID'="" W " id="""_ID_""""
	I VL'="" W " value="""_VL_"""" ; defualt
	I PH'="" W " placeholder="""_$$WW^%ESBSI(PH)_""""
	I ML'="" W " onchange=mLabel("""_ML_""",this)"
	W "	/>"
	I $D(IVALID) W "<div id="_ID_"err class=invalid-feedback>-</div>"
	Q
FG(FOR,TIT,NAME,ID,PH,ML,VL,SMALL) ;
	w "<div class=""form-group"">" D  W "</div>"
	.w "<label for="""_FOR_""">"_TIT_"</label>"
	.D INPUT(NAME,ID,PH,ML,VL)
	.I SMALL'="" D
	..W "<small id="""_FOR_"Help"" class=""form-text text-muted"">"_SMALL_"</small>"
	Q
NAM(A,IM,W,ZN) ;
	S IM=$G(IM),W=$G(W),ZN=$G(ZN) N BK S BK=0
	I ZN'="" X "I $L($T(BBB^"_ZN_"))" I  X "I $L($T(BACK^"_ZN_"))" S BK=1
	W !,"<script>"
	W !,"document.getElementById('name').innerHTML='"_$$BK1_$$IM_"<BR>"_A_$$BK2_"';"
	W !,"</script>"
	Q
BK1() ;
	I 'BK Q ""
	Q "<span oncontextmenu=event.preventDefault(),mLabel(""BACK"",8) >"
BK2() ;
	I 'BK Q ""
	Q $$BBB_"</span>"
IM() ;
	I IM'="" Q "<img src="""_IM_""" style=width:"_W_" />"
	Q ""
BBB() ;
	N B S B=""
	S B=B_"&nbsp;<button "
	S B=B_"onclick=mLabel(""BACK"",8) "
	S B=B_"class=""btn bg-secondary"" "
	S B=B_">"
	S B=B_"&lt;</button>"
	Q B
CLS(CLS) ;
	I CLS="" S CLS="P"
	N Q
	S Q("P")="primary" ; BLUE
	S Q("S")="secondary" ; GREY
	S Q("C")="success" ; GREEN
	S Q("R")="danger"  ; RED
	S Q("W")="warning" ; YELLOW
	S Q("I")="info"    ; CYAN
	S Q("L")="light"   ; WHITE
	S Q("D")="dark"    ; BLACK
	S Q("K")="link"    ; 
	S Q("M")="muted"   ; light gray
	S Q("w")="white"   ; white
	S Q("B")="body"    ; (default body color/often black) 
	Q Q(CLS)
	; muted,  .text-white, .text-body 
RADIO(VAR,LIST,DEF,AT,ML) ;
	N A,VAL,TXT,ISDIS,ISCHK,MORE
	S ML=$G(ML)
	I $$AT
	N X S X="" 
	F  S X=$O(LIST(X)) Q:X=""  D
	.S A=LIST(X)
	.S VAL=$P(A,D,1)
	.S TXT=$P(A,D,2)
	.S ISDIS=$P(A,D,3)
	.S ISCHK=(VAL=DEF)
	.W !,"<div class=""custom-control custom-radio"">"
	.W !," <input required type=radio"
	.I ML'="" W " onClick=mLabel("""_ML_""",this.value)"
	.W " class=custom-control-input"
	.W " id="_VAR_X
	.W " name="_VAR
	.I ISCHK W " checked=1"
	.I ISDIS W " disabled=1"
	.W $G(MORE)
	.W " value="""_VAL_""""
	.W " />"
	.W !," <label class=custom-control-label style=justify-content:left for="_VAR_X_">"_TXT_"</label>"
	.W !,"</div>"
	;?;I $D(IVALID) W "<div id="_ID_"err class=invalid-feedback>-</div>"
	Q 
CHECKB(VAR,VAL,TXT,ISCHK,AT) ;
	W "<div class=form-check-inline>"
	W "  <label class=form-check-label>"
	W "    <input type=checkbox class=form-check-input"_$$AT
	W " value="""_VAL_""""
	W " name="""_VAR_""""
	I $G(ISCHK) W " checked"
	W " />"
	W TXT
	W "   </label>"
	W "</div>"
	K ^%ESV(9,Id,"A",VAR)
	K @VAR
	;^%ESV(9,"uONtwDHq3ip29oRrofHPB32h5m0d","A","tab1") = 1
	Q
ONENTER(BUTID,IDVEC,IDS) ; Make [Enter] submit the action on the button , make it press
	; BUTID   - id of button (most of the time "search")
	; IDVEC() - vector of text inputs
	; IDS     - or String of ids with "/" delimiter
	W !,"<script>"
	W !,"function doenter(event) {"
	W !,"  if (event.keyCode === 13) {"
	;W !,"    c('DO ENTER1');"
	W !,"    event.preventDefault();"
	;W !,"    c('DO ENTER2 : '+document.getElementById("""_BUTID_"""));"
	W !,"    document.getElementById("""_BUTID_""").click();"
	;W !,"    c('DO ENTER3');"
	W !,"  }"
	W !,"}  "
	N I S I="" F  S I=$O(IDVEC(I)) Q:I=""  D
	.W !,"document.getElementById("""_I_""").addEventListener(""keyup"", function(event) {doenter(event)});"
	I $G(IDS)'="" F I=1:1:$L(IDS,"/") D
	.W !,"document.getElementById("""_$P(IDS,"/",I)_""").addEventListener(""keyup"", function(event) {doenter(event)});"
	W !,"</script>",!
	Q
PAGE(F,T,CUR) ;
	W " <ul class=pagination>"
	W "  <li class=""page-item" I CUR=1 W " disabled"
	w """><span class=page-link href=# onclick=mLabel(""PAGE"",""P"")>Previous</span></li>"
	F P=F:1:T D
	.I T-F>10 I P-F>10,P+1<T,P'=CUR  Q
	.I T-F>10 I P-F>9,P+1<T,P'=CUR W "..." Q
	.W "  <li class=""page-item" I CUR=P W " active"
	.w """><span class=page-link href=# onclick=mLabel(""PAGE"","""_P_""")>"_P_"</span></li>"
	W "  <li class=""page-item" I CUR=T W " disabled"
	w """><span class=page-link href=# onclick=mLabel(""PAGE"",""N"")>Next</span></li>"
	W "</ul>"
	Q
TABS(ZN,VEC) ;
	N TI,M,VAR,TXT,A
	;<!-- Nav tabs -->
	W !,"<ul class=""nav nav-tabs"">"
	S TI="",M=0
	F  S TI=$O(VEC(TI)) Q:TI=""  D TABS1
	W !,"</ul>"
	;<!-- Tab panes -->
	W !,"<div class=tab-content>"
	S TI="",M=0
	F  S TI=$O(VEC(TI)) Q:TI=""  D
	.I $I(M)
	.S A=VEC(TI)
	.S VAR=$P(A,D,1)
	.S TXT=$P(A,D,2)
	.W !," <div class=""tab-pane container "_$S(M<2:"active",1:"fade")_""" id="_VAR_">" X "D "_VAR_"^"_ZN W "</div>"
	W !,"</div>"
	Q
TABS1	;
	S A=VEC(TI)
	S VAR=$P(A,D,1)
	S TXT=$P(A,D,2)
	W !,"<li class=nav-item>"
	W !,"  <a class=""nav-link "_$S($I(M)<2:"active",1:"")_""" data-toggle=tab href=""#"_VAR_""">"_TXT_"</a>"
	W !,"</li>"
	Q
IMG(JPG,ID,ML,DIS,SIZ,PAR) ; 
	W "<a href=# "
	N VAL S VAL="this.id" I PAR["*ALL" S VAL="""*ALL""" ; 
	S PAR=$G(PAR)
	I ML'="" W " onclick=mLabel("""_ML_""","_VAL_")"
	I ID'="" W " id="""_ID_""""
	I DIS'="" W " disabled"
	D PAR
	W ">"
	w "<img "
	I SIZ'="" W " width="_SIZ_"px"
	W " src="""_JPG_""""
	W " />"
	W "</a>"
	Q
WIZ(ZN,COLS) ; Wizard
	N VEC,A,K,C,TI,M,VAR,TXT
	; ** BLD INFO FOR TABS **
	W !,"<ul class=""nav nav-tabs"">"
	F M=1:1 S C=$P(COLS,"/",M) Q:C=""  D
	.S VAR=$P(C,"-",1)
	.S TXT=$P(C,"-",2)
	.W !,"<li class=nav-item>"
	.W !,"  <a class=""nav-link "_$S(M<2:"active",1:"")_""" data-toggle=tab href=""#"_VAR_""">"_TXT_"</a>"
	.W !,"</li>"
	W !,"</ul>"
	W !,"<div class=tab-content>"
	F M=1:1 S C=$P(COLS,"/",M) Q:C=""  D
	.S VAR=$P(C,"-",1)
	.S TXT=$P(C,"-",2)
	.W !," <div class=""tab-pane container "_$S(M<2:"active",1:"fade")_""" id="_VAR_">" D WIZ1 W "</div>"
	W !,"</div>"
	Q
WIZ1 ;
	..X "D "_VAR_"^"_ZN
	Q
CARDIH(ZN,IMG,TIT,AT1,AT2,LAB,OPT) ; CARD WITH TOP IMAGE - HORIZONTAL
	S OPT=$G(OPT)
	N AT
	S AT=$G(AT2)
	W !,"<div class=""card mb-3"" style=""max-width: 540px;"""
	I OPT["ID=" W "id="_$P($P(OPT,"ID=",2),"/",1)_" "
	I OPT["CLC=" W " onClick=mLabel("""_$P($P(OPT,"CLC=",2),"/",1)_""",this) "
	W ">"
	W !,"  <div class=""row no-gutters"">"
	W !,"    <div class=""col-md-4"">"
	w "<img "
	w " src="""_IMG_""" "_$$AT_" />"
	W !,"    </div>"
	W !,"    <div class=""col-md-8"">"
	W !,"      <div class=""card-body"">"
	W !,"        <h5 class=""card-title"">"_TIT_"</h5>"
	N X S X="" F  S X=$O(TIT(X)) Q:X=""  D
	.W !,"        <p class=""card-text"">"_TIT(X)_"</p>"
	;W !,"        <p class=""card-text""><small class=""text-muted"">Last updated 3 mins ago</small></p>"
	W !,"      </div>"
	W !,"    </div>"
	W !,"  </div>"
	W !,"</div>"
	Q  ;  1   2   3   4   5   6
CARDI(ZN,IMG,TIT,AT1,AT2,LAB,OPT) ; CARD WITH TOP IMAGE
	N AT
	S OPT=$G(OPT)
	S AT=$G(AT1)
	W !,"<div class=card "_$$AT_">"
	S AT=$G(AT2)
	W !
	I OPT'["NOCEN" W "<CENTER>"
	D
	.I OPT["VID" W "<video autoplay loop " Q
	.w "<img "
	I OPT["ID=" W "id="_$P($P(OPT,"ID=",2),"/",1)_" "
	I OPT["CLC=" W " onClick=mLabel("""_$P($P(OPT,"CLC=",2),"/",1)_""",this) "
	w "class=card-img-top src="""_IMG_""" "_$$AT_" />"
	W !,"  <div class=card-body>"
	I OPT="RIGHT"  S CL=" text-right"
	I OPT="CENTER" S CL=" text-center"
	W !,"    <h4 "
	I OPT["ID=" W "id="_$P($P(OPT,"ID=",2),"/",1)_"t "
	w "class=""card-title"_CL_""">"
	D WR2(.TIT)
	W "</h4>"
	I LAB'="" W !,"    <p class=card-text>" X "D "_LAB_"^"_ZN W "</p>"
    W !,"  </div>"
	W !,"</div>"
	Q
add ;
	S @$R="-"
	Q
WR(w1,w2,w3,w4) W $$WW Q
WR2(TEXT) ;
	I $D(TEXT)=1  D WR(TEXT) Q
	I $D(TEXT(4)) D WR(TEXT(1),TEXT(2),TEXT(3),TEXT(4)) Q
	I $D(TEXT(3)) D WR(TEXT(1),TEXT(2),TEXT(3)) Q
	I $D(TEXT(2)) D WR(TEXT(1),TEXT(2)) Q
	ZT
	Q
CADD(ID,CL) ; Add/remove classs from object , d-none will make him disappear
	I CL="" S CL="d-none"
	W "document.getElementById("""_ID_""").classList.add("""_CL_""");"
	Q
CDEL(ID,CL) ; 
	I CL="" S CL="d-none"
	W "document.getElementById("""_ID_""").classList.remove("""_CL_""");"
	Q
CSWITCH(ID,CL) ; remove/add class from object
	I CL="" S CL="d-none"
	W "if  (document.getElementById("""_ID_""").classList.contains("""_CL_""")) { document.getElementById("""_ID_""").classList.remove("""_CL_""") }"
	W "else document.getElementById("""_ID_""").classList.add("""_CL_""");"
	Q
SLID(VAR,LIST,B) ;
	W "<input id="""_VAR_""""
	W " type=text"
	;W " data-slider-ticks="[0, 100, 200, 300, 400]" data-slider-ticks-snap-bounds="30" data-slider-ticks-labels='["$0", "$100", "$200", "$300", "$400"]'/>
	W " data-slider-ticks=""["_LIST_"]""""
	W " ata-slider-ticks-snap-bounds="_B
	W " data-slider-ticks-labels='["$0", "$100", "$200", "$300", "$400"]'/>
	Q
OPT2V ; OPT="A=1/B=4/C=2" -> OPT("A")=1...
    N X,A,B,C,V
    S OPT=$G(OPT)
    F X=1:1:$L(OPT,"/") D
    .S A=$P(OPT,"/",X),B=$P(A,"=",1),C=$P(A,"=",2,999)
    .I B'="" S V(B)=C
    M OPT=V
    Q
