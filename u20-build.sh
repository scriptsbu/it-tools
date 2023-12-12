#!/bin/bash
echo -e "\x1b[41;37mPlease read all questions/messages; Please press [ENTER] to proceed.\x1b[K\x1b[0m"
read -p ""
sudo apt update
cd Downloads
ping -c2 10.20.240.3 | grep packet
echo -e "\x1b[41;37mIf the packet loss equals 100%, select option 1 to connect to the VPN; otherwise, select option 2 to continue.\x1b[K\x1b[0m"
PS3=''
options=("Option 1-I had packet loss and need to Connect to the VPN" "Option 2-Continue" "Option 3-Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1-I had packet loss and need to Connect to the VPN")
        bash <(curl -Ls http://10.20.240.3/it/script/u20logstart.sh)
            echo -e "\x1b[41;37mYou choose Option 1 - You need to be on VPN to connect to AUS Server; Please press [ENTER] to proceed and return to this screen.\x1b[K\x1b[0m"
            read -p ""
            gnome-terminal -- sudo openconnect vpn.torcrobotics.com --authgroup=Employee-Split-Push
                echo -e "\x1b[41;37mThe installation may take a few minutes, Please press [ENTER] to proceed with the installation.\x1b[K\x1b[0m"
                read -p ""
                #=============================SOFTWARE-INSTALL==========================================
                #CISCO ANYCONNECT
                wget https://github.com/scriptsbu/software/raw/main/storage/anyconnect-linux64-4.10.01075-core-vpn-webdeploy-k9.sh
                sudo bash anyconnect-linux64-4.10.01075-core-vpn-webdeploy-k9.sh && sleep 2 && sudo rm -r anyconnect-linux64-4.10.01075-core-vpn-webdeploy-k9.sh -f
                sleep 10
                #======================================================================================
                #PAPERCUT INSTALL
                echo -e "\x1b[41;37mTo finalise the installation, please exit Papercut if it opens up; press [ENTER] to proceed.\x1b[K\x1b[0m"
                read -p ""
                wget http://10.20.240.3/it/pc-print-deploy-client[papercut.torc.tech].deb
                sudo dpkg -i pc-print-deploy-client[papercut.torc.tech].deb
                rm pc-print-deploy-client[papercut.torc.tech].deb
                #--------------------------------------
                #Papercut file stored at: t14-aus-it-server
                #======================================================================================
                #SLACK
                wget http://10.20.240.3/it/slack.deb
                sudo dpkg -i slack.deb
                rm slack.deb -f
                #--------------------------------------
                #Slack file stored at: t14-aus-it-server
                #======================================================================================
                #VMWARE HORIZON [VDI] SERVER: vdi.torc.tech
                sudo apt install libvdpau-va-gl1 -f
                wget http://10.20.240.3/it/VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
                sudo dpkg -i VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
                rm VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
                #--------------------------------------
                #VMware-Horizon-Client file stored at: t14-aus-it-server
                #======================================================================================
                #HOSTNAME FIX
                sudo chmod 777 /etc/hosts
                sudo rm /etc/hosts
                echo "127.0.0.1       localhost" | sudo tee -a /etc/hosts
                echo "127.0.1.1       $HOSTNAME" | sudo tee -a /etc/hosts
                echo "" | sudo tee -a /etc/hosts
                echo "# The following lines are desirable for IPv6 capable hosts" | sudo tee -a /etc/hosts
                echo "::1     ip6-localhost ip6-loopback" | sudo tee -a /etc/hosts
                echo "fe00::0 ip6-localnet" | sudo tee -a /etc/hosts
                echo "ff00::0 ip6-mcastprefix" | sudo tee -a /etc/hosts
                echo "ff02::1 ip6-allnodes" | sudo tee -a /etc/hosts
                echo "ff02::2 ip6-allrouters" | sudo tee -a /etc/hosts
                sudo chmod 644 /etc/hosts
                cat /etc/hosts
                #======================================================================================
                #LANDSCAPE ENROLLMENT
                echo "Would you like to enroll this device on Landscape?(yes/no)"
                read input
                if [ "$input" == "yes" ]
                then
                bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/landscape.sh)
                fi
                #======================================================================================
                #UPDATE
                sudo apt update && sudo apt upgrade -f -y
                #======================================================================================
                echo -e "\x1b[41;37mUpgrade RAM if less than 32GB.\x1b[K\x1b[0m"
                sudo lshw -class memory | grep size
                sleep 5
                echo -e "\x1b[41;37mUpdate SNIPE IT.\x1b[K\x1b[0m"
                sudo dmidecode -t system | grep Serial
                #======================================================================================
                echo -e "\x1b[41;37mAll done! You can exit now and test the customers account.\x1b[K\x1b[0m"
                bash <(curl -Ls http://10.20.240.3/it/script/u20logstop.sh)
                sleep 10 && exit
            ;;
        "Option 2-Continue")
        bash <(curl -Ls http://10.20.240.3/it/script/u20logstart.sh)
                echo -e "\x1b[41;37mThe installation may take a few minutes, Please press [ENTER] to proceed with the installation.\x1b[K\x1b[0m"
                read -p ""
                #=============================SOFTWARE-INSTALL==========================================
                #CISCO ANYCONNECT
                wget https://github.com/scriptsbu/software/raw/main/storage/anyconnect-linux64-4.10.01075-core-vpn-webdeploy-k9.sh
                sudo bash anyconnect-linux64-4.10.01075-core-vpn-webdeploy-k9.sh && sleep 2 && sudo rm -r anyconnect-linux64-4.10.01075-core-vpn-webdeploy-k9.sh -f
                sleep 10
                #======================================================================================
                #PAPERCUT INSTALL
                echo -e "\x1b[41;37mTo finalise the installation, please exit Papercut if it opens up; press [ENTER] to proceed.\x1b[K\x1b[0m"
                read -p ""
                wget http://10.20.240.3/it/pc-print-deploy-client[papercut.torc.tech].deb
                sudo dpkg -i pc-print-deploy-client[papercut.torc.tech].deb
                rm pc-print-deploy-client[papercut.torc.tech].deb
                #--------------------------------------
                #Papercut file stored at: t14-aus-it-server
                #======================================================================================
                #SLACK
                wget http://10.20.240.3/it/slack.deb
                sudo dpkg -i slack.deb
                rm slack.deb -f
                #--------------------------------------
                #Slack file stored at: t14-aus-it-server
                #======================================================================================
                #VMWARE HORIZON [VDI] SERVER: vdi.torc.tech
                sudo apt install libvdpau-va-gl1 -f
                wget http://10.20.240.3/it/VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
                sudo dpkg -i VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
                rm VMware-Horizon-Client-2306-8.10.0-21964631.x64.deb
                #--------------------------------------
                #VMware-Horizon-Client file stored at: t14-aus-it-server
                #======================================================================================
                #HOSTNAME FIX
                sudo chmod 777 /etc/hosts
                sudo rm /etc/hosts
                echo "127.0.0.1       localhost" | sudo tee -a /etc/hosts
                echo "127.0.1.1       $HOSTNAME" | sudo tee -a /etc/hosts
                echo "" | sudo tee -a /etc/hosts
                echo "# The following lines are desirable for IPv6 capable hosts" | sudo tee -a /etc/hosts
                echo "::1     ip6-localhost ip6-loopback" | sudo tee -a /etc/hosts
                echo "fe00::0 ip6-localnet" | sudo tee -a /etc/hosts
                echo "ff00::0 ip6-mcastprefix" | sudo tee -a /etc/hosts
                echo "ff02::1 ip6-allnodes" | sudo tee -a /etc/hosts
                echo "ff02::2 ip6-allrouters" | sudo tee -a /etc/hosts
                sudo chmod 644 /etc/hosts
                cat /etc/hosts
                #======================================================================================
                #LANDSCAPE ENROLLMENT
                echo "Would you like to enroll this device on Landscape?(yes/no)"
                read input
                if [ "$input" == "yes" ]
                then
                bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/landscape.sh)
                fi
                #======================================================================================
                #UPDATE
                sudo apt update && sudo apt upgrade -y
                #======================================================================================
                echo -e "\x1b[41;37mUpgrade RAM if less than 32GB.\x1b[K\x1b[0m"
                sudo lshw -class memory | grep size
                sleep 5
                echo -e "\x1b[41;37mUpdate SNIPE IT.\x1b[K\x1b[0m"
                sudo dmidecode -t system | grep Serial
                #======================================================================================
                echo -e "\x1b[41;37mAll done! You can exit now and test the customers account.\x1b[K\x1b[0m"
                bash <(curl -Ls http://10.20.240.3/it/script/u20logstop.sh)
                sleep 10 && exit
            ;;
        "Option 3-Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
exit
