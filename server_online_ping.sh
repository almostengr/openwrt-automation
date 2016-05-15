#/bin/bash

################################################################################
# Name: restart_dhcp.sh
# Description: Check to see if local servers are online. If they are not, 
# script will create ticket and send email notification.
# Usage: check_servers.sh matrix.myhouse.lan
# after updating the DHCP file.  
# Written by: Kenny Robinson, Bit Second (bitsecondal@gmail.com)
# Date: 2016-02-05
# Usage: restart_dhcp.sh
# 
# Version History (date - description)
# 2016/02/05 - Initial version.
# 2016-05-15 - Updated the header documentation information.
################################################################################

date

# SCRIPT VARIABLES

# SCRIPT CODE
cd $HOME

# SOURCE CONFIGURATION
source $HOME/.bashrc

## SCRIPT MAIN ##

if [ -z "$1" ]; then
	echo "ERROR: Server name not provided."
	echo ""
	echo "Usage, Internal: check_servers.sh <servername>"
	echo "Usage, External: check_servers.sh internet"
	echo ""
	echo "Exiting..."
else
	# ping the server

        url=$1

        echo "Testing URL $url"

        ping -c 3 $url > /dev/null 2>&1
        if [ $? -ne 0 ]
        then
                echo "Unable to reach server $1. Sending notifications."

                if [ "$1" != "internet" ]; then
                        # Send email notification if the server down is internal.
                        mailx -s "Server $url is down" -t "$NOTIFYEMAIL" < /dev/null
                fi

                # create ticket
                curl --request POST -H "X-API-Key: AA62631B3288632300BB353229744FB3" -d "{\"name\": \"Home Monitor\", \"email\": \"aphmonitor@myhouse.lan\", \"subject\": \"Internet Not Accessable\", \"ip\": \"192.168.1.1\", \"message\": \"Internet connectivity is not available. Please investigate.\", \"priority\": \"3\" }" "http://osticket.myhouse.lan/api/http.php/tickets.json"
                # curl --request POST 'http://localhost/Service' --data "path=/xyz/pqr/test/" --data "fileName=1.doc"
        else
                echo "Server $url is online and responding."
        fi

fi
# end if string not empty


# SCRIPT END
date

