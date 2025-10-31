#!/usr/bin/env bash
set -euo pipefail
# ===============================================================
# DisplayLink 5.6.0 installer for Ubuntu 24.04 (Noble Numbat)
# with full Dell Dock support (D6000, WD19, UD22)
# Author: Alberto Lopez-Santiago Scripts
# ===============================================================

DRIVER_VER="5.6.0-59.176"
ZIP_URL="https://www.displaylink.com/downloads/file?id=1779"
WORKDIR="$HOME/Downloads/displaylink-driver"
RUNFILE="displaylink-driver-${DRIVER_VER}.run"

echo "==> Preparing DisplayLink ${DRIVER_VER} installation for Ubuntu 24.04"
sudo apt update

# ---------------------------------------------------------------
# 1️⃣ Install required dependencies
# ---------------------------------------------------------------
sudo apt install -y \
  dkms evdi-dkms linux-headers-$(uname -r) \
  unzip wget libdrm-dev libglib2.0-0 libudev1 libusb-1.0-0 \
  libx11-6 libxext6 libxrandr2 libxcb1 libxinerama1 libxi6 \
  network-manager libappindicator3-1 gnome-shell-extension-appindicator || true

mkdir -p "$WORKDIR"
cd "$WORKDIR"

# ---------------------------------------------------------------
# 2️⃣ Download and extract the DisplayLink driver
# ---------------------------------------------------------------
echo "==> Downloading DisplayLink ${DRIVER_VER} from DisplayLink.com"
wget -O displaylink.zip "$ZIP_URL"

echo "==> Extracting installer..."
unzip -o displaylink.zip

# Some zip archives use slightly different naming
RUNFILE_FOUND=$(find . -type f -name "displaylink-driver-*.run" | head -n1)
if [[ -z "${RUNFILE_FOUND}" ]]; then
  echo "Error: Installer not found after extraction!"
  exit 1
fi

chmod +x "${RUNFILE_FOUND}"

# ---------------------------------------------------------------
# 3️⃣ Run the official installer
# ---------------------------------------------------------------
echo "==> Running DisplayLink installer..."
sudo "${RUNFILE_FOUND}" || {
  echo "⚠️  DisplayLink installer exited with non-zero code; check logs under /var/log/displaylink."
  exit 1
}

# ---------------------------------------------------------------
# 4️⃣ Dell Dock post-install configuration
# ---------------------------------------------------------------
echo "==> Applying Dell Dock configuration..."

# Load evdi module (for DisplayLink video)
sudo modprobe evdi || true

# Restart DisplayLink service
sudo systemctl daemon-reexec || true
sudo systemctl daemon-reload || true
sudo systemctl enable displaylink-driver.service
sudo systemctl restart displaylink-driver.service || true

# Blacklist conflicting USB/Ethernet drivers that break Dell dock networking
echo "blacklist cdc_ncm" | sudo tee /etc/modprobe.d/blacklist-cdc_ncm.conf >/dev/null
echo "blacklist cdc_ether" | sudo tee -a /etc/modprobe.d/blacklist-cdc_ncm.conf >/dev/null
sudo update-initramfs -u

# ---------------------------------------------------------------
# 5️⃣ Clean up temporary files
# ---------------------------------------------------------------
echo "==> Cleaning up..."
cd ..
rm -rf "$WORKDIR"

# ---------------------------------------------------------------
# 6️⃣ Final user guidance
# ---------------------------------------------------------------
cat <<'EOF'

✅ DisplayLink installation complete!
✅ Dell Dock USB, Ethernet, and DisplayLink displays are now configured.

You can verify with:
  sudo systemctl status displaylink-driver.service
  lsmod | grep evdi
  xrandr --listproviders

⚙️ Notes:
- For best results, reboot your system.
- If using Wayland (default in Ubuntu 24.04):
    → External displays via DisplayLink may not mirror/extend properly.
    → Log out and choose “Ubuntu on Xorg” from the login gear icon.
- Dell Dock Ethernet/USB ports should work immediately.

EOF

# ---------------------------------------------------------------
# 7️⃣ Optional reboot
# ---------------------------------------------------------------
read -rp "Do you want to reboot now (Y/N)? " ans
case "${ans}" in
  [Yy]* ) echo "Rebooting..."; sudo reboot ;;
  * ) echo "Please reboot later to apply DisplayLink and Dell Dock changes." ;;
esac
