#!/bin/zsh
#
# Author: Kevin Adams (kadams1463)
#
# Date: 9/3/22
#
# Description: This was used on Cumulus Linux-like network devices to save their VLAN config from an SSH session without having to enter the command itself.
#
# How to Use:
# 1. Replace "user" with your username
# 2. Replace "hostname" with the hostname or IP address of the device
# 3. Replace "switch1" with the filename of your choice (i.e. switch1 for Cumulus Linux switch 1)

# SSH to device and read output from "/etc/network/interfaces". Use sed locally to find the start of the file beginning with "#" (using /), and print the current pattern space (p) until the end ($).
# Output the contents to a file on the local machine (switch1 being the filename).
ssh user@hostname sudo cat /etc/network/interfaces | sed -n '/# This file/,$p' >> switch1
