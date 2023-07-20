#!/bin/bash
dmesg | grep -e wlp -e iwl  >  dmesg.txt
