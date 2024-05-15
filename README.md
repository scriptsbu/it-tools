
INSTALL
=================================================================

SAMBA (Share files WIN<>UBUNTU): bash <(curl -Ls https://github.com/scriptsbu/software/raw/main/share-samba-install.sh)

XRDP (Enable Remote desktop): bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/xrdp.sh)

UBUNTU 20 BUILD: 

Install: SLACK,PAPERCUT,VMWARE Horizon,Cisco VPN; Fix host issue: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/u20-build.sh)

FW Update: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/fwupdate.sh)


INDIVIDUAL SOFTWARE
=================================================================

Landscape (DO NOT USE THROUGH SSH): bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/landscape.sh)

Landscape SSH: bash <(curl -Ls http://10.20.240.3/it/script/install_landscape_and_prov2-ssh.sh)

Cisco AnyConnect: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/it-software/ciscoit.sh)


Slack: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/it-software/slackit.sh)


VMWare Horizon Client: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/it-software/vmwareit.sh)


PaperCut: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/it-software/papercutit.sh)

Crowdstrike: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/falcon.sh)



Citrix: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/it-software/citrix.sh)



Dell display link driver: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/delldisplaylink.sh)


VERIFY
=================================================================

Linux - ABROAD: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/linux-abroad.sh)


macOS - ABROAD: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/mac-abroad.sh)


UNINSTALL:
=================================================================


OPEN CONNECT: bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/openconnectrm.sh)

SAMBA (Share files WIN<>UBUNTU): bash <(curl -Ls https://github.com/scriptsbu/software/raw/main/share-samba-remove.sh)

Cisco Anyconnect: sudo /opt/cisco/anyconnect/bin/vpn_uninstall.sh

UBUNTU 20.04 after AWX install [NOTES]:



DEBUG
=================================================================


bash <(curl -Ls https://github.com/scriptsbu/it-tools/raw/main/wifi-debug.sh)


CHANGE
=================================================================


sudo cryptsetup luksChangeKey /dev/nvme0n1p4

sudo cryptsetup luksChangeKey /dev/nvme0n1p3
