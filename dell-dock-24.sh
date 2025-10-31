#!/usr/bin/env bash
set -euo pipefail
# ===============================================================
# DisplayLink installer for Ubuntu 24.04 (Noble Numbat)
# with Dell Dock (D6000, WD19, UD22) support
# Author: Alberto Lopez-Santiago Scripts
# ===============================================================

DRIVER_VER="5.6.0-59.176"
PRIMARY_URL="https://www.displaylink.com/downloads/file?id=1779"
WORKDIR="$HOME/Downloads/displaylink-driver"

echo "==> Preparing DisplayLink ${DRIVER_VER} installation for Ubuntu 24.04"
sudo apt update -y

# ---------------------------------------------------------------
# 1️⃣ Install required dependencies
# ---------------------------------------------------------------
sudo apt install -y \
  dkms evdi-dkms "linux-headers-$(uname -r)" \
  unzip wget libdrm-dev libglib2.0-0 libudev1 libusb-1.0-0 \
  libx11-6 libxext6 libxrandr2 libxcb1 libxinerama1 libxi6 \
  network-manager libappindicator3-1 gnome-shell-extension-appindicator || true

mkdir -p "$WORKDIR"
cd "$WORKDIR" || exit 1

# ---------------------------------------------------------------
# 2️⃣ Download DisplayLink driver (with fallback)
# ---------------------------------------------------------------
echo "==> Downloading DisplayLink ${DRIVER_VER} from DisplayLink.com..."
if ! wget -q --show-progress -O displaylink.zip "$PRIMARY_URL"; then
  echo "⚠️  Primary link failed — attempting to auto-discover the latest version..."
  FALLBACK_URL=$(wget -qO- https://www.displaylink.com/downloads/ubuntu | \
    grep -oE 'https://www\.displaylink\.com/downloads/file\?id=[0-9]+' | head -n1 || true)
  if [ -n "${FALLBACK_URL:-}" ]; then
    echo "==> Found fallback URL: $FALLBACK_URL"
    wget -q --show-progress -O displaylink.zip "$FALLBACK_URL"
  else
    echo "❌ Failed to locate fallback DisplayLink URL. Visit:"
    echo "   https://www.displaylink.com/downloads/ubuntu"
    exit 1
  fi
fi

echo "==> Extracting installer..."
unzip -o displaylink.zip >/dev/null

RUNFILE=$(find . -type f -name "displaylink-driver-*.run" | head -n1 || true)
if [[ -z "${RUNFILE:-}" ]]; then
  echo "❌ Could not locate .run installer inside ZIP."
  exit 1
fi
chmod +x "$RUNFILE"

# ---------------------------------------------------------------
# 3️⃣ Run the official DisplayLink installer
# ---------------------------------------------------------------
echo "==> Running DisplayLink installer..."
if ! sudo "$RUNFILE"; then
  echo "⚠️  DisplayLink installer exited with errors. Check logs in /var/log/displaylink."
  exit 1
fi

# ---------------------------------------------------------------
# 4️⃣ Dell Dock post-install configuration
# ---------------------------------------------------------------
echo "==> Configuring Dell Dock support..."
sudo modprobe evdi || true
sudo systemctl daemon-reexec || true
sudo systemctl daemon-reload || true
sudo systemctl enable displaylink-driver.service
sudo systemctl restart displaylink-driver.service || true

# Blacklist conflicting USB Ethernet modules (improves Dell Dock Ethernet)
{
  echo "blacklist cdc_ncm"
  echo "blacklist cdc_ether"
} | sudo tee /etc/modprobe.d/blacklist-cdc_ncm.conf >/dev/null

sudo update-initramfs -u >/dev/null

# ---------------------------------------------------------------
# 5️⃣ Clean up temporary files
# ---------------------------------------------------------------
echo "==> Cleaning up..."
cd ..
rm -rf "$WORKDIR"

# ---------------------------------------------------------------
# 6️⃣ Final message
# ---------------------------------------------------------------
cat <<'EOF'

✅ DisplayLink 5.6.0 installation complete!
✅ Dell Dock USB, Ethernet, and DisplayLink video outputs configured.

To verify installation:
  sudo systemctl status displaylink-driver.service
  lsmod | grep evdi
  xrandr --listproviders

⚙️ Notes:
- For best results, reboot your system now.
- If using Wayland (default on Ubuntu 24.04):
    → External displays may not appear properly.
    → Log out and choose “Ubuntu on Xorg” before logging in.
- Dell Dock Ethernet/USB ports should work immediately.

EOF

# ---------------------------------------------------------------
# 7️⃣ Prompt for reboot
# ---------------------------------------------------------------
read -rp "Do you want to reboot now (Y/N)? " ans
case "${ans:-}" in
  [Yy]* ) echo "Rebooting..."; sudo reboot ;;
  * ) echo "Please reboot manually later to finalize installation." ;;
esac
