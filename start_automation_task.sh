#!/bin/bash
V_ticket=`cat final_value.txt | awk -F "," '{print $1}' | awk -F ": " '{print $2}'`
for i in ${V_ticket[@]} 
do
  touch ${i}.yaml
  echo "Ticket: $i">>${i}.yaml
  V_host=`cat final_value.txt | grep -w $i | awk -F "," '{print $3}' | awk -F ": '" '{print $2}' | awk -F "'" '{print $1}'`
  echo "hostname: $V_host">>${i}.yaml
  Lun_size=`cat final_value.txt | grep -w $i | awk -F "," '{print $2}' | awk -F ": '" '{ print $2}' | awk -F "GB'" '{print $1}'`
  echo "volume_size: $Lun_size">>${i}.yaml
  Number_of_volume=`cat final_value.txt | grep -w $i | awk -F "," '{print $6}' | awk -F ":'" '{print $2}' | awk -F "'" '{print $1}'` 
  echo "num_of_vols: $Number_of_volume">>${i}.yaml
  Wwn=`cat final_value.txt | grep -w $i | awk -F "wwn':'" '{print $2}' | awk -F "'" '{print $1}'`
  echo "init: [$Wwn]">>${i}.yaml
  echo "hostId: ${V_host}_IG">>${i}.yaml
  echo "maskingViewId: ${V_host}_MV">>${i}.yaml
  echo "storageGroupId: ${V_host}_SG">>${i}.yaml
  echo "remote_storage_group: ${V_host}_SG">>${i}.yaml
  echo "Password: smc">>${i}.yaml
  echo "Username: smc">>${i}.yaml
  echo "unisphere_url: 'https://xx.xx.xx.xx:8443'">>${i}.yaml
  echo "sloId: Diamond">>${i}.yaml
  echo "srpId: SRP_1">>${i}.yaml
  echo "symmetrixId: 000197600361">>${i}.yaml
  echo "remoteSymmId: 000197600362">>${i}.yaml
  echo "portgroup: Unisphere_2_PG">>${i}.yaml
done
for i in ${V_ticket[@]}
do
ansible-playbook new_provisioning.yaml --extra-vars="myvarfile=${i}.yaml"
done
