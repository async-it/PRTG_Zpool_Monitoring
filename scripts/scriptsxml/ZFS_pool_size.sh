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


for zfs_pool in `zpool list | tail -n 1 | awk '{print $1}'`; do

echo "<prtg>"

# ----------------------- Result for Capacity in % ----------------------------------
        capacity_percent_used=`zpool list -H -o capacity | cut -d'%' -f1`
			echo "<result>"
			echo "<value>$capacity_percent_used</value>"
			echo "<channel>$zfs_pool Used Capacity</channel>"
			echo "<unit>Percent</unit>"
			echo "</result>"

# ----------------------- Result for Size ----------------------------------			
		if [ -z "`zpool list -H -o size $zfs_pool | grep G`" ]; then
			capacity_total=`zpool list -H -o size $zfs_pool | cut -d'T' -f1`
			echo "<result>"
			echo "<value>$capacity_total</value>"
			echo "<float>1</float>"
			echo "<channel>$zfs_pool Total Size</channel>"
			echo "<CustomUnit>TeraByte</CustomUnit>"
			echo "</result>"		
		else
			capacity_total=`zpool list -H -o size $zfs_pool | cut -d'G' -f1`
			echo "<result>"
			echo "<value>$capacity_total</value>"
			echo "<float>1</float>"
			echo "<channel>$zfs_pool Total Size</channel>"
			echo "<CustomUnit>GigaByte</CustomUnit>"
			echo "</result>"
		fi

# ----------------------- Result for allocated space ----------------------------------		
		
				if [ -z "`zpool list -H -o allocated $zfs_pool | grep G`" ]; then
			capacity_used=`zpool list -H -o allocated $zfs_pool | cut -d'T' -f1`
			echo "<result>"
			echo "<value>$capacity_used</value>"
			echo "<float>1</float>"
			echo "<channel>$zfs_pool Allocated</channel>"
			echo "<CustomUnit>TeraByte</CustomUnit>"
			echo "</result>"		
		else
			capacity_used=`zpool list -H -o allocated $zfs_pool | cut -d'G' -f1`
			echo "<result>"
			echo "<value>$capacity_used</value>"
			echo "<float>1</float>"
			echo "<channel>$zfs_pool Allocated</channel>"
			echo "<CustomUnit>GigaByte</CustomUnit>"
			echo "</result>"
		fi

# ----------------------- Result for Free Space ----------------------------------		

		if [ -z "`zpool list -H -o free $zfs_pool | grep G`" ]; then
			capacity_free=`zpool list -H -o free $zfs_pool | cut -d'T' -f1`
			echo "<result>"
			echo "<value>$capacity_free</value>"
			echo "<float>1</float>"
			echo "<channel>$zfs_pool Capacity Free</channel>"
			echo "<CustomUnit>TeraByte</CustomUnit>"
			echo "</result>"		
		else
			capacity_free=`zpool list -H -o free $zfs_pool | cut -d'G' -f1`
			echo "<result>"
			echo "<value>$capacity_free</value>"
			echo "<float>1</float>"
			echo "<channel>$zfs_pool Capacity Free</channel>"
			echo "<CustomUnit>GigaByte</CustomUnit>"
			echo "</result>"
		fi

echo "</prtg>"
done
