#/bin/bash

#################
# Name: check_servers.sh
# Author: Kenny Robinson
# Date: 2016/02/06
# Description: Check to see if servers are online and listening on SSH. If the 
# server is not listening, then system will generate ticket and send email 
# notification to those defined in the bashrc configuration.
# Usage: server_on_ssh.sh user@hostname
#
# Version History (date - description)
# 2016/02/06 - Initial version. 
####################

date

# SCRIPT VARIABLES

# SCRIPT CODE
cd $HOME

# SOURCE CONFIGURATION
# source $HOME/.bashrc

## SCRIPT MAIN ##

if [ -z "$1" ]; then
	echo "ERROR: Login name not provided."
	echo ""
	echo "Usage: server_on_ssh.sh <user@hostname>"
	echo ""
	echo "Exiting..."
else
	# ssh to the server

        loginId=$1

        echo "Attempting to connect to $loginId"

        ssh -q $loginId exit
        if [ $? -ne 0 ]
        then
                echo "Unable to connect via SSH as $1. Sending notifications."

                if [ "$1" != "internet" ]; then
                        # Send email notification if the server down is internal.
                        mailx -s "Could not connect to $loginId" -t "$NOTIFYEMAIL" < /dev/null
                fi

                # create ticket
                # curl --request POST 'http://localhost/Service' --data "path=/xyz/pqr/test/" --data "fileName=1.doc"
        else
                echo "Connection test successful for $loginId"
        fi

fi
# end if string not empty


# SCRIPT END
date

