#!/bin/bash
sudo apt update
cd ~/Downloads
wget http://10.20.240.3/it/falcon-sensor_7.04.0-15907_amd64.deb
sudo dpkg -i falcon-sensor_7.04.0-15907_amd64.deb
#sudo apt-get upgrade -y
