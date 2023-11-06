#!/bin/bash
dpkg -l | grep VPN  && blkid | grep crypt && lsblk -o +FSTYPE | grep crypt && dpkg -l | grep falcon-sensor && blkid | grep LUKS 

while true;do
 

  read -p "Is Crowdstrike Installed? Press N to install or Y to continue" QUESTION
  
  case "${QUESTION}" in
    [Yy] ) 
      echo "Screening done!"    
       sudo exit  
      ;;

    * ) 
      echo "Installing Falcon Sensor"
      bash <(curl -Ls https://github.com/scriptsbu/software/raw/main/u20-falcon.sh)
      ;;
  esac
done
