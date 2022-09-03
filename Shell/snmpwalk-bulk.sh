#!/bin/zsh
#
# Author: Kevin Adams (kadams1463)
#
# Description: This script was for doing snmpwalk across multiple devices. Needed it for doing SNMP security audits.
#
# How to Use:
# 1. Enter the list of IP addresses or hostnames into a plaintext file.
# 2. Replace "snmp-list.txt" with a filename of your choosing.
# 3. You can replace the community string "public" with a different string if you need to and SNMP version as needed.


for ip in $(cat snmp-list.txt) # for each "ip" line in the output from the "snmp-list.txt" file, do this loop
do
        echo "\n-----------------------\n" # output formatting
        echo "$ip\n" # print the IP address from each line
        echo "-----------------------\n" # output formatting
        snmpwalk -c public -v1 $ip system | head -5 # do an snmpwalk of that host of "ip" with "public" community string on SNMP v1 using the OID "system"; read only the first 5 lines of output
done
