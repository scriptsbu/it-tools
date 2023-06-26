sudo apt-get remove samba --purge -y
sudo apt-get autoremove -y
sudo rm -r /etc/samba
sudo apt-get purge samba-common -y
sudo apt-get remove samba-common samba-common-bin -y
sudo apt-get autoremove -y
sudo apt purge samba
sudo apt-get install ubuntu-desktop
