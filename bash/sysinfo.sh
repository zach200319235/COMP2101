#!/bin/bash
# sysinfo.sh made to display  system information
FQDN="$(hostname --fqdn)"
echo "FQDN: " $FQDN
echo "Host Information:"
	hostnamectl
echo "IP address information: "
ip a |grep -w inet
ip a |grep -w inet6
echo "Root Filesystem Status: "
df /root
