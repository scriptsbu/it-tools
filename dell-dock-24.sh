#!/usr/bin/env bash
set -euo pipefail
# ===============================================================
# DisplayLink 5.6.0 installer for Ubuntu 24.04 + Dell Dock support
# Author: Alberto Lopez-Santiago Scripts
# ===============================================================

DRIVER_VER="5.6.0-59.176"
ZIP_URL="https://dl.dell.com/FOLDER08515978M/1/NR-152011-LS-2_DisplayLink_Ubuntu_${DRIVER_VER}_Software.zip"
WORKDIR="$HOME/Downloads/displaylink-driver"
RUNFILE="displaylink-driver-${DRIVER_VER}.run"

echo "==> Preparing DisplayLink installation for Ubuntu 24.04"
sudo apt update

# Install required packages
sudo apt install -y dkms evdi-dkms linux-headers-$(uname -r) \
  unzip wget libdrm-dev libglib2.0-0 libudev1 libusb-1.0-0 \
  libx11-6 libxext6 libxrandr2 libxcb1 libxinerama1 libxi6

# Optional utilities
sudo apt install -y network-manager libappindicator3-1 gnome-shell-extension-appindicator || true

mkdir -p "$WORKDIR"
cd "$WORKDIR"

echo "==> Downloading DisplayLink ${DRIVER_VER}"
wget -O displaylink.zip "$ZIP_URL"

echo "==> Extracting installer..."
unzip -o displaylink.zip
chmod +x "$RUNFILE"

echo "==> Running installer..."
sudo ./"$RUNFILE" || {
  echo "DisplayLink installer exited with errors."
  exit 1
}

echo "==> Cleaning up..."
rm -f displaylink.zip "$RUNFILE"
cd ..
rmdir "$WORKDIR" 2>/dev/null || true

# ---------------------------------------------------------------
# Post-install configuration for Dell Dock (e.g., D6000/UD22)
# ---------------------------------------------------------------

echo "==> Applying Dell Dock post-install setup..."

# Reload udev and modules
sudo modprobe evdi || true
sudo systemctl restart displaylink-driver.service || true

# Fix USB/Ethernet quirks (optional)
echo "blacklist cdc_ncm" | sudo tee /etc/modprobe.d/blacklist-cdc_ncm.conf >/dev/null
echo "blacklist cdc_ether" | sudo tee -a /etc/modprobe.d/blacklist-cdc_ncm.conf >/dev/null

sudo update-initramfs -u

# Enable DisplayLink service at boot
sudo systemctl enable displaylink-driver.service

# Show helpful info
cat <<'EOF'

✅ DisplayLink installation complete!
✅ Required services installed and enabled.
✅ Dell Dock USB/Ethernet and external display support configured.

To verify:
  sudo systemctl status displaylink-driver.service
  lsmod | grep evdi
  xrandr --listproviders

If using Wayland (default on Ubuntu 24.04):
  - Log out and switch to X11 for full DisplayLink display mirroring
    (Gear icon → "Ubuntu on Xorg" on the login screen)
  - Wayland can still use the dock's Ethernet/USB ports fine.

EOF

# Prompt for reboot
read -rp "Do you want to reboot now (Y/N)? " ans
case "${ans}" in
  [Yy]* ) echo "Rebooting..."; sudo reboot ;;
  * ) echo "Remember to reboot to activate DisplayLink and Dell Dock support!" ;;
esac
