%ESWS   ;    NEW FOR GTM
    ;
CGI	; ENTRY FOR UNIX - METHOD="GET"
	; FOR /cgi-bin/Es
	S $ET="W !,$ZS" D START^%ZU
    ;
    ;W "Content-type: text/html",!!
	F  R A Q:A="{sof}"  D LO
	D FIX
	D WSEI
	Q
FIX	;
	I $D(VRU("HTTP_REFERER")) S VR("Referer")=VRU("HTTP_REFERER")
	S QUERY=$G(VRU("QUERY_STRING"))
	I $D(VRU("HTTP_X_UP_SUBNO")) S VR("x-up-subno")=VRU("HTTP_X_UP_SUBNO")
	I $D(VRU("HTTP_USER_AGENT")) S VR("User-Agent")=VRU("HTTP_USER_AGENT")
	Q
WSP	;
	D ^%ESWSEP
	D WSEI
	Q       
WSEI	;
	I $G(QUERY)["Id" s Id=$p($p(QUERY,"Id=",2),"&") i $d(^%ESV(9,Id,"A","Umode")) S Umode=^("Umode") ; prepark of variables string
	S %CTYPE="text/html"
	I $D(^CURRENT("METAHEB")),$G(QUERY)'["meta",'$d(Umode) S %CTYPE=%CTYPE_"; charset=ISO-8859-8"
	; <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-8">
	W "Content-Type: "_%CTYPE,!
	W !
	D ^%ESWSE
	Q
LO	;
	I A'?.E1"=".E Q
HT	;
	N V,G
	S G=$P(A,"=",1)
	S V=$P(A,"=",2,9999999)
	I V?1"$'".E1"'" S V=$P(V,"'",2)
	I V?1"'".E1"'" S V=$P(V,"'",2)
	S VRU(G)=V
	Q
