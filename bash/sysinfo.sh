#!/bin/bash
# sysinfo.sh mark ii made to display  system information

#Title
echo "./sysinfo.sh 

Report for MyVM
==============="

#find the fqdn and  print it.  must be assigned to a variable before it can be printed
FQDN="$(hostname --fqdn)"
echo "FQDN: " $FQDN

#display host operating system
hostnamectl |grep -w Operating

#find and display IP address
IPA="$(hostname --all-ip-addresses | awk '{print $1}')"
echo "IP address:" $IPA

#display available space on root drive
RS="$(df /root -h|grep -m1 /dev | awk '{print $4}')"
echo "Root filesystem Free Space: " $RS

#stylize with ending line
echo "==============="

