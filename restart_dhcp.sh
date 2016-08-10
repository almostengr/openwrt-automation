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
# 2016-08-09 - Added logging function. Changed echo commands to log function.
################################################################################


function log_msg {
	echo $(date)"|"$1
} # end function


log_msg "Script started." 

log_msg "Sending kill command..."

# kill the process
killall dnsmasq

log_msg "-- Sent."

log_msg "Confirming that DNS MASQ process is no longer running."

# Wait to allow for the process to exit completely. 
sleep 5

# Check to see if the process is still running.
DNSRUNCNT=$(ps -w | grep "/usr/sbin/dnsmasq" | wc -l)

if [ ${DNSRUNCNT} -eq 0 ]
then
	log_msg "--Confirmation successful."
	
	log_msg "Restarting..."

	# Start the process back up.
	/etc/init.d/dnsmasq start

	log_msg "Confirming that restart was successful..."
	
	# Delay to allow for process to start
	sleep 3

	# Confirm that the process is running. 
	PROCESSES=$(ps -w | grep dnsmasq | wc -l)

	if [ ${PROCESSES} -eq 2 ] ;
		# Restart was successful if two processes are running.
		log_msg "-- Restart completed."
	elif [ ${PROCESSES} -lt 2 ] ;
		# Restart was not successful if less than two processes are running.
		log_msg "-- ERROR!! DNS MASQ process did not restart. Please check that the configuration changes that were made are valid."
	else
		# Cannot determine if restart was successful if more than two processes are running.
		log_msg "-- ERROR!! Could not determine whether DNS MASQ successfully restarted.  Please run ps -w to make sure that the process has started."
	fi 
fi

log_msg "Script completed."
