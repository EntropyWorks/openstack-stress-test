#!/bin/bash
for AZ in 1 2 3 
do
  for VM in 1 2 3
  do
     nova boot \
       --image precise-12.04.1-20130124 \
       --flavor m1.small \
       --availability-zone dbaas-aw2az${AZ}-v1 \
       --user-data salt-cloud-init.txt \
       --security-groups salt-master \
       --key_name salt salt-az${AZ}-000${VM} | egrep " name | adminPass " | tee -a salt-build-info.txt
  done
done
