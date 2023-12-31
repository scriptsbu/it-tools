#!/bin/bash
cd /home/$USER
rm wifi$USER.txt -f
sudo dmesg | grep -e wlp -e iwl  >  wifi$USER.txt

while true;do
 
   echo -e "\x1b[41;37m Are you connected to TORC VPN?\x1b[K\x1b[0m"
   read -p "Y/N" QUESTION
  case "${QUESTION}" in
  #===========================================================IF YES===================================================================
    [Yy] ) 
ping -c1 10.20.240.3 && 
while true;do
 
   echo -e "\x1b[41;37m Was the ping successful?\x1b[K\x1b[0m"
   read -p "Y/N" QUESTION
  
  
  case "${QUESTION}" in
    [Yy] ) 
      echo -e "\x1b[41;37m Uploading LOG | ask for the password\x1b[K\x1b[0m"
      scp -r wifi$USER.txt wifi@10.20.240.3:/debug/wifi/wifi$USER.txt && 
      echo -e "\x1b[41;37m LOG upload completed.\x1b[K\x1b[0m" && rm wifi$USER.txt | sleep 5 && exit
  
      ;;

    * ) 
      echo -e "\x1b[41;37m Press [ENTER] key to manually send the file.\x1b[K\x1b[0m"
       read -p " " && nautilus /home/$USER
  esac
done
#==========================================================IF NO====================================================================  
      ;;

    * ) 
      echo -e "\x1b[41;37m Please connect to the VPN 'split push'\x1b[K\x1b[0m"
      gnome-terminal -- /opt/cisco/anyconnect/bin/vpnui && xdotool windowminimize $(xdotool getactivewindow) && 
      echo -e "\x1b[41;37m Once connected to the VPN; Press [Enter] key to proceed.\x1b[K\x1b[0m" && 
      read -p " " && 
      ping -c1 10.20.240.3 && 

while true;do
 
   echo -e "\x1b[41;37m Was the ping successful?\x1b[K\x1b[0m"
   read -p "Y/N" QUESTION
  
  
  case "${QUESTION}" in
    [Yy] ) 
      echo -e "\x1b[41;37m Uploading LOG | ask for the password\x1b[K\x1b[0m"
      scp -r wifi$USER.txt wifi@10.20.240.3:/debug/wifi/wifi$USER.txt && 
      echo -e "\x1b[41;37m LOG upload completed.\x1b[K\x1b[0m" && rm wifi$USER.txt | sleep 5 && exit
  
      ;;

    * ) 
     echo -e "\x1b[41;37m Press [ENTER] key to manually send the file.\x1b[K\x1b[0m"
       read -p " " && nautilus /home/$USER
      ;;
  esac
done

      ;;
  esac
done


#============================================================================
#scp [source file] [username]@[destination server]
#scp cool_stuff.txt sanjeev@example.com:.
#scp cool_stuff.txt sanjeev@example.com:/this/path/right/here
#filezilla sftp://CHANGE@10.20.240.3/debug/wifi
#MAKE THE FILE UPLOAD TO A PUBLIC SERVER
#LOOK FOR PATTERNS OF WIFI AP CHANGING CONSTANTLY
#sshpass -f "/path/to/passwordfile" scp -r user@example.com:/some/remote/path /some/local/path
#https://stackoverflow.com/questions/50096/how-to-pass-password-to-scp
