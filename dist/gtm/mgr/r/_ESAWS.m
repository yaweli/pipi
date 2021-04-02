%ESAWS ; MUMPS TO AWS
    Q
S3UP(F,T,BC) ; Copy from local to remote file
    ; F-FROM  T-TO  BC=BUCKET NAME ->  ANS() 
    S ERR="" K ANS 
    D CP(F,"s3://"_BC_T)
    Q
S3DN(F,T,BC) ; download Copy from bucket to loacl
    ;
    S ERR="" K ANS 
    D CP("s3://"_BC_F,T)
    Q
CP(F,T) ;
    S C="aws s3 cp """_F_""" """_T_""""
    D CG^%ESF(C)
    I $D(ANS) S ERR=ANS(1)
    I ERR?1"Completed".E S ERR=""
    Q
