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
################################################################################

date

# SOURCE CONFIGURATION
source $HOME/.bashrc

function powerOn {
	tail -25 $POWERLOG > $HOME/powerlog.tmp

	cat $HOME/powerlog.tmp > $POWERLOG

	echo "[$(date)] Power is on." >> $POWERLOG

	rm $HOME/powerlog.tmp
}

function powerRestored {
	echo "[$(date)] Power restored." >> $POWERLOG 

	# allow for modem and other devices to boot and reestabliash themselves
	sleep 480 
	
	# send email that power has been restored with the last lines of log file
	tail -5 $POWERLOG | mailx -s "Power Restored" -t $NOTIFYEMAIL 	

	# create ticket for further investigation

	# ping each server to see if it came back online
}

function searchLog {
	
	grep "Power restored" $POWERLOG
	if [ $? -eq 0 ]; then
	        # allow for modem and other devices to boot and reestabliash themselves
	        sleep 480

		# send email that power has been restored with the last lines of log file
	        tail -5 $POWERLOG | mailx -s "Power Restored" -t $NOTIFYEMAIL

	        # create ticket for further investigation

	        # ping each server to see if it came back online
	fi
} 

# SCRIPT MAIN ##

if [ -z "$1" ]; then
	powerRestored
else
	powerOn
fi
# end if string not empty


date

