#!/bin/bash
diskutil apfs list | grep -E -w 'FileVault:|Volume'
pkgutil --packages | grep cisco
pkgutil --packages | grep falcon
ps aux | grep falcon
