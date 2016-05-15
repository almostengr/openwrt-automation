#!/bin/bash 

## CHANGE HISTORY ##
# 20160104 - created script with the updating of packages and rebooting.
# 20160104 - Added logging with debugging of each command.
# 20160129 - Removed logging from script. Fixed dates from previous entries as they 
#            were not correct.
## END CHANGE HISTORY ##

# (

set -x

CURDATE= `date +%Y%m%d%H%M%S`

opkg update 

opkg upgrade 

reboot

set +x

# ) > $HOME/log/update_os_$CURDATE.log 2>&1

