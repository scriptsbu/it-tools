#!/bin/bash
sudo apt update && apt full upgrade -y
sudo apt install samba -y
sudo testparm
ufw enable
ufw allow 22/tcp
sudo ufw allow samba
sudo mkdir /srv/samba/share
sudo chmod -R 777 /srv/samba/share
sudo service smbd restart
sudo testparm
echo "[global]" | sudo tee -a /etc/samba/smb.conf
echo "workgroup = WORKGROUP" | sudo tee -a /etc/samba/smb.conf
echo "server string = Samba Server %v" | sudo tee -a /etc/samba/smb.conf
echo "netbios name = ubuntu" | sudo tee -a /etc/samba/smb.conf
echo "security = user" | sudo tee -a /etc/samba/smb.conf
echo "map to guest = bad user" | sudo tee -a /etc/samba/smb.conf
echo "name resolve order = bcast host" | sudo tee -a /etc/samba/smb.conf
echo "dns proxy = no" | sudo tee -a /etc/samba/smb.conf
echo "#" | sudo tee -a /etc/samba/smb.conf
echo "# add to the end" | sudo tee -a /etc/samba/smb.conf
echo "[Public]" | sudo tee -a /etc/samba/smb.conf
echo "   comment = Ubuntu File Share" | sudo tee -a /etc/samba/smb.conf
echo "   path = /share" | sudo tee -a /etc/samba/smb.conf
echo "   browsable = yes" | sudo tee -a /etc/samba/smb.conf
echo "   writable = yes" | sudo tee -a /etc/samba/smb.conf
echo "   guest ok = yes" | sudo tee -a /etc/samba/smb.conf
echo "   read only = no" | sudo tee -a /etc/samba/smb.conf
echo "   create mode = 0777" | sudo tee -a /etc/samba/smb.conf
echo "   directory mode 0777" | sudo tee -a /etc/samba/smb.conf
echo "   force user = nobody" | sudo tee -a /etc/samba/smb.conf
sudo testparm
sudo service smbd restart
echo -e "\e[31mSHARE FOLDER LOCATED AT /SHARE\e[0m"
ifconfig -a | grep inet
echo -e "\e[31mCOPY THE SECOND IP\e[0m"
read -p "OPEN AT WINDOWS > RUN > //IP.IP.IP.IP - CLICK ENTER TO CONTINUE"
sudo systemctl status smbd
