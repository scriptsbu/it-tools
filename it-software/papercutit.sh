#!/bin/bash
sudo bash /opt/PaperCutPrintDeployClient/uninitialise.sh -w && sudo apt-get remove papercut-print-deploy-client && sudo rm -r /opt/PaperCutPrintDeployClient -f && sudo dpkg -P papercutprintdeployclient
sudo apt update -y
echo -e "\x1b[41;37mTo finalise the installation, please exit Papercut when it starts; press [ENTER] to proceed.\x1b[K\x1b[0m"
read -p ""
wget http://10.20.240.3/it/pc-print-deploy-client[papercut.torc.tech].deb
sudo dpkg -i pc-print-deploy-client[papercut.torc.tech].deb
sudo dpkg --install --force-overwrite pc-print-deploy-client[papercut.torc.tech].deb
rm pc-print-deploy-client[papercut.torc.tech].deb
/opt/PaperCutPrintDeployClient/initialise.sh -w
sudo apt upgrade -y
sudo dpkg -l | grep papercut
#--------------------------------------
#Papercut file stored at: t14-aus-it-server
#If PaperCut shows an error after installation navigate to:
#nano /var/lib/dpkg/status
#Find the PaperCut Package status and erase the whole block.
#sudo dpkg --configure -a
