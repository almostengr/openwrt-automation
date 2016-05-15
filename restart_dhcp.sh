#!/bin/bash

################################################################################
# Name: restart_dhcp.sh
# Description: Restart the DHCP process. This script should be ran everytime 
# after updating the DHCP file.  
# Written by: Kenny Robinson, Bit Second (bitsecondal@gmail.com)
# Date: 2016-01-04
# Usage: restart_dhcp.sh
# 
# Version History (date - description)
# 2016-01-04 - Inital version
# 2016-01-26 - Removed logging from script
# 2016-02-05 - Updated script to remove logging and date at beginning and end.
# 2016-05-15 - Updated the header documentation information. Added additional 
# logging information utilizing logic to display the appropriate status 
# messages.
################################################################################

date 

echo "Sending kill command..."

# kill the process
killall dnsmasq

echo "-- Sent."

echo "Confirming that DNS MASQ process is no longer running."

# Wait to allow for the process to exit completely. 
sleep 5

# Check to see if the process is still running.
DNSRUNCNT=$(ps -w | grep "/usr/sbin/dnsmasq" | wc -l)

if [ ${DNSRUNCNT} -eq 0 ]
then
	echo "--Confirmation successful."
	
	echo "Restarting..."

	# Start the process back up.
	/etc/init.d/dnsmasq start

	echo "Confirming that restart was successful..."
	
	# Delay to allow for process to start
	sleep 2

	# Confirm that the process is running. 
	PROCESSES=$(ps -w | grep dnsmasq | wc -l)

	if [ ${PROCESSES} -eq 2 ] ;
		# Restart was successful if two processes are running.
		echo "-- Restart completed."
	elif [ ${PROCESSES} -lt 2 ] ;
		# Restart was not successful if less than two processes are running.
		echo "-- ERROR!! DNS MASQ process did not restart. Please check that the configuration changes that were made are valid."
	else
		# Cannot determine if restart was successful if more than two processes are running.
		echo "-- ERROR!! Could not determine whether DNS MASQ successfully restarted.  Please run ps -w to make sure that the process has started."
	fi 
fi

date 
