#!/bin/bash
#REMOVING OLD FILES
cd ~/Downloads
bash /opt/PaperCutPrintDeployClient/uninitialise.sh
sudo dpkg --purge papercutprintdeployclient -y -f
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
groupadd papercut
cd ~/Downloads
sudo apt update
echo -e "\x1b[41;37mTo finalise the installation, please exit Papercut when it starts; press [ENTER] to proceed.\x1b[K\x1b[0m"
read -p ""
wget http://10.20.240.3/it/pc-print-deploy-client[papercut.torc.tech].deb
sudo dpkg -i pc-print-deploy-client[papercut.torc.tech].deb
rm pc-print-deploy-client[papercut.torc.tech].deb
sudo apt upgrade -y
echo -e "\x1b[41;37mRestarting or logging off your computer will bring up the Papercut client icon in the taskbar.\x1b[K\x1b[0m"
papercutver=$(sudo dpkg -l | grep papercut)
echo -e "The \x1b[41;37mTORC\x1b[K\x1b[0m 20.04 $papercutver has been installed"
#ANYTHING BELOW THIS LINE WILL NOT EXECUTE Except for 30-31-33-34-35
bash /opt/PaperCutPrintDeployClient/initialise.sh -w & 
gnome-terminal -- bash /opt/PaperCutPrintDeployClient/initialise.sh
#REPETING THESE 3 LINES JUST IN CASE 26-27-28 DON'T EXECUTE
echo -e "\x1b[41;37mRestarting or logging off your computer will bring up the Papercut client icon in the taskbar.\x1b[K\x1b[0m"
papercutver=$(sudo dpkg -l | grep papercut)
echo -e "The \x1b[41;37mTORC\x1b[K\x1b[0m 20.04 $papercutver has been installed"
#-------------TROUBLESHOOTING-BACKUP-------------------------
#Papercut file stored at: t14-aus-it-server
#If PaperCut shows an error after installation navigate to:
#nano /var/lib/dpkg/status
#Find the PaperCut Package status and erase the whole block.
#sudo dpkg --configure -a
