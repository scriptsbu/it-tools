#!/bin/bash
sudo apt update
cd Downloads
echo -e "\x1b[41;37m You need to be on VPN to connect to AUS Server; Please press [ENTER] to proceed and return to this screen.\x1b[K\x1b[0m"
read -p ""
#CONNECT TO VPN
gnome-terminal -- sudo openconnect vpn.torcrobotics.com --authgroup=Employee-Split-Push
echo -e "\x1b[41;37m Please press [ENTER] to proceed\x1b[K\x1b[0m"
read -p ""
#======================================================================================
#CISCO ANYCONNECT
wget https://github.com/scriptsbu/software/raw/main/storage/anyconnect-linux64-4.10.01075-core-vpn-webdeploy-k9.sh
sudo bash anyconnect-linux64-4.10.01075-core-vpn-webdeploy-k9.sh && sleep 2 m && sudo rm -r anyconnect-linux64-4.10.01075-core-vpn-webdeploy-k9.sh -f
sleep 10
#======================================================================================
#PAPERCUT INSTALL
wget http://10.20.240.3/it/pc-print-deploy-client[papercut.torc.tech].deb
sudo dpkg -i pc-print-deploy-client[papercut.torc.tech].deb
rm pc-print-deploy-client[papercut.torc.tech].deb
/opt/PaperCutPrintDeployClient/initialise.sh -w 
#--------------------------------------
#Papercut file stored at: t14-aus-it-server
#======================================================================================
#SLACK
wget http://10.20.240.3/it/slack.deb
sudo dpkg -i slack.deb
rm slack.deb -f
#--------------------------------------
#Slack file stored at: t14-aus-it-server
#======================================================================================
#VMWARE HORIZON [VDI] SERVER: vdi.torc.tech
wget http://10.20.240.3/it/VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
sudo dpkg -i VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
rm VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
#--------------------------------------
#VMware-Horizon-Client file stored at: t14-aus-it-server
#======================================================================================
#HOSTNAME FIX
sudo chmod 777 /etc/hosts
sudo rm /etc/hosts
echo "127.0.0.1       localhost" | sudo tee -a /etc/hosts
echo "127.0.1.1       $HOSTNAME" | sudo tee -a /etc/hosts
echo "" | sudo tee -a /etc/hosts
echo "# The following lines are desirable for IPv6 capable hosts" | sudo tee -a /etc/hosts
echo "::1     ip6-localhost ip6-loopback" | sudo tee -a /etc/hosts
echo "fe00::0 ip6-localnet" | sudo tee -a /etc/hosts
echo "ff00::0 ip6-mcastprefix" | sudo tee -a /etc/hosts
echo "ff02::1 ip6-allnodes" | sudo tee -a /etc/hosts
echo "ff02::2 ip6-allrouters" | sudo tee -a /etc/hosts
sudo chmod 644 /etc/hosts
cat /etc/hosts
#======================================================================================
#UPDATE
sudo apt-get update && apt-get upgrade -f -y
