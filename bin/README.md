## binary
reside in /gtm/bin with the management scripts
- gman
- gstart
- gstop 
etc..


good practice is to add /gtm/bin to the linux $PATH
```HTML
[gtm@dev bin]$ ls -al
total 192
drwxrwxr-x.  2 gtm  gtm   4096 Mar 26 00:02 .
drwxrwxr-x. 11 gtm  gtm   8192 Mar 11 10:14 ..
-rwxr-xr-x   1 eli  www   1288 Feb 19 17:31 4m
-rwxrwxr-x.  1 gtm  gtm    752 Aug  4  2019 backupall.sh
-rwxr-xr-x   1 root root    88 Sep 15  2019 cloud9run
-rwxrwxr-x.  1 gtm  gtm   1589 Aug  4  2019 dman
-rwxrwxr-x.  1 gtm  gtm    181 Aug  4  2019 es
-rwxrwxr-x.  1 gtm  gtm    206 Aug  4  2019 EsGtm
-rwxrwxr-x.  1 gtm  gtm  26093 Aug  4  2019 g
-rwxr-x---   1 eli  www   8713 Jan  8 09:45 gman
-rwxrwxr-x.  1 gtm  gtm   2451 Aug  4  2019 gman1
-rwxrwxr-x.  1 root gtm    441 Aug  4  2019 gstart
-rwxrwxr-x.  1 gtm  gtm    250 Aug  4  2019 gstartup
-rwxrwxr-x.  1 root gtm    621 Aug  4  2019 gstop
-rwxrwxr-x.  1 gtm  gtm    289 Aug  4  2019 gtm-is-down
-rwx------.  1 gtm  gtm    197 Aug  4  2019 gtm.service
-rwxr-xr-x   1 eli  www    458 Sep 18  2019 gtmUtil
-rwxrwxr-x.  1 gtm  gtm    151 Aug  4  2019 install
lrwxrwxrwx   1 root root    13 Mar 26 00:02 m -> /gtm/bin/m.sh
lrwxrwxrwx.  1 gtm  gtm      1 Feb 20  2019 M -> m
-rwxrwxr-x.  1 gtm  gtm    119 Aug  4  2019 mgr_dist
lrwxrwxrwx   1 gtm  gtm     33 Dec 11 19:34 modelRun.py -> /home/gtm/proj/python/modelRun.py
lrwxrwxrwx   1 root root    16 Mar 26 00:02 mrun -> /gtm/bin/mrun.sh
-rwxrwxr-x.  1 gtm  gtm    289 Aug  4  2019 mrun.sh
-rwxrwxr-x.  1 gtm  gtm     57 Aug  4  2019 m.sh
lrwxrwxrwx.  1 gtm  gtm     10 Apr  9  2019 mumps -> /gtm/mumps
-rwxrwxr-x.  1 gtm  gtm    596 Aug  4  2019 regtm
-rwxrwxr-x.  1 gtm  gtm    295 Aug  4  2019 reload
-rwxr-x---   1 root root   292 Sep 14  2019 reloadmes
-rwxrwxr-x.  1 gtm  gtm    658 Aug  4  2019 send4
-rwxr-xr-x.  1 eli  www  49162 Aug 28  2019 xlsx2csv.py
[gtm@dev bin]$ 
```
