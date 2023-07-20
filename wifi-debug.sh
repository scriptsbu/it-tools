#!/bin/bash
dmesg | grep -e wlp -e iwl  >  wifi.txt
scp wifi.txt ftpuser@10.20.240.3 /home/ftpuser/file_transfer

#============================================================================
#scp [source file] [username]@[destination server]
#scp cool_stuff.txt sanjeev@example.com:.
#filezilla sftp://ftpuser:torc.AUS?@10.20.240.16/home/ftpuser/file_transfer

#MAKE THE FILE UPLOAD TO A PUBLIC SERVER
#LOOK FOR PATTERNS OF WIFI AP CHANGING CONSTANTLY
