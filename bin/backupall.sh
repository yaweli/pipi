#!/bin/bash
# backup my locale station
#############

echo "backup ver 1.01 `date`"
rm -f /tmp/*.mybackup.*gz

mkdir /home/eli/etc 2>/dev/null
cd /home/eli/etc
echo "tar /etc"
tar zcf etc.tar.gz /etc
ps -ef>psef.log
netstat -na >netstat.log
last>last.log
ls -lR /var/log >loglist.log
systemctl>systemctl.log
ls -lR /home/eli >lseli.log

echo "tar grp:"
export name="mybackup.`date +%Y%m%d%H%M%S`.tar.gz"
cd /tmp
tar zcf dev.$name /home/eli/dev
tar zcf prj.$name /home/eli/projects
tar zcf gtm.$name /gtm
tar zcf gtm1.$name /gtm/mgr/r
tar zcf gtm2.$name /gtm/eli/r
tar zcf www.$name /var/www
tar zcf etc.$name /home/eli/etc


export email=yaweli.1011@gmail.com
cd /tmp
for x in dev prj gtm1 gtm2 www etc
do
	echo "Sending email ..."$x
	echo "$x for eli backup" | mutt $email -s Backup-$x-$name -a /tmp/$x.$name   
done
