#!/bin/bash
sudo apt update
echo -e "\x1b[41;37m You need to be on VPN to connect to AUS Server; Please press [ENTER] to proceed and return to this screen.\x1b[K\x1b[0m"
read -p ""
#CONNECT TO VPN
gnome-terminal -- sudo openconnect vpn.torcrobotics.com --authgroup=Employee-Split-Push
echo -e "\x1b[41;37m Please press [ENTER] to proceed\x1b[K\x1b[0m"
read -p ""
#HOSTNAME FIX
bash <(curl -Ls https://github.com/scriptsbu/scripts/raw/main/host.sh)
#PAPERCUT INSTALL
bash <(curl -Ls https://github.com/scriptsbu/software/raw/main/it/papercutvpn.sh)
#SLACK
bash <(curl -Ls https://github.com/scriptsbu/software/raw/main/it/slackit.sh)
#VMWARE HORIZON [VDI] SERVER: vdi.torc.tech
bash <(curl -Ls https://github.com/scriptsbu/software/raw/main/it/vmwareit.sh)
#CISCO ANYCONNECT
bash <(curl -Ls https://github.com/scriptsbu/software/raw/main/ciscovpn.sh)
sudo apt-get update && apt-get upgrade -f -y
