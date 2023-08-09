#!/bin/bash
sudo apt update -y
wget http://10.20.240.3/it/VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
sudo dpkg -i VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
rm VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
sudo apt upgrade -y
#--------------------------------------
#VMware-Horizon-Client file stored at: t14-aus-it-server
