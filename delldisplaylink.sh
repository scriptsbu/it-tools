#!/bin/bash
cd ~/Downloads
wget http://10.20.240.3/it/displaylink-driver-5.6.0-59.176.run
sudo chmod +x displaylink-driver-5.6.0-59.176.run
./displaylink-driver-5.6.0-59.176.run
sudo rm displaylink-driver-5.6.0-59.176.run -y
