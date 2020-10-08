#!/bin/bash

# Async IT Sàrl - Switzerland - 2020
# Jonas Sauge

# Inspired from the work of Manuel Wolff
# https://github.com/schenklklopfer/PRTG-SSH-scripts/blob/master/ZFSPoolSize.sh

# USE:
# On the device side:
# 	Put script in /var/prtg/scriptsxml/ - if folder does not exist, create it
# 	chmod +x the script to make it executable
# 	Add advanced ssh script sensor
# 	Name sensor and select the script - adjust Scan interval in case of need
# 	Add sensor


# Version:
# Version 1.0 - Initial release
# Version 2.0 - clean code for detection

echo "<prtg>"

for zfs_pool in `zpool list | tail -n +2  | awk '{print $1}'`; do


# ----------------------- Result for Capacity in % ----------------------------------
        capacity_percent_used=`zpool list -H -o capacity $zfs_pool | cut -d'%' -f1`
			echo "<result>"
			echo "<value>$capacity_percent_used</value>"
			echo "<channel>$zfs_pool Used Capacity</channel>"
			echo "<unit>Percent</unit>"
			echo "</result>"

# ----------------------- Result for Size ----------------------------------			
		if [ -z "`zpool list -H -o size $zfs_pool | grep G`" ]; then
		capacity=T
		else
		capacity=G
		fi
			capacity_total=`zpool list -H -o size $zfs_pool | cut -d"$capacity" -f1`
			echo "<result>"
			echo "<value>$capacity_total</value>"
			echo "<float>1</float>"
			echo "<channel>$zfs_pool Total Size</channel>"
			echo "<CustomUnit>$capacity</CustomUnit>"
			echo "</result>"		

# ----------------------- Result for allocated space ----------------------------------		
		
		    if [ -z "`zpool list -H -o allocated $zfs_pool | grep G`" ]; then
		capacity=T
		else
		capacity=G
		fi
			capacity_used=`zpool list -H -o allocated $zfs_pool | cut -d"$capacity" -f1`
			echo "<result>"
			echo "<value>$capacity_used</value>"
			echo "<float>1</float>"
			echo "<channel>$zfs_pool Allocated</channel>"
			echo "<CustomUnit>$capacity</CustomUnit>"
			echo "</result>"		


# ----------------------- Result for Free Space ----------------------------------		

		if [ -z "`zpool list -H -o free $zfs_pool | grep G`" ]; then
		capacity=T
		else
		capacity=G
		fi
			capacity_free=`zpool list -H -o free $zfs_pool | cut -d"$capacity" -f1`
			echo "<result>"
			echo "<value>$capacity_free</value>"
			echo "<float>1</float>"
			echo "<channel>$zfs_pool Capacity Free</channel>"
			echo "<CustomUnit>$capacity</CustomUnit>"
			echo "</result>"		

done

echo "</prtg>"
