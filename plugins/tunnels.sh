#!/bin/bash

PROXY_PORT="8880"
REMOTE="8880:127.0.0.1:80"

PROXY[1]="alan.chen@54.64.182.63 -i /home/alan.chen/.ssh/id_rsa"
PROXY[2]="alan.chen@dcs-admin.play168.com.tw -i /home/alan.chen/.ssh/id_rsa"
PROXY[3]="alan.chen@dc-admin.play168.com.tw -i /home/alan.chen/.ssh/id_rsa"
PROXY[4]="alan.chen@54.64.233.32 -i /home/alan.chen/.ssh/id_rsa"
PROXY[5]="alan.chen@dcens-admin.play168.com.tw -i /home/alan.chen/.ssh/id_rsa"
PROXY[6]="alan.chen@dcen-admin.play168.com.tw -i /home/alan.chen/.ssh/id_rsa"
# GamePortal
PROXY[7]="alan.chen@54.65.33.115 -i /home/alan.chen/.ssh/id_rsa"
PROXY[8]="alan.chen@54.65.51.12 -i /home/alan.chen/.ssh/id_rsa"
PROXY[9]="alan.chen@54.65.62.47 -i /home/alan.chen/.ssh/id_rsa"
PROXY[10]="alan.chen@54.65.62.44 -i /home/alan.chen/.ssh/id_rsa"

for h in 1 2 3 4 5 6 7 8 9 10
do
  if [ `ssh ${PROXY[$h]} "netstat -tupln | grep -c $PROXY_PORT" 2>/dev/nell` -eq 0 ]; then

    pid=`ps -ef|grep "${PROXY[$h]}"|grep -v grep|awk '{print$2}'`
    if [ $pid -gt 0 ];then
      kill -9 $pid
      sleep 3
    fi

    sudo -u alan.chen -H ssh -o ServerAliveInterval=60 -o StrictHostKeyChecking=no -NfR $REMOTE ${PROXY[$h]}

  fi
done

exit 1
