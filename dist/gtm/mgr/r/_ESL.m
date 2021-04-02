%ESL ; mail sms or whatsapp utility (c) eli smadar 4m
    Q
WSA(TEL,MSG) ; send whatsapp
    S PRE="whatsapp:"
    D SMS1
    Q
SMS(TEL,MSG) ; send sms
    ;
    N PRE
    S PRE=""
SMS1 ;
    I $D(^%BLOCK("SMS")) S ERR="" Q  ; block temp , system wide , all sms
    N M,C,F S ERR=""
    ;I TEL?1"+".E S TEL="%2B"_$E(TEL,2,99)
    S M=MSG
    S M=$TR(M," ","+")
    I M["&" S M=$$REP^%ESS(M,"&","\&")
    ;
    N CY1 S CY1=1 I $D(CY) S CY1=CY
    S OPR=$G(^["MGR"]CURRENT("SMS",CY1)) I OPR="" S OPR="SMSCENTER"
B   ;    
    D @OPR
    Q
TWILIO ;;
    I TEL'?1"+".E D
    .I '$D(CN) ZT
    .I CN'?2U  ZT
    .S TEL="+"_$P(^T(0,"CN",CN),D,5)_$E(TEL,2,99)
    N G M G=^["MGR"]CURRENT("SMS",CY1)
    S C="curl -s "
    S C=C_"""https://api.twilio.com/2010-04-01/Accounts/AC193c02b2c50ea66efd50c26ccecc118b/Messages.json"""
    S C=C_" -X POST "
    S C=C_" --data-urlencode ""To="_PRE_TEL_""""
    S C=C_" --data-urlencode ""From="_PRE_G("FROM")_""""
    S C=C_" --data-urlencode ""Body="_MSG_""""
    S C=C_" -u AC193c02b2c50ea66efd50c26ccecc118b:aa40971b1f33012a841460c92763e658"
    ;
    ; ** SEND **
    S F="/tmp/sms"_$J_".tmp"
    K ^W(JB,"X1")
    S ^W(JB,"X1",1)="#!/bin/sh"
    S ^W(JB,"X1",2)=C
    D P^%ESF($NA(^W(JB,"X1")),F) H 0.1
    N ANS
    D CG^%ESF("sh "_F)
    ;
    K ^ELI11 I $D(ANS) M ^ELI11=ANS
    ; {"code": 21212, "message": "The 'From' number %2B12564454298 is not a valid phone number, shortcode, or alphanumeric sender ID.", "more_info": "https://www.twilio.com/docs/errors/21212", "status": 400}
    I '$D(ANS(1)) S ERR="" Q
    I ANS(1)["error_message"": null" S ERR="" Q
    S ERR=ANS(1)
    ; OK
    ; {"sid": "SM2e6ec2a957694c7daa0d5cafde0bb753", "date_created": "Sat, 31 Oct 2020 08:25:05 +0000", 
    ;"date_updated": "Sat, 31 Oct 2020 08:25:05 +0000", "date_sent": null, "account_sid": "AC193c02b2c
    ;50ea66efd50c26ccecc118b", "to": "+972523255581", "from": "+12564454298", "messaging_service_sid":
    ;null, "body": "Tes send 2 eli", "status": "queued", "num_segments": "1", "num_media": "0", "dire
    ;ction": "outbound-api", "api_version": "2010-04-01", "price": null, "price_unit": "USD", "error_c
    ;ode": null, "error_message": null, "uri": "/2010-04-01/Accounts/AC193c02b2c50ea66efd50c26ccecc118
    ;b/Messages/SM2e6ec2a957694c7daa0d5cafde0bb753.json", "subresource_uris": {"media": "/2010-04-01/A
    ;ccounts/AC193c02b2c50ea66efd50c26ccecc118b/Messages/SM2e6ec2a957694c7daa0d5cafde0bb753/Media.json
    ;"}}
    Q
RAPIDTWILIO ;
    I TEL'?1"%2B".E I $D(TEL("FULL")) S TEL="%2B"_$E(TEL("FULL"),2,99)
    N G M G=^["MGR"]CURRENT("SMS",CY1)
T0  ;    
    I G("FROM")?1"+".E S G("FROM")="%2B"_$E(G("FROM"),2,99)
    S C="curl -s --request POST "
    S C=C_" --url 'https://rapidapi.p.rapidapi.com/2010-04-01/Accounts/"_G("SID.SMS")_"/Messages.json"
    S C=C_"?from="_G("FROM")
    S C=C_"&body="_M
    S C=C_"&to="_TEL
    S C=C_"'"
    S C=C_" --header 'x-rapidapi-host: "_G("HOST")_"'"
	S C=C_" --header 'x-rapidapi-key: "_G("KEY")_"'"
    ; ** SEND **
    S F="/tmp/sms"_$J_".tmp"
    K ^W(JB,"X1")
    S ^W(JB,"X1",1)="#!/bin/sh"
    S ^W(JB,"X1",2)=C
    D P^%ESF($NA(^W(JB,"X1")),F) H 0.1
    N ANS
    D CG^%ESF("sh "_F)
    ;
    K ^ELI11 I $D(ANS) M ^ELI11=ANS
    I '$D(ANS(1)) S ERR="SMS COM ERROR" Q
    I ANS(1)["status"":""delivered""" S ERR="" Q
    I ANS(1)["status"":""sent""" S ERR="" Q
    ; B{"accountSid":"AC5a22e99b3ffbe76485809be5b00fc55b","apiVersion":"2010-04-01","body":"example from system","dateCreated":"2020-10-23T11:25:13.000Z","dateUpdated":"2020-10-23T11:25:18.000Z","dateSent":"2020-10-23T11:25:13.000Z","direction":"outbound-api","errorCode":null,"errorMessage":null,"from":"+972529434623","messagingServiceSid":null,"numMedia":"0","numSegments":"1","price":"0.02300","priceUnit":"USD","sid":"SMe77806b992554c57b9e37c97bd8b763f","status":"delivered","subresourceUris":{"media":"/2010-04-01/Accounts/AC5a22e99b3ffbe76485809be5b00fc55b/Messages/SMe77806b992554c57b9e37c97bd8b763f/Media.json","feedback":"/2010-04-01/Accounts/AC5a22e99b3ffbe76485809be5b00fc55b/Messages/SMe77806b992554c57b9e37c97bd8b763f/Feedback.json"},"to":"+972523255581","uri":"/2010-04-01/Accounts/AC5a22e99b3ffbe76485809be5b00fc55b/Messages/SMe77806b992554c57b9e37c97bd8b763f.json"}
    I ANS(1)?1"{""status"":".E1"""message"":".E S ERR=$P(ANS(1),"""",6) Q
    ; "{""status"":400,""message"":""The From phone number +97233767082 is not a valid, SMS-capable inbound phone number or short code for your account."",""code"":21606,""moreInfo"":""https://www.twilio.com/docs/errors/21606""}"
    S ERR="SMS UNKNOWN ERROR ("_$TR($G(ANS(1)),"{}"",:","     ")_")"
    Q
doc  ; {
  "accountSid": "AC5a22e99b3ffbe76485809be5b00fc55b",
  "apiVersion": "2010-04-01",
  "body": "message to eli : עברית",
  "dateCreated": "2020-10-23T07:26:42.000Z",
  "dateUpdated": "2020-10-23T07:26:46.000Z",
  "dateSent": "2020-10-23T07:26:42.000Z",
  "direction": "outbound-api",
  "errorCode": null,
  "errorMessage": null,
  "from": "+972529434623",
  "messagingServiceSid": null,
  "numMedia": "0",
  "numSegments": "1",
  "price": "0.02300",
  "priceUnit": "USD",
  "sid": "SM1a613b43e1424274bdba712d23d85e31",
  "status": "delivered",
  "subresourceUris": {
    "media": "/2010-04-01/Accounts/AC5a22e99b3ffbe76485809be5b00fc55b/Messages/SM1a613b43e1424274bdba712d23d85e31/Media.json",
    "feedback": "/2010-04-01/Accounts/AC5a22e99b3ffbe76485809be5b00fc55b/Messages/SM1a613b43e1424274bdba712d23d85e31/Feedback.json"
  },
  "to": "+972523255581",
  "uri": "/2010-04-01/Accounts/AC5a22e99b3ffbe76485809be5b00fc55b/Messages/SM1a613b43e1424274bdba712d23d85e31.json"
     }
     Q
     ; new sid with url:
     {20 items
    "sid":"MG7269f007ed8bd9b4c2913a5fbcb38203"
    "accountSid":"AC5a22e99b3ffbe76485809be5b00fc55b"
    "friendlyName":"withFeedback"
    "dateCreated":"2020-10-26T16:02:19.000Z"
    "dateUpdated":"2020-10-26T16:02:19.000Z"
    "inboundRequestUrl":"https://www.dev.aws.4m-a.org/a.html"
    "inboundMethod":"POST"
    "fallbackUrl":"https://www.dev.aws.4m-a.org/files/b.html"
    "fallbackMethod":"POST"
    "statusCallback":NULL
    "stickySender":true
    "mmsConverter":true
    "smartEncoding":true
    "scanMessageContent":"inherit"
    "fallbackToLongCode":true
    "areaCodeGeomatch":true
    "synchronousValidation":false
    "validityPeriod":14400
    "url":"https://messaging.twilio.com/v1/Services/MG7269f007ed8bd9b4c2913a5fbcb38203"
    "links":{5 items
    "broadcasts":"https://messaging.twilio.com/v1/Services/MG7269f007ed8bd9b4c2913a5fbcb38203/Broadcasts"
    "messages":"https://messaging.twilio.com/v1/Services/MG7269f007ed8bd9b4c2913a5fbcb38203/Messages"
    "phone_numbers":"https://messaging.twilio.com/v1/Services/MG7269f007ed8bd9b4c2913a5fbcb38203/PhoneNumbers"
    "alpha_senders":"https://messaging.twilio.com/v1/Services/MG7269f007ed8bd9b4c2913a5fbcb38203/AlphaSenders"
    "short_codes":"https://messaging.twilio.com/v1/Services/MG7269f007ed8bd9b4c2913a5fbcb38203/ShortCodes"
    }
    }
SMSCENTER ;
    S C="curl -s ""http://www.smscenter.co.il/pushsms.asp?"
    S C=C_"UserName=4m"
    S C=C_"&Password=a434d6de00b4dddd4cb683b4cee041b4"
    S C=C_"&EnableChaining=1"
    S C=C_"&Sender=0542071222"
    S C=C_"&ToPhoneNumber="_TEL
    S C=C_"&Message="_M
    S C=C_""""
    ;
    S F="/tmp/sms"_$J_".tmp"
    K ^W(JB,"X1")
    S ^W(JB,"X1",1)="#!/bin/sh"
    S ^W(JB,"X1",2)=C
    D P^%ESF($NA(^W(JB,"X1")),F) H 0.1
    N ANS
    D CG^%ESF("sh "_F)
    K ^ELI12 M ^ELI12=ANS
    I $G(ANS(1))'?1"OK".E S ERR="PROBLEM: "_ANS(1) Q
    S ERR=""
    Q
    ;OK
TWA ;
    D S^%ZU
    S CN="IL"
    D WSA("0523255581","JUST A TEST FROM eli TO WA")
    Q
TSMS ;
    D START^%ZU S JB=$J
    ;D SMS("+972525459792","hi drea")
    ;D SMS("0523255581",^ELI2)
    D SMS("0523255581","JUST A TEST FROM eli")
    ;       +919876229348
    ;       +919876229348
    ;D SMS("+972525459792","JUST A TEST FROM THE HOLY LAND")
    Q
EMAIL(EM,GLO,GLOA,SB,OPT) ; Send email using mutt
    ;EM = email adress sent to
    ;GLO = html content lines
    ;GLOA = @GLO@(1)=/dir/file1.txt_filename.txt
    ;SB=SUBJECT
    ;OPT=OPTIONS , CC=add BCC=add
    N C,X,A S ERR=""
    D OPT2V
    S C="mutt"
    I $D(OPT("FROM")) D
    .N A S A=OPT("FROM")
    .I $D(OPT("FROM.DESC")) S A=OPT("FROM.DESC")_" <"_A_">"
    .S C=C_" -e ""my_hdr From:"_A_"""" ; -e 'my_hdr From:obama@whitehouse.org'
    I $D(OPT("CC"))   S C=C_" -c """_OPT("CC")_""""
    I $D(OPT("BCC"))  S C=C_" -b """_OPT("BCC")_""""
    I $L($G(SB)) S C=C_" -s """_SB_""""
    I $G(GLOA)'=""  S X="" F  S X=$O(@GLOA@(X)) Q:X=""  D
    .S A=@GLOA@(X)
    .S C=C_" -a """_$P(A,D,1)_""""
    S C=C_" "_EM
    S F="/tmp/emm"_$J_".tmp" D P^%ESF(GLO,F) H 1
    S C=C_" <"_F
    S ERR=""
    s ^LAST("M")=C
    D CG^%ESF(C)
    I $D(ANS(1)) S ERR=ANS(1) Q
    D
    .N ERR
    .;D RM^%ESF(F)
    ;W !! ZWR ANS B
    Q
OPT2V ; OPT="A=1/B=4/C=2" -> OPT("A")=1...
    N X,A,B,C,V
    S OPT=$G(OPT)
    F X=1:1:$L(OPT,"/") D
    .S A=$P(OPT,"/",X),B=$P(A,"=",1),C=$P(A,"=",2,999)
    .I B'="" S V(B)=C
    M OPT=V
    Q
TEM ;
    D S^%ZU
    S GLO=$NA(^W(JB,"X1")) K @GLO
    S @GLO@(1)="Hello email"
    S @GLO@(2)="bye"
    D EMAIL("eli@yaweli.com",GLO,"","test email mumps","FROM=men100@gmail.com")
    Q
Version() Q "1.03" ; support twilio sms service