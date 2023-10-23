#!/bin/bash
dpkg -l | grep VPN && dpkg -l | grep falcon-sensor && blkid | grep LUKS
