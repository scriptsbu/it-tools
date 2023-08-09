#!/bin/bash
sudo apt update -y
sudo apt install libvdpau-va-gl1 -f
wget http://10.20.240.3/it/VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
sudo dpkg -i VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
rm VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
sudo apt upgrade -y
echo -e "\x1b[41;37mOpen VDI and add server: vdi.torc.tech.\x1b[K\x1b[0m"
sleep 30 && exit
#--------------------------------------
#VMware-Horizon-Client file stored at: t14-aus-it-server
