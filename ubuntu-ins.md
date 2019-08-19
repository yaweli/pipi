# install native on ubuntu

- install gtm , latest version 
- install apache with support of cgi
- use group name "gtm" and user which connected to group "gtm" when installing gtm
- install gtm to /gtm , link it to wherever you need
- copy our binary pack to /gtm/bin (you can find the files in https://github.com/yaweli/pipi/tree/master/bin
- add /gtm/bin to system PATH
- make sure the mode and owner of files are correct , group must be "gtm"
- run the "gman" and create the MGR , first time only
- run the "gman" and start the GTM
- run the "gman" and create a new UCI for you
- run "m" to see if the mumps works , see prompt MGR>
- 
