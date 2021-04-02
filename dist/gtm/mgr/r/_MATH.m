%MATH ;
    Q
%PI() Quit 3.14159265358979
 Q
ATAN2(Y,X) ;
 Q $$ATAN(Y/X)
 Q
  N C1,AY,C2,R,A
  S C1=$$%PI^%MATH/4
  S C2=3*C1
  S AY=$TR(Y,"-")+1E-10
  I X'<0 D
  .S R=(X-AY)/(X+AY)
  .S A=C1-(C1*R)
  E
  .S R=(X+AY)/(AY-X)
  .S A=C2-(C1*R)
  I Y<0 Q -A
  Q A
SIN(X) ;
 N Y,SIGN,I,K
 S Y=0
 S SIGN="-"
 F I=1:2:30 D
 .I SIGN="+" S SIGN="-"
 .E  S SIGN="+"
 .S K=X**I/$$EX(I)
 .X "S Y=Y"_SIGN_"K"
 Q Y
COS(X) ;
 N Y,SIGN,I,K
 S Y=0
 S SIGN="-"
 F I=0:2:30 D
 .I SIGN="+" S SIGN="-"
 .E  S SIGN="+"
 .S K=X**I/$$EX(I)
 .X "S Y=Y"_SIGN_"K"
 Q Y
ATAN(X) ; 
 N Y,SIGN,I,K
 S Y=0
 S SIGN="-"
 F I=1:2:30 D
 .I SIGN="+" S SIGN="-"
 .E  S SIGN="+"
 .S K=X**I/I
 .X "S Y=Y"_SIGN_"K"
 Q Y
 Q
TAN(X) ;
 Q X+((X**3)/3)+(2/15*(X**5))+(17/315*(X**7))+(62/2835*(X**9))
EX(I) ; !I
 N Y,X
 S Y=1
 F X=1:1:I S Y=Y*X
 Q Y