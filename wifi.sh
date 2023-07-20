#!/bin/bash
dmesg | grep -e wlp -e iwl  >  wifi.txt
scp wifi.txt wifi@WIFI.wifi123?@10.20.240.3:/debug/wifi
#============================================================================
#scp [source file] [username]@[destination server]
#scp cool_stuff.txt sanjeev@example.com:.
scp cool_stuff.txt sanjeev@example.com:/this/path/right/here
#filezilla sftp://wifiWIFI.wifi123?@10.20.240.3/debug/wifi
#MAKE THE FILE UPLOAD TO A PUBLIC SERVER
#LOOK FOR PATTERNS OF WIFI AP CHANGING CONSTANTLY
