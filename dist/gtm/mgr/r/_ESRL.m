%ESRL(F)	; RELOAD *.MES ROUTINE
	;(C) 2019 ELI SMADAR (C)
	;MUMPS MACRO
	; called from /gtm/bin/reload
	;
	;
	;  *** OLD ***  see ^%ESRLM + /gtm/bin/reloadmes , Important label , from label READ and down
	;
	;
	S $eT="S ^ELI1=$ZS Q"
	I F'?.E1".mes" ZT
	S RUT=$P(F,".",1) ;compile will be done by the incrone script
	D READ Q:ERR'=""
	D CMPL(GL,"MES",RUT) Q:ERR'=""
	D SAVE Q:ERR'=""
	Q
READ	;
	S ERR="",GL=$NA(^W(JB,"I")) K @GL
	S UCI1=$$LOWER^%ESS(UCI)
	D G^%ESF("/gtm/"_UCI1_"/r/"_F,GL) Q:ERR'=""
	Q
CMPL(GL,FROM,RUT) ; GL -> GLO 
	;      !!! ALSO CALLED FROM ^%ESDEV  !!! FROM="DEV"
	;                              HERE      FROM="MES"
	N LN,I,M,A,SKIP,LAB,LIN,PRE,B,V,G,X,N,N3,JS
	;
	S LN=0,GLO=$NA(^W(JB,"O")) K @GLO
	S I="",CS=0,JS=0
	F M=1:1 S I=$O(@GL@(I)) Q:I=""  D LINE
	I FROM="DEV" D
	.I $I(M) D ADD1("%CONT ;")
	.I $I(M) D ADD1(" q:'$d(itmVal)")
	.I $I(M) D ADD1(" S M=itmVal")
	.I $I(M) D ADD1(" S M(""ID"")=$G(itmId)") ; S M("ID")=
	.I $I(M) D ADD1(" I M?1""*all"".E D RELOADM^%ESRL")
	.I $I(M) D ADD1(" N %AJAXS S %AJAXS=1") ; Note: on run time (not on compile time)
	.I $I(M) D ADD1(" D @Info") ;                   also you have ajmode=1
	.I $I(M) D ADD1(" Q")
	Q
RELOADM ;
	;M="*all*fld1:val1*fld2:val2*..."
	; -> %FL(VAR1)=VAL1
	;         :
	N K,A,A1,A2 K %FL
	F K=3:1:$L(M,"*") S A=$P(M,"*",K),A1=$P(A,":",1),A2=$P(A,":",2,999) I A1'="" S %FL(A1)=A2
	D REVAR ;ALL THE TIME ! REPLAVE THIS v
	;ALL THE TIME;I $D(%FL("REVAR")) D REVAR ; To do it automatically
	Q
REVAR ; %FL(VAR1)=VAL1 -> VAR1=VAL1
	;        :             :
	; CALLED FROM xyz.html AT THE CHECK LABEL
	; or define a field name "REVAR" see label RELOADM+6
	N REVAR,I S I="" F  S I=$O(%FL(I)) Q:I=""  S @I=%FL(I)
	Q
LINE	;
	S A=^(I)
	K SKIP
	D ADD(A)
	Q:$D(SKIP)
	D ADD1(LAB_$C(9)_PRE_LIN)
	Q
ADD1(A) ;
	S @GLO@($I(LN))=A
	Q
ADD(A)	;
	S B=A
	S REM=""
	S CS=M*$$CRC^%ESS(A)+CS
	S B=$TR(B,$C(9,13)," ")
	S LAB=$P(B," ",1) I LAB?1"<".E S B=" "_B,LAB=""
	S LIN=$P(B," ",2,99999)
	S LIN=$$CUTL^%ESS(LIN) ; CLEAN LEADING BLANKS
	;
	S PRE="",OK=0
	I LIN?1.".".E,JS=0 D
	.I LIN?."." S PRE=LIN,LIN="" Q
	.F X=1:1:$L(LIN) S C=$E(LIN,X),PRE=PRE_C I C'=".",C'=" " S PRE=$E(LIN,0,X-1),LIN=$E(LIN,X,99999),OK=1 Q
	.I 'OK S PRE=$E(LIN,0,X),LIN=$E(LIN,X+1,99999)
	;
	I LIN?1"FOR "1.AN1" IN ".E D FOR Q
	I LAB="VERSION()"          D VER Q
	I LIN?1"#".E               D MAC Q:ok
	I M=1                      D TOP Q
	;
	; V2
	; in v2 will will naturally detect html expressions with no need for #H at the starts
	;
	I LAB'=""        S JS=0,NL=0
	I LAB="",LIN="Q" S JS=0,NL=0
	I JS D GOHTM Q  ;Using #HTML:START
	I LIN?." " Q
	I LIN?1.A.":"." ".E Q  ;I AM MUMPS
	I LIN?1";".E        Q  ;I AM MUMPS
	; I AM HTML
GOHTM  ;
	N CM
	I LIN?." "1"<".E1"D  ".E1">"." " D EMBED("D  ") Q  ;problem <TD WIDTH=1>
	I LIN?." "1"<".E1"D "."^".ULN1ULN.E1">"." " D EMBED("D ") Q
	I LIN?." "1"<".E1"S "."$"1E.E1"=".E1">"." " D EMBED("S ") Q
	I LIN?." "1"<".E1"I "."$"1E.E1">"." " D EMBED("I ") Q
	I LIN?1"W ".E Q
	I PRE'="" S B=LIN
	I B?." "1"//".E S LIN=";"_B Q
	I B?.E1"// ".E S REM="// "_$P(B,"//",2,999999),B=$P(B,"//",1)
	S LIN="#H "_B ;
	D MAC
	Q
  <div class="d-t">D  </div> 
EMBED(CM) ; <table><tr>D  q:end=3</tr></table>
	;       ^^^^^^^^^^^mmmmmmmmmm^^^^^^^^^^^^^
	D MLABEL
	N A,B,C ;CM="D  "
	S A=$P(LIN,CM,1)
	S A=$$CUTLT^%ESS(A)
	S A=$$GERESH(A)
	S B=$P($P(LIN,CM,2),"<",1)
	S C=$P($P(LIN,CM,2),"<",2,999)
	S LIN="W """_A_""" "_CM_B_" W ""<"_C_""""
	Q
MLABEL ;
	D STYLE
	D EVENT
	Q
STYLE ;
	I LIN?.E1" ||"1U.E1"||>".E S LIN=$$REP^%ESS(LIN,"||>","|| >")
	I LIN?.E1" ||"1U.E1"|| ".E D
	.N AT
	.S AT=$P($P(LIN," ||",2),"|| ",1)
	.S LIN=$P(LIN," ||",1)_$$AT^%ESBS_$P(LIN,"|| ",2,999)
	.S REM=""
	Q
EVENT ;
	I LIN?.E1" |"1.AN1","1.E1"| ".E D  ; |LABEL,this|   |label,this,onChange|
	.N A,EVN,LAB,VAR S EVN="onclick"
	.S A=$P($P(LIN," |",2),"| ",1)
	.S LAB=$P(A,",",1) I LAB'["^" I $D(RUT) S LAB=LAB_"^"_RUT
	.S VAR=$P(A,",",2,99)
	.I $P(A,",",3)?1"on".E S EVN=$P(A,",",3),VAR=$P(A,",",2)
	.S LIN=$P(LIN," |",1)_" "_EVN_"=mLabel("""_LAB_""","_VAR_") "_$P(LIN,"| ",2,999)
	.S REM=""
	Q
HTM ;
	I LIN?1"#HTML:START".e S JS=1,SKIP=1,NL=$P(LIN,":",3)["NO" ; Do not skip line on <script>
	I LIN?1"#HTML:STOP".e  S JS=0,NL=0
	I LIN?1"#HTML:END".e   S JS=0,NL=0
	D MLABEL 
	;
	I LIN["script",'NL S LIN="W !,"""_$$GERESH($P(LIN," ",2,9999))_"""" Q
	S LIN="W """_$$GERESH($P(LIN," ",2,9999))_"""" I REM'="" S LIN=LIN_" ;"_REM
	S REM=""
	Q
MTM ;
	N A S A=$P(LIN," ",2,9999)
	S A=$$CUTL^%ESS(A)
	S LIN="W !,"_A
	Q
GERESH(A) ;
	N X,B,C,M S B="",M=0
	F X=1:1:$L(A) S C=$E(A,X) D
	.I C'="""" S B=B_C Q
	.I $E(A,X-1)="_" S M=0,B=B_C Q
	.I $E(A,X+1)="_" S M=1,B=B_C Q  ;USE ' if you problem here
	.I M=1 S B=B_C Q
	.S B=B_C_C
	Q B
	; *OLD*
	N G S G=""""
	Q $$REP^%ESS(A,G,G_G)
FOR	; FOR X IN ^W(JB,SES) Do LINE
	S V=$P($P(LIN,"FOR ",2)," IN ",1)
	S G=$P($P(LIN," IN ",2)," ",1)     ; A. @GLO2   B. VEC C. ^ELI  D. ^ELI(1,2)
	S X=$P($P(LIN," IN ",2)," ",2,999999)
	S LIN="N "_V_" S "_V_"="""" F  S "_V_"=$O("_$$FOR1_" Q:"_V_"=""""  "_X
	Q
FOR1() ;
	I G?1"@".E1"@(".E Q $E(G,0,$L(G)-1)_","_V_"))"  ; @GLO@(LN,I)
	I G?1"@".E     Q G_"@("_V_"))"               ; @GLO      ;A
	I G?1"^".E1")" Q $E(G,0,$L(G)-1)_","_V_"))"  ; ^W(..)    ;D
	I G[")"        Q $E(G,0,$L(G)-1)_","_V_"))"  ; VEC(1)
	Q G_"("_V_"))" ;B+C
	Q
SAVE ; called from ^%esrlm
	S FSAV="/gtm/"_UCI1_"/r/"_$P(F,".",1)_".m"
	D P^%ESF(GLO,FSAV) W !,FSAV
	K @GLO
	Q
VER	;
	I LIN'?1"Q """1N.E Q
	S N=$P(LIN,"""",2)
	S N3=$P(N,".",3)+1
	S N3=$E(10000,2,4-$L(N3))_N3
	S $P(N,".",3)=N3
	S $P(LIN,"""",2)=N
	S LIN=LIN_" ;"_$$NOW^%ESD_" "_$$TIMS^%ESD
	Q
MAC	;
	s ok=1
	I LIN?1"#INCLUDE ".E D INC Q
	I LIN?1"#HTML".E     D HTM Q
	I LIN?1"#H".E        D HTM Q
	I LIN?1"#M".E        D MTM Q
	s ok=0
	Q
INC	;
	N GL1,F,ERR,UCI1
	S UCI1=$$LOWER^%ESS($$UCI^%ZU)
	S GL1=$NA(^W(JB,3)) K @GL1
	S F="/gtm/"_UCI1_"/r/"_$TR($P(LIN," ",2),"%","_")_".m"
	D ADD1(" ;INCLUDE file="_F_" **START**")
	D G^%ESF(F,GL1) I ERR'="" S F="/gtm/mgr/r/"_$TR($P(LIN," ",2),"%","_")_".m" S ERR="" D G^%ESF(F,GL1) I ERR'="" Q
	D ADD1(" Q")
	N I S I="" F  S I=$O(@GL1@(I)) Q:I=""  D
	.D ADD1(^(I))
	D ADD1(" Q  ;INCLUDE **END**")
	S SKIP=1
	Q
TOP	;
	S LIN=LIN_"  ; Recompile from .mes source (do not edit)"
	Q
M   ;
	Q
VERSION() Q "1.10" ; <dic id=a"_ID_"a"_X_">D  </div>
    ;Q "1.09" ;| label,this,event|
	;Q "1.08" ; ||W80px|| -> style=width:80px + MORE COMMANDS D LABEL, SET,IF IN <div>ccc</div>
	;Q "1.07" ; |label,this|-> mLabel(label,this)
	;Q "1.06" ; Support embeded // remark inside end of line and at begining
	;Q "1.05" ; IMPROOVED EMBEDED
	;Q "1.04" ; # INSIDE JS=1
	;Q "1.03" ; Support D(SP)(SP) inside embeded html
	;Q "1.02" ; Support natural html embeded
	;Q "1.01"
