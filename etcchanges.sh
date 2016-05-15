#!/bin/bash

################################################################################
# Name: etcchanges.sh
# Written by: Kenny Robinson, Bit Second Tech (bitsecondal@gmail.com)
# Date: 2016-02-07
# Usage: etcchanges.sh 
# Description: Commit changes made to flies in the /etc directory. The directory
# holds essential configuration files. 
# Pre-requisites: git, git-shell must be installed. This can be done via opkg.
# 
# Version History
# 2016-02-07 - Inital version
# 2016-05-15 - Updated header documentation. 
################################################################################

date 

# Make sure running as root. Otherwise exit
if [ "$USER" == "root" ]; 
then
	
	cd /etc
	
	git status 
	
	# Check to see if changes have been made.
	git status | grep "nothing to commit"
	
	# If changes have been made. They should be committed. Otherwise do nothing
	if [ $? -eq 0 ]; then 
		# IF there is nothing to commit, then do not do anything but report status.
		echo "Nothing to commit."
	else
		# If there is something to commit, then add the files and commit them.
		echo "Changes were found. Committing..."
		
		# Add the made changes
		git add . --all 
		
		# Commit the made changes
		git commit -m "Configuration updated on $(date +'%Y%m%d.%H%M%S')."
		
		echo "Confirming that changes have been commited successfully..."
		
		# Report the status after committing
		git status 
	fi
else
	echo "ERROR: Command must be ran as root."
	echo ""
fi

date
