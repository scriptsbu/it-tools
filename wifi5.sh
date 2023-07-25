#!/bin/bash
dmesg | grep -e wlp -e iwl  >  wifi$USER.txt -f

while true;do
 

  read -p "Are you connected to TORC VPN?" QUESTION
  
  case "${QUESTION}" in
    [Yy] ) 
      echo "Uploading log"    
       scp -r wifi.txt wifi@10.20.240.3:/debug/wifi/wifi$USER.txt |bar && sleep 5 && echo -e "\x1b[41;37m Log upload complete.\x1b[K\x1b[0m"
  
      ;;

    * ) 
      echo "Please connect to the VPN 'split push'"
      gnome-terminal -- /opt/cisco/anyconnect/bin/vpnui && echo -e "\x1b[41;37m Press [Enter] key to proceed.\x1b[K\x1b[0m" && read -p " " && scp -r wifi.txt wifi@10.20.240.3:/debug/wifi/wifi$USER.txt

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
