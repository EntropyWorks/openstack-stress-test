#!/bin/bash
START=${1:-1}
END=${2:-10}

COUNT=10
TIME=1
SLEEP=120

for AZ in 1 2 3 ; do
  for VM in $(seq -f "%04g" ${START}  ${END}) ; do
     nova boot \
       --image precise-12.04.1-20130124 \
       --flavor db.xsmall \
       --availability-zone dbaas-aw2az${AZ}-v1 \
       --user-data salt-minion-az${AZ}-cloud-init.txt \
       --security-groups yazz-test \
       --key_name salt minion-az${AZ}-${VM} | egrep " name | adminPass " | tee -a minion-build-info.txt
    sleep 5
    if ((TIME++ / ${COUNT})) ; then
       nova list
       echo "Sleeping for ${SLEEP}"
       sleep ${SLEEP}
       TIME=0
     fi
  done
done
