#! /bin/bash
echo "Please connect to the VPN before executing this script."
read -p "Press the ENTER key to proceed or CTRL + C to cancel."
#bash <(curl -Ls http://10.20.240.3/it/script/install_landscape_and_prov2.sh)
cd ~/Downloads
wget http://10.20.240.3/it/script/install_landscape_and_prov2.sh
sudo bash install_landscape_and_prov2.sh
sudo rm -r install_landscape_and_prov2.sh
