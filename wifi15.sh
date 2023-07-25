#!/bin/bash
cd /home/$USER
dmesg | grep -e wlp -e iwl  >  wifi$USER.txt

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
      echo -e "\x1b[41;37m Uploading LOG\x1b[K\x1b[0m"
      scp -r wifi.txt wifi@10.20.240.3:/debug/wifi/wifi$USER.txt && 
      echo -e "\x1b[41;37m LOG upload completed.\x1b[K\x1b[0m" && rm wifi$USER.txt | sleep 5 && exit
  
      ;;

    * ) 
      echo -e "\x1b[41;37m Press [ENTER] key to exit terminal and run the command again.\x1b[K\x1b[0m"
      exit && gnome-terminal -- bash <(curl -Ls https://github.com/scriptsbu/solutions/raw/main/wifi-debug.sh) | xdotool windowminimize $(xdotool getactivewindow)
      ;;
  esac
done
#==========================================================IF NO====================================================================  
      ;;

    * ) 
      echo -e "\x1b[41;37m Please connect to the VPN 'split push'\x1b[K\x1b[0m"
      gnome-terminal -- /opt/cisco/anyconnect/bin/vpnui && 
      echo -e "\x1b[41;37m Once connected to the VPN; Press [Enter] key to proceed.\x1b[K\x1b[0m" && 
      read -p " " && 
      ping -c1 10.20.240.3 && 

while true;do
 
   echo -e "\x1b[41;37m Was the ping successful?\x1b[K\x1b[0m"
   read -p "Y/N" QUESTION
  
  
  case "${QUESTION}" in
    [Yy] ) 
      echo -e "\x1b[41;37m Uploading LOG\x1b[K\x1b[0m"
      scp -r wifi.txt wifi@10.20.240.3:/debug/wifi/wifi$USER.txt && 
      echo -e "\x1b[41;37m LOG upload completed.\x1b[K\x1b[0m" && rm wifi$USER.txt | sleep 5 && exit
  
      ;;

    * ) 
      echo -e "\x1b[41;37m Press [ENTER] key to exit terminal and run the command again.\x1b[K\x1b[0m"
      exit && gnome-terminal -- bash <(curl -Ls https://github.com/scriptsbu/solutions/raw/main/wifi-debug.sh) | xdotool windowminimize $(xdotool getactivewindow)
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
