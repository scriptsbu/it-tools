#!/bin/bash
#UPDATE
sudo apt-get update
#XRDP INSTALL
sudo apt-get install xrdp
sudo systemctl start xrdp
sudo systemctl enable xrdp
sudo adduser xrdp ssl-cert
#UFW ENABLE
sudo systemctl enable ufw
sudo ufw enable
sudo systemctl start ufw
#sudo ufw allow from any to any port 3389 proto tcp
#sudo ufw allow 3389/tcp
#UFW AUTO-ENABLE
cd /lib/systemd/system/
>ufw.service
echo "[Unit]
 Description=Uncomplicated firewall
 Documentation=man:ufw(8)
 DefaultDependencies=no
 Before=network.target
 After=netfilter-persistent.service

[Service]
 Type=oneshot
 RemainAfterExit=yes
 ExecStart=/lib/ufw/ufw-init start quiet
 ExecStop=/lib/ufw/ufw-init stop

[Install]
 WantedBy=multi-user.target" | sudo tee -a /lib/systemd/system/ufw.service
#XRDP Black Screen Fix
cd /etc/xrdp/
>startwm.sh
echo "#!/bin/sh
# xrdp X session start script (c) 2015, 2017 mirabilos
# published under The MirOS Licence

if test -r /etc/profile; then
        . /etc/profile
fi

if test -r /etc/default/locale; then
        . /etc/default/locale
        test -z "${LANG+x}" || export LANG
        test -z "${LANGUAGE+x}" || export LANGUAGE
        test -z "${LC_ADDRESS+x}" || export LC_ADDRESS
        test -z "${LC_ALL+x}" || export LC_ALL
        test -z "${LC_COLLATE+x}" || export LC_COLLATE
        test -z "${LC_CTYPE+x}" || export LC_CTYPE
        test -z "${LC_IDENTIFICATION+x}" || export LC_IDENTIFICATION
        test -z "${LC_MEASUREMENT+x}" || export LC_MEASUREMENT
        test -z "${LC_MESSAGES+x}" || export LC_MESSAGES
        test -z "${LC_MONETARY+x}" || export LC_MONETARY
        test -z "${LC_NAME+x}" || export LC_NAME
        test -z "${LC_NUMERIC+x}" || export LC_NUMERIC
        test -z "${LC_PAPER+x}" || export LC_PAPER
        test -z "${LC_TELEPHONE+x}" || export LC_TELEPHONE
        test -z "${LC_TIME+x}" || export LC_TIME
        test -z "${LOCPATH+x}" || export LOCPATH
fi
unset DBUS_SESSION_BUS_ADDRESS
unset XDG_RUNTIME_DIR
if test -r /etc/profile; then
        . /etc/profile
fi

test -x /etc/X11/Xsession && exec /etc/X11/Xsession
exec /bin/sh /etc/X11/Xsession" | sudo tee -a /etc/xrdp/startwm.sh
sudo systemctl restart xrdp
sudo apt-get update
sudo apt-get upgrade -y
while true;do
 

  read -p "Do you want to reboot now(Y/N)? " QUESTION
  
  case "${QUESTION}" in
    [Yy] ) 
      echo "Rebooting now..."    
       sudo reboot  
      ;;

    * ) 
      echo "Don't forget to Reboot the system to apply changes!"
      exit
      ;;
  esac
done
