#! /bin/bash
sudo systemctl start fwupd
sudo systemctl status fwupd
sudo fwupdmgr refresh --force
sudo fwupdmgr update
