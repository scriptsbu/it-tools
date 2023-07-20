#!/bin/bash
dmesg | grep -e wlp -e iwl  >  dmesg.txt


#MAKE THE FILE UPLOAD TO A PUBLIC SERVER
#LOOK FOR PATTERNS OF WIFI AP CHANGING CONSTANTLY
