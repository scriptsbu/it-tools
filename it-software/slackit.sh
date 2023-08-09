#!/bin/bash
sudo apt update -y
wget http://10.20.240.3/it/slack.deb
sudo dpkg -i slack.deb
rm slack.deb -f
sudo apt upgrade -y
#--------------------------------------
#Slack file stored at: t14-aus-it-server
