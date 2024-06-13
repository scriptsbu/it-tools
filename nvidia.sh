#!/bin/bash
sudo apt update
#verify GPU installed:
hwinfo --gfxcard --short
#install nvidia driver:
sudo apt-get install libnvidia-extra-535
sudo apt install nvidia-driver-535 nvidia-dkms-535
sudo ubuntu-drivers devices
sudo ubuntu-drivers install
#Verify nvidia driver
nvidia-smi
