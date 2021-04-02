%ESET	; ERROR TRAP
	D START^%ZU
	I $ZS["%GTM-E-STACKCRIT," Q
	I ZV="GTM" D GTM Q
	I $ZE["DKFUL" Q
	I $ZE["FRAMES" Q
	I $ZE["FILEFU" Q
	S ZR=$ZR,ZE=$ZE
	S ^LASTE=$ZE
	S %DAT=$ZD(+$H,3)
	S RUN=$ZP(^ERR(%DAT,""))+1
	S ^(RUN)=$ZT($P($H,",",2))_"_"_ZE_"_"_ZR_"_"_$G(OPR)
	F I="$I" X "S ^ERR(%DAT,RUN,I)="_I
	I $ZE["WRITE" Q
	I $I="00" D WEB Q
	I $I["pts" D DIS Q
	I $I["|TRM|" D DIS Q
	I $I["tty" D DIS Q
	I $I["|TCP|" D WEB Q
	Q
DIS	;
	W !,ZE
	Q
WEB	;
	W !,"<FONT COLOR=RED><BR>"
	W "<TT>",$TR(ZE,"<>","()"),"</PRE>"
	Q
GTM	;
	S ZR=$R,ZE=$ZS
	S ^LASTE=ZE
	S %DAT=$ZD(+$H,"YEAR-MM-DD")
	S RUN=$ZP(^ERR(%DAT,""))+1
	S ^(RUN)=$ZD($H,"24:60:SS")_"_"_ZE_"_"_ZR_"_"_$G(OPR)
	;F I="$I" X "S ^ERR(%DAT,RUN,I)="_I
	;I $ZE["WRITE" Q
	I $I="0" D WEB Q
	I $I["pts" D DIS Q
	I $I["tty" D DIS Q
	D WEB
	Q
