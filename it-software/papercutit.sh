#!/bin/bash
sudo apt update -y
wget http://10.20.240.3/it/pc-print-deploy-client[papercut.torc.tech].deb
sudo dpkg -i pc-print-deploy-client[papercut.torc.tech].deb
rm pc-print-deploy-client[papercut.torc.tech].deb
/opt/PaperCutPrintDeployClient/initialise.sh -w
sudo apt upgrade -y
#--------------------------------------
#Papercut file stored at: t14-aus-it-server
