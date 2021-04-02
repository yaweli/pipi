%ESIMG ; Image manipulation
    Q
I2B64(IM,SIZE) ; Convert local image file to base 64 format string -> ANS()
    ; 
    ; Usage:
    ; D I2B64("/form/media/file1.jpg",400) ;
    ; size = THE PIXEL TO REDUCE THE FILE TO
    ; Output: 
    ;  ANS()
    ; command
    ; convert input.jpg -resize 400x400 JPG:- | base64
    K ANS S ERR=""
    I '$G(SIZE) S SIZE=80
    I SIZE<10,SIZE>3000 S ERR="WRONG SIZE" Q
    ;
    S C="convert "_IM_" -resize "_SIZE_" JPG:- | base64"
    D CG^%ESF(C) I ERR'="" Q
    ;
    ; TEST
    ;MGR>D START^%ZU
    ;MGR>d I2B64^%ESIMG("/form/media/src22/ar.png",70)
    ;MGR>ZWR ANS
    ;ANS(1)="/9j/4AAQSkZJRgABAQEASABIAAD/2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkI"
    ;ANS(2)="CQkKDA8MCgsOCwkJDRENDg8QEBEQCgwSExIQEw8QEBD/2wBDAQMDAwQDBAgEBAgQCwkLEBAQEBAQ"
    ;ANS(3)="EBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBD/wAARCAAsAEYDASIA"
    ;ANS(4)="AhEBAxEB/8QAGAABAQEBAQAAAAAAAAAAAAAAAAYHCAT/xAAwEAAABAMFCAAGAwAAAAAAAAAAAQIF"
    ;ANS(5)="AwcRBBdWk+EGEhghUVKU4ggTIiQxQTJhkv/EABkBAQACAwAAAAAAAAAAAAAAAAAGBwEDBf/EACMR"
    ;ANS(6)="AAECBgIDAQEAAAAAAAAAAAEAAgMEBRRSkRVTBhEhMVH/2gAMAwEAAhEDEQA/ANYAVF1sx8EO+RqF"
    ;ANS(7)="1sx8EO+RqLWu5fNuwqxtY+B0VLgKi62Y+CHfI1C62Y+CHfI1C7l827CxbR8DoqXAVF10xsEu+RqF"
    ;ANS(8)="1sx8EO+RqF3L5t2Fm1j4HRUuAqLrZj4Id8jULrZj4Id8jULuXzbsJax8DoqXAVF1sx8EO+RqAXcv"
    ;ANS(9)="m3YS1j4HRXaVC6BQugyriUlz2u/h+wcSkue138P2Fc8VO9TtKf8AJyfYNrVaF0EvMl8tez2ylpcL"
    ;ANS(10)="ClXzf4kaS5kVDM6f3yoJLiUlz2u/h+w8jrP+VrzYIrdboLuuFFKh/Z8yP9GX1DTHpFQiQnNhwyCR"
    ;ANS(11)="8PpbYNVkWRGufEBAP9WM7JzP2zh7QNtvjW9MSG4xUpKGhNNzeSay3Vbx75ERUVUi5jr9vjna7DZ7"
    ;ANS(12)="UpG6caEiIZdDMiMcxsrrIdmejeoUF0OIpRqMktpJM6nUyrvcq/un5Gmp+JGW6EkhCHYkpKhEVi/B"
    ;ANS(13)="f6Ed8X8Xr9MgvZUSYhJ9j5+BdateQUice0yrg0Affq1ahdAoXQZVxKS57Xfw/YOJSXPa7+H7CUcV"
    ;ANS(14)="O9TtLicnJ9g2tVoXQBlXEpLntd/D9gDip3qdpOTk+wbXLQAAs1VygAAIgAAIgAAIgAAIv//Z"
    ;MGR>
    Q
EXIF(IM,VEC) ; Retunrn jpg internal data EXIF layer
    ;
    N X,LAB,TXT,ANS,X,A
    K VEC
    D CG^%ESF("identify -format '%[EXIF:*]' "_IM)
    F X=1:1 Q:'$D(ANS(X))  D
    .S A=ANS(X)
    .S LAB=$P(A,"=",1)
    .S TXT=$P(A,"=",2,999)
    .I LAB="" Q
    .S VEC(LAB)=TXT
    Q