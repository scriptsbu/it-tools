#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing DisplayLink driver & dependencies for Dell Dock on NixOS"

# Check we are on NixOS
if ! grep -q "NixOS" /etc/os-release; then
  echo "Error: This script appears to be running on non-NixOS. Aborting."
  exit 1
fi

# Variables
DL_VERSION="5.6.0-59.176"
DL_ZIP="NR-152011-LS-2_DisplayLink_Ubuntu_${DL_VERSION}_Software.zip"
DL_URL="https://dl.dell.com/FOLDER08515978M/1/${DL_ZIP}"
WORKDIR="${HOME}/Downloads/displaylink-install-dell"

mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

echo "Downloading DisplayLink driver ZIP: ${DL_URL}"
wget -O "${DL_ZIP}" "${DL_URL}"

echo "Extracting..."
unzip -o "${DL_ZIP}"

RUNFILE=$(find . -type f -name "displaylink-driver-*.run" | head -n1)
if [ -z "${RUNFILE}" ]; then
  echo "Error: Could not find .run installer inside the ZIP."
  exit 1
fi

echo "Found installer: ${RUNFILE}"
chmod +x "${RUNFILE}"

echo "Now installing via NixOS declarative config. Please open /etc/nixos/configuration.nix and include these lines:"
cat <<'EOF'

# In /etc/nixos/configuration.nix
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    displaylink
  ];

  boot = {
    kernelModules = [ "evdi" ];
    extraModulePackages = [ config.boot.kernelPackages.evdi ];
    # (Optional) If using Dell Dock D6000 or UD22, Ethernet/USB patches:
    # kernelPatches = lib.singleton {
    #   name = "enable-dock-d6000-multicast-fix";
    #   patch = [
    #     ./linux_kernel_cdc_ncm_patches/0001-Hook-into-usbnet_change_mtu-respecting-usbnet-driver.patch
    #     ./linux_kernel_cdc_ncm_patches/0002-Admit-multicast-traffic.patch
    #   ];
    # };
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "displaylink" "modesetting" ];
  };

  systemd.services.displaylink-server = {
    enable = true;
    requires = [ "systemd-udevd.service" ];
    after =    [ "systemd-udevd.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.displaylink}/bin/DisplayLinkManager";
      Type      = "simple";
      User      = "root";
      Group     = "root";
      Restart   = "on-failure";
      RestartSec = 5;
    };
  };
}
EOF

echo
echo "After editing configuration.nix, run: sudo nixos-rebuild switch"
echo
echo "Once rebuilt, you can optionally run the .run installer (if automatic packaging fails) with:"
echo "sudo ./${RUNFILE}"

echo
read -p "Reboot now to activate changes? (Y/N): " ans
case "${ans}" in
  [Yy]* )
    echo "Rebooting..."
    sudo reboot
    ;;
  * )
    echo "Please reboot manually later to apply changes."
    ;;
esac
