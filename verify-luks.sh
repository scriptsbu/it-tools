#!/bin/bash

# Check dependencies
for cmd in dmidecode blkid lsblk; do
  if ! command -v "$cmd" &> /dev/null; then
    echo "Error: $cmd is required but not installed." >&2
    exit 1
  fi
done

# Get the system serial number
if ! serial_number=$(sudo dmidecode -s system-serial-number 2>/dev/null); then
  echo "Error: Unable to retrieve system serial number." >&2
  exit 1
fi

# Get the hostname
hostname="Hostname: $HOSTNAME"

# Check for encrypted volumes
if ! encrypted_volumes=$(lsblk -o NAME,FSTYPE,PARTUUID | grep -E 'crypt|LUKS'); then
  echo "Error: Unable to check for encrypted volumes." >&2
  exit 1
fi

# Echo the results
echo "$hostname"
echo "System Serial Number: $serial_number"
if [ -n "$encrypted_volumes" ]; then
  echo "Encrypted volumes found:"
  echo "$encrypted_volumes"
else
  echo "No encrypted volumes found."
fi
