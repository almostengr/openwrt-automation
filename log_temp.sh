#!/bin/bash                                                                                           

echo "Running script" 

CPU_TEMP=0
DDR_TEMP=0
WIFI_TEMP=0
CURDATE=$(date +%Y%m%d)
LOGFILE="/tmp/temp"$CURDATE".dat"

echo "Getting the temperatures"

CPU_TEMP=`cut -c1-2 /sys/class/hwmon/hwmon2/temp1_input`
DDR_TEMP=`cut -c1-2 /sys/class/hwmon/hwmon1/temp1_input`
WIFI_TEMP=`cut -c1-2 /sys/class/hwmon/hwmon1/temp2_input`

echo "Done getting the temperatures"

if [ -d LOGFILE ]; then
	echo "Log file for current date was not found."

	echo "Creating log file for current date"

	touch $LOGFILE

	echo "Done creating log file for current date"

	echo "Writing headers to log file"

	echo "date; temperature; component" >> $LOGFILE

	echo "Done writing headers to log file"
fi

echo "Writing data to file"                                                                

# write data to the file                                                                      
echo "$(date); $CPU_TEMP; router cpu" >> $LOGFILE                                             
echo "$(date); $DDR_TEMP; router ddr" >> $LOGFILE                                             
echo "$(date); $WIFI_TEMP; router wifi" >> $LOGFILE                                           

echo "Done writing data to file"                                                           

echo "Done running script"
