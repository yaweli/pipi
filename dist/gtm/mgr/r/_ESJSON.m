%ESJSON ; JSON
	;
GETV(GLO) ; load var vector from global to local V()
	 K V
	 N I,VAR S I="" F  S I=$O(@GLO@(I)) Q:I=""  D
	 .S VAR=$P(I,D,1,$L(I,D)-1) I VAR="" Q
	 .S V(VAR)=$G(^(I))
	 Q
GRUN(ZN,%GLO,J0,LAB,%GLO1) ;
	N J S J=J0 I J'?.E1"_" ZT
	F  S J=$O(@%GLO@(J)) Q:J'[J0  Q:J=""  D
	.S @%GLO1=$NA(^(J,"V"))
	.N V D GETV(@%GLO1)
	.X "D "_LAB_"^"_ZN
	Q
GNEXT() ; S GLO2=$$GNEXT(GLO1,"V","D","J_","item_") ; -> FULL GLOBAL NEXT LEVELS ON X_
	N L,J,C S ERR1=""
	F L=1:1 S C="L"_L Q:'$D(@C)  D
	.I $D(@GL@(@C)) S GL=$NA(^(@C)) Q
	.S J=$O(@GL@(@C)) I J="" S ERR1=$R Q
	.S GL=$NA(^(J))
	.I $P(J,D,0,$L(@C,D)-1)'=$P(@C,D,0,$L(@C,D)-1) S ERR1=$R Q
	Q GL
T1	;
	S GLO1="^W($J,1)" K @GLO1 
	S GLO2="^W($J,2)" K @GLO2
	S @GLO1@(10)="{""tot1"":""val1"",""tot2"":""val2""" 
	S @GLO1@(11)=",""tot3"":""val3"",""VEC"":[1,2,3]}"
	D JS2GL(GLO1,GLO2)
	ZWR @GLO2@(*)
	Q
tryJS2GL(GLOI,GLO) ;
	N A
	S A=""
	S I="" F  S I=$O(@GLOI@(I)) Q:I=""  D
	.S A=A_^(I)
	I $$decode(A,GLO)
	Q
zJS2GL(GLOJ,GLO) ;
	N %A
	K @GLO
	I $$decode(GLOJ,GLO)
	Q
encode(glo)
	;
	; Return a JSON representation for the supplied global
	;
	new json,subscript,base,comma
	set $G(json)=""

	; Return empty string if global don't exist.
	quit:$data(@glo)=0 ""

	set json=json_"{"
	set:$data(@glo)'=10 json=json_""""":"""_$$escape(@glo)_"""",comma=1
	if $zfind(glo,")")=0 set base=glo_"("
	else   set base=$zextract(glo,1,$zlength(glo)-1)_","
	set glo=base_""""")"
	set subscript=$order(@glo)
	for  quit:subscript=""  do
	.	set:$data(comma) json=json_","
	.	set json=json_""""_subscript_""":"
	.	set glo=base_""""_subscript_""")"
	.	if $data(@glo)=1 set json=json_""""_$$escape(@glo)_""""
	.	else  set json=json_$$encode(glo)
	.	set subscript=$order(@glo)
	.	set comma=1
	set json=json_"}"

	quit json
next() ;
	n a,i
	i '$D(%A) Q ""
	s i=$o(@%A@("")) i i="" q ""
	s a=@%A@(i)
	k @%A@(i)
	q a
decode(json,var,nextisname,inarray)
	;
	; Populate the local variable 'var' based on the json string received.
	; Return 0 on success, 1 otherwise
	;
	new status,first,subscript,length,base,end
	; Quit on empty string
	I json?1"^".E S %A=json,json=""
	i json="" s json=$$next
	quit:json="" 1
	set status=0
	set end=0
	set length=$zlength(json)
	if $zextract(var,$zlength(var))=")" set base=$zextract(var,1,$zlength(var)-1)_","
	else  set base=var_"("
	for  quit:json=""  quit:status'=0  quit:end=1  do
	.	set first=$zextract(json,1,1)
	.	if first="{" do  if 1
	.	.	set:$get(inarray,0)=1 var=base_"0)" ; First item of array, add a '0' subscript
	.	.	set json=$zextract(json,2,length) ; skip over {
	.	.	set status=$$decode(.json,var,1)
	.	else  if first="," do  if 1
	.	.	set json=$zextract(json,2,length) ; skip over ,
	.	.	if $get(inarray,0)>0 do
	.	.	.	set subscript=inarray
	.	.	.	set inarray=inarray+1
	.	.	else  do
	.	.	.	set subscript=$zpiece(json,"""",2)
	.	.	.	set json=$zpiece(json,"""",3,length) ; skip over ..."
	.	.	set var=base_""""_subscript_""")"
	.	else  if first=":" do  if 1
	.	.	set json=$zextract(json,2,length) ; skip over :
	.	else  if first="[" do  if 1
	.	.	set json=$zextract(json,2,length) ; skip over [
	.	.	set status=$$decode(.json,var,0,1)
	.	else  if first="""" do  if 1
	.	.	new value,piece
	.	.	set:$get(inarray,0)=1 var=base_"0)" ; First item of array, add a '0' subscript
	.	.	set piece=2
	.	.	set value=$zpiece(json,"""",piece)
	.	.	for  quit:$zextract(value,$zlength(value))'="\"  do ; Handle espaced '"'
	.	.	.	set piece=piece+1
	.	.	.	set value=$zextract(value,1,$zlength(value)-1)_""""_$zpiece(json,"""",piece)
	.	.	if $get(nextisname,0)=1 set var=base_""""_value_""")" set nextisname=0
	.	.	else  set @var=value
	.	.	set json=$zpiece(json,"""",piece+1,length) ; skip over ..."
	.	else  if first="}" do  if 1
	.	.	set json=$zextract(json,2,length) ; skip over }
	.	.	set end=1
	.	else  if first="]" do  if 1
	.	.	set json=$zextract(json,2,length) ; skip over ]
	.	.	set end=1
	.	else  if $$FUNC^%UCASE($zextract(json,1,5))="FALSE" do  if 1
	.	.	set:$get(inarray,0)=1 var=base_"0)" ; First item of array, add a '0' subscript
	.	.	set @var=0
	.	.	set json=$zextract(json,6,length) ; skip over false
	.	else  if $$FUNC^%UCASE($zextract(json,1,4))="TRUE" do  if 1
	.	.	set:$get(inarray,0)=1 var=base_"0)" ; First item of array, add a '0' subscript
	.	.	set @var=1
	.	.	set json=$zextract(json,5,length) ; skip over true
	.	else  do ; consider its a number
	.	.	set:$get(inarray,0)=1 var=base_"0)" ; First item of array, add a '0' subscript
	.	.	set @var=$get(@var,"")_$zextract(json,1)
	.	.	set json=$zextract(json,2,length) ; skip over the 1st digit
	set var=base

	quit status

escape(txt)
	;
	; Return an escaped JSON string
	;
	new escaped,i,a
	set escaped=""
	for i=1:1:$zlength(txt) do
	.	set a=$zascii(txt,i)
	.	if ((a>31)&(a'=34)&(a'=92)) set escaped=escaped_$zchar(a)
	.	else  set escaped=escaped_"\u00"_$$FUNC^%DH(a,2)

	quit escaped
	Q
T	;
	D JS2GL("^ELI","^W($J,11)")
	
	Q
JS2GL(GLOA,GLO2,COND) ;
     S GLOA=$NA(@GLOA)
     S GLO2=$NA(@GLO2)
     N (GLOA,GLO2,COND,disp)
     S OFF=$L(GLO2,",")
     K @GLO2 S D="_"
     S M=0,LV=0,KEY=0,KL=5,GER=0,BS=1,UU=0,NN=0
     I $D(COND(".DIGIT")) S KL=COND(".DIGIT")
     I $D(COND(".BACKS")) S BS=0 ; i want to see backslash
     I $D(COND(".UUUUU")) S UU=1 ; convert \u01234 -> HEX2DEC(1234) -> $C(DEC)
	 I $D(COND(".NEWLN")) S NN=1 ; "\n" KEEP
     S I=""
     F  S I=$O(@GLOA@(I)) Q:I=""  D J1
     Q
J1  ;
	S A=$TR(^(I),$C(13))
	F K=1:1:$L(A) S C=$E(A,K) D J2
	Q
J2  ;
	 D D
	 ; wait for object
	 I M=0,C="{"  S M=1 D DP("J") S VAR="" Q  ; open new object
	 I M=0,$$ISSPACE(C) Q                ; wait for "{"
	 I M=0,C="," Q
	 I M=0,C="]" D RL S M=1 Q
	 I M=0,C="""" S M=1  ;try
	 I M=0,C="}" S M=6         D D
	 ;I M=0,C="[" S M=4,VAR=$G(VAR,"."),FVAR=VAR D DP(VAR) Q
	 I M=0,C="[" S M=4,VAR=$G(VAR,"J"),FVAR=VAR D DP(VAR) D NEW Q  ;!!!!! ADD D NEW
	 I M=0,VMOD="[" S M=4
	 I M=0,VMOD="{" S M=1,VAR=""
	 I M=0 ZT
	 ; wait for start VAR
	 I M=1,C="""" S M=2,VAR="",GER=1 Q   ; start var
	 I M=1,C="{" S M=0 G J2        ; goto open new obj  
	 I M=1,$$ISSPACE(C) Q          ; wait for start var
	 I M=1,$$ISVAR(C) S M=2 S GER=0  G J2   ; goto add char to var name
	 I M=1,C="," Q
	 I M=1,C="}" S M=6 G J2
	 I M=1,C="]" S M=0 G J2 ;try
	 ;I M=1,C="[" S M=4,VAR=$G(VAR,"J"),FVAR=VAR D DP(VAR) D NEW Q  ;!!!!! ADD D NEW
	 I M=1,VMOD="[" S M=4,VAR="",FVAR=VAR
	 I M=1 ZT
	 ; inside a VAR
	 I M=2,C="""" S M=3,FVAR=VAR Q   ;end of var
	 I M=2,$$ISVAR(C) S VAR=VAR_C Q  ;add char to var
	 I M=2,C=" " S C="""" G J2       ;goto end var
	 I M=2,C=":" S M=3,FVAR=VAR      ;end of var
	 I M=2 b  ZT  ; VARIABLE NAME - ILLEGAL
	 ; m=3 wait for ":" , delimiter var:val
	 I M=3,$$ISSPACE(C) Q          ;wait for :
	 I M=3,C=":" S M=4 Q  ;D DP(VAR) Q  ;down level with VAR
	 I M=3 ZT
	 ;
	 ; m=4 wait for value
	 I M=4,C="""" S M=5,VAL="",GMOD=1 Q  ;start val
	 I M=4,C="{" S M=1 D DP(VAR) D NEW Q  ; deep new level
	 I M=4,$$ISSPACE(C) Q          ;wait for start value
	 ;I M=4,C="[" S M=1 D DP(VAR) Q  ; deep new level
	 I M=4,C="[" S M=0 G J2
	 I M=4,C?1NA!(C="-") S M=5,VAL=C,GMOD=0 Q
	 I M=4,C="]" D RL S M=0 Q
	 I M=4,C=",",VMOD="[" Q
	 I M=4 B  ZT  ;S M=5,VAL=""  B  Q      ;rare but check it and aprove if its not error
	 ;
	 ; m=5 inside a value
	 I M=5,C="\",NN S CC=$E(A,K+1) I "nrt"[CC S K=K+1 S VAL=VAL_"\"_CC Q  ; \n
	 I M=5,C="\" S M=7 Q:BS  ;next 1 char , even if it's " ignore - it's simple text
	 I M=5,C="""",VMOD="{" S M=6,FVAL=VAL,@GLO2@($$K(FVAR))=$E(FVAL,0,31000),GER=0 Q  ;end of single val or object pair
	 I M=5,C="""",VMOD="[" S M=6,FVAL=VAL,@GLO2@($$K("J"))=$E(FVAL,0,31000),GER=0 Q  ;end of single val or object pair
	 I M=5,GMOD=0,C=" " S C="""" G J2
	 I M=5,GMOD=0,C="," S C="""" D J2 S C="," ;I M=4 Q
	 I M=5,GMOD=0,C="}" S C="""" D J2 S C="}"
	 I M=5,GMOD=0,C="]" S C="""" D J2 D RL S M=0 Q
	 I M=5 S VAL=VAL_C Q
	 ;
	 ; M=6 wait for next value
	 I M=6,$$ISSPACE(C) Q  ;wait for next value
	 I M=6,C="," D NEW
	 I M=6,C=",",VMOD="{" S M=1 Q  ;next var
	 I M=6,C=",",VMOD="[" S M=4 Q  ;next val
	 I M=6,C="," S M=1 Q 
	 I M=6,C="}" D RL S M=0 Q
	 I M=6,C="]" D RL S M=0 Q
	 I M=6 B
	 ;
	 I M=7,UU,C="u" S C=$$UU($E(A,K+1,K+4)),K=K+4 ; \u1234
	 I M=7    S M=5 S VAL=VAL_C Q
	 ;
	 B
	 Q
UU(HEX) ;
	Q $C($$HEX2DEC(HEX))
	Q
HEX2DEC(%X) ; 
	N %i,%j,%D
	S %D=0 F %i=1:1:$L(%X) S %j=$F("0123456789ABCDEF0123456789abcdef",$E(%X,%i)) Q:'%j  S %D=%D*16+(%j-2#16)
	Q %D
NEW ;
	 S (VAL,FVAL)="",(VAR,FVAR)=""
	 Q
D ;
	I '$D(disp) Q
	S ^ELI=K_","_I_","_C
	Q
ISVAR(C) ; var name 
	 I C?1A Q 1
	 I C="-" Q 1
	 I C="_" Q 1 
	 I C="." Q 1
	 I C?1N  Q 1
	 I GER I C=" " Q 1 ;inside geresh, the space can be a var
	 I GER I $A(C)>127 Q 1 ;inside geresh, UNUCODE
	 ;I GER Q 1 ;inside geresh
	 Q 0
ISSPACE(C) ;
	 I C=" " Q 1
	 I C=$C(9) Q 1
	 Q 0
DP(VAR) ;
	 S LV=LV+1
	 S VMOD=C
	 S VMOD(LV)=C ; "{" or "[" , object or aray
	 I '$G(COND("N"))!(LV>$G(COND("N"))) S GLO2=$NA(@GLO2@($$K(VAR),"V"))
	 S VMOD(LV,"G")=GLO2
	 S VMOD(LV,"V")=$G(VAR)
	 ;I $D(disp) w !,"deep "_LV_" "_C_" : "_$G(VAR)
	 Q
RL   ; release level
	 S LV=LV-1
	 S M=0
	 I LV S VMOD=VMOD(LV),GLO2=VMOD(LV,"G"),VAR=VMOD(LV,"V")
	 ;I $D(disp) w !,"rest "_LV_" "_VMOD_" : "_$G(VAR)
	 Q
K(VAR) ;
	 I VAR="" S VAR="J"
	 I $D(COND("IC",VAR)) Q "I"
	 N K S K=VAR 
	 I 1 S K=K_D_$$KEY
	 Q K
KEY() ;
	 I $I(KEY)
	 Q $E("00000000000000000000",0,KL-$L(KEY))_KEY
VER() Q "9.04" ; E.S

