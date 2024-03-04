#!/bin/bash
dpkg -l | grep VPN && dpkg -l | grep falcon-sensor && dpkg -l | grep globalprotect  && blkid | grep crypt && lsblk -o +FSTYPE | grep crypt && blkid | grep LUKS 
read -p "Screening Done!" 
#while true;do
 

#  read -p "Is Crowdstrike Installed? Press N to install or Y to continue" QUESTION
  
#  case "${QUESTION}" in
#    [Yy] ) 
#      echo "Screening done!"    
#       sudo exit  
#      ;;

#    * ) 
#      echo "Installing Falcon Sensor"
#      bash <(curl -Ls https://github.com/scriptsbu/software/raw/main/u20-falcon.sh)
#      ;;
#  esac
#done
