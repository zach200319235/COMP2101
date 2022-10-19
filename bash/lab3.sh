#!/bin/bash
#
#This is my script for running creating and running containers using lxd
#
#
#1 - On the hosting VM, install lxd if necessary, do not install lxc-utils
#use the which command to see if we have lxd on the system already
which lxd >/dev/null
if [ $? -ne 0 ]; then
	= need to install lxd
	echo "Installing lxd - you may need to enter your password to install it"
	sudo snap install lxd
	if [ $? -ne 0 ]; then
	#failed to install lxd - exit with error message status 
		echo "failed to install lxd software which is required"
		exit 1
		fi
	#Confirm that lxd is installed and ready 
	else
		echo "lxd software install status: 		- Complete"	
fi
#
#
#2 - On the hosting VM, run lxd init --auto if no lxdbr0 interface exists
#find and confirm interface lxdbr0
ifconfig | grep -q lxdbr0
if [ $? = 0 ]; then 
	echo "interface lxdbr0 status:		- Confirmed"
	#exit 
else
	#if interface does not exist, run init to create it
	lxd init --auto 
	#exit 
	 
fi
#echo "**script STILL working so far"
#
#
#3 - On the hosting VM, launch a container running Ubuntu 20.04 server named COMP2101-S22 if necessary
#create container for ubuntu:22.04 with the name COMP2101-S22
#test if a container with that same name already exists, if yes - warn the user, if no - create the container. 
lxc list | grep -q COMP2101-S22
if [ $? = 0 ]; then 
	echo "container COMP2101-S22 status 		- Confirmed"
else
	lxc launch ubuntu:22.04 COMP2101-S22
	echo "container COMP2101-S22 has been created"
fi
#
#
#4 - On the hosting VM, add or update the entry in /etc/hosts for hostname COMP2101-S22 with the container’s current IP address if necessary
#find and return container ip address. 
containerip=$(lxc list | grep COMP2101-S2 | awk '{print $6}')
echo "Container IP address 			-" $containerip
#
#
#5 - On the hosting VM, install Apache2 in the container if necessary
#add apache2 into the container
lxc exec COMP2101-S22 sudo apt install apache2 -q
if [ $? = 0 ]; then 
	echo "Apache2 is install status		- Complete"
else
	echo "Failed to install apache2"
fi
#check apache1 status, return responce fail or comfirmed
lxc exec COMP2101-S22 sudo service apache2 status -q | grep Active -q #&& exit
if [ $? = 0 ]; then 
	echo "Apache2 is running inside COMP2101-S22	- Confirmed"
else
	echo "Apache2 is not active"
fi
#
#
# 6 - On the hosting VM, retrieve the default web page from the container’s web service with curl http://COMP2101-S22 and notify the user of success or failure
#
curl http://COMP2101-S22 -q 
#test cmd
if [ $? = 0 ]; then 
	#confirm complete
	echo "web page update		- Complete"
else
	#confirm failed
	echo "web page Update 			- Failed"
fi
#
#
#confirm end of script
echo "**end of script"
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
