#/bin/bash

################################################################################
# Name: power_outage.sh
# Description: Will send notification when device is powered on. Router normally is 
# always online and available. Mostlikely a power outage has occurred and items 
# should be checked accordingly. 
# Written by: Kenny Robinson, Bit Second (bitsecondal@gmail.com)
# Date: 2016-02-07
# Usage: power_outage.sh 
# 
# Version History (date - description)
# 2016-02-05 - Inital version
# 2016-05-15 - Updated the header documentation information. 
# 2016-09-20 - Added logging and updated logic and functionality. 
################################################################################

# Log messages 
function log_msg { 
	$(date)" | "$1
}

# Check to see how long the device has been running
function check_uptime {
	log_msg "Checking the uptime"
	
	UPTIME=$(uptime)
	
	log_msg "Done checking the uptime"
}

# If the uptime is less than one day, then the device recently rebooted
function eval_uptime {
	log_msg "Evaluating the uptime"
	
	cat ${UPTIME} | grep "day"
	
	if [ $? -eq 0 ]; then
		log_msg "Device has not rebooted in last 24 hours"
		RETURNCD=0
	else
		log_msg "Device has rebooted in last 24 hours"
		RETURNCD=1
	fi
	
	log_msg "Done evaluating the uptime"
}

# Main function
function main {
	log_msg "Running script"
	
	check_uptime
	
	eval_uptime
	
	log_msg "Done running script"
	
	return ${RETURNCD}
}

RETURNCD=255
UPTIME=""

main
