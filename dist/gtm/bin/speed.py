
import subprocess

import sys
# os.system("/home/eli/dev/speedtest-cli>/tmp/speed.txt")


x=subprocess.Popen("/home/eli/dev/speedtest-cli --simple|grep Down",shell=True,stdout=subprocess.PIPE).stdout.read()

y=x.decode().split(':')
z=y[1].split(' ')[1]
if float(z)<50:
    print("Speed too slow")
elif float(z)<10:
    print("Connectin very slow")
else:
    print("GoodSpeed "+z)
    
