#!/bin/bash
cd ~/Downloads
wget http://10.20.240.3/it/displaylink-driver-5.6.0-59.176.run
sudo chmod +x displaylink-driver-5.6.0-59.176.run
sudo apt install dkms
sudo apt install evdi-dkms
sudo ./displaylink-driver-5.6.0-59.176.run
sudo rm displaylink-driver-5.6.0-59.176.run -y
while true;do
 

  read -p "Do you want to reboot now(Y/N)? " QUESTION
  case "${QUESTION}" in
    [Yy] ) 
      echo "Rebooting now..."    
       sudo reboot  
      ;;

    * ) 
      echo "Don't forget to Reboot the system to apply changes!"
      exit
      ;;
  esac
done
#Alberto Lopez-Santiago Scripts
