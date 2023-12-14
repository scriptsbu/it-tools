#!/bin/bash
#REMOVING OLD FILES
cd ~/Downloads
bash /opt/PaperCutPrintDeployClient/uninitialise.sh -w
sudo apt-get remove papercutprintdeployclient -y -f
sudo apt-get purge papercutprintdeployclient -y -f
sudo rm pc-print-deploy-client[papercut.torc.tech].deb -f
sudo rm -r /opt/PaperCutPrintDeployClient -f
#REMOVING OLD CONFIG
cd /var/lib/dpkg/info/
ls | grep papercut
sudo rm -r papercut-print-deploy-client.conffiles
sudo rm -r papercut-print-deploy-client.list
sudo rm -r papercut-print-deploy-client.md5sums
sudo rm -r papercut-print-deploy-client.postinst
sudo rm -r papercut-print-deploy-client.prerm
#INSTALLING PAPERCUT
cd ~/Downloads
sudo apt update
echo -e "\x1b[41;37mTo finalise the installation, please exit Papercut when it starts; press [ENTER] to proceed.\x1b[K\x1b[0m"
read -p ""
wget http://10.20.240.3/it/pc-print-deploy-client[papercut.torc.tech].deb
sudo dpkg -i pc-print-deploy-client[papercut.torc.tech].deb
rm pc-print-deploy-client[papercut.torc.tech].deb
sudo apt upgrade -y
bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/it-software/paperinit.sh) && sudo dpkg -l | grep papercut
#-------------TROUBLESHOOTING-BACKUP-------------------------
#Papercut file stored at: t14-aus-it-server
#If PaperCut shows an error after installation navigate to:
#nano /var/lib/dpkg/status
#Find the PaperCut Package status and erase the whole block.
#sudo dpkg --configure -a
