#!/bin/bash
dmesg | grep -e wlp -e iwl  >  wifi.txt
scp wifi.txt ftpuser:torc.AUS?@10.20.240.3:/home/ftpuser/file_transfer

#============================================================================
#scp [source file] [username]@[destination server]
#scp cool_stuff.txt sanjeev@example.com:.
scp cool_stuff.txt sanjeev@example.com:/this/path/right/here
#filezilla sftp://ftpuser:torc.AUS?@10.20.240.16/home/ftpuser/file_transfer

#MAKE THE FILE UPLOAD TO A PUBLIC SERVER
#LOOK FOR PATTERNS OF WIFI AP CHANGING CONSTANTLY
