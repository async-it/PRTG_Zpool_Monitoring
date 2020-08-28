#!/bin/bash

# Async IT Sàrl - 2020
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

if [ -z "`zpool list | head -n 1 | grep CKPOINT`" ]; then
        capacity_percent_used=`zpool list $zfs_pool | tail -n 1 | awk '{print $7}' | cut -d'%' -f1`
		capacity_total=`zpool list $zfs_pool | tail -n 1 | awk '{print $2}' | cut -d'G' -f1 | cut -d'.' -f1`
		capacity_used=`zpool list $zfs_pool | tail -n 1 | awk '{print $3}' | cut -d'G' -f1 | cut -d'.' -f1`
		capacity_free=`zpool list $zfs_pool | tail -n 1 | awk '{print $4}' | cut -d'G' -f1 | cut -d'.' -f1`
else
        capacity_percent_used=`zpool list $zfs_pool | tail -n 1 | awk '{print $8}' | cut -d'%' -f1`
		capacity_total=`zpool list $zfs_pool | tail -n 1 | awk '{print $2}' | cut -d'G' -f1 | cut -d'.' -f1`
		capacity_used=`zpool list $zfs_pool | tail -n 1 | awk '{print $3}' | cut -d'G' -f1 | cut -d'.' -f1`
		capacity_free=`zpool list $zfs_pool | tail -n 1 | awk '{print $4}' | cut -d'G' -f1 | cut -d'.' -f1`
fi

echo "<prtg>"

echo "<result>"
echo "<value>$capacity_percent_used</value>"
echo "<channel>$zfs_pool Used Capacity</channel>"
echo "<unit>Percent</unit>"
echo "</result>"

echo "<result>"
echo "<value>$capacity_total</value>"
echo "<channel>$zfs_pool Total Size</channel>"
echo "<CustomUnit>GigaByte</CustomUnit>"
echo "</result>"

echo "<result>"
echo "<value>$capacity_used</value>"
echo "<channel>$zfs_pool Allocated</channel>"
echo "<CustomUnit>GigaByte</CustomUnit>"
echo "</result>"

echo "<result>"
echo "<value>$capacity_free</value>"
echo "<channel>$zfs_pool Capacity Free</channel>"
echo "<CustomUnit>GigaByte</CustomUnit>"
echo "</result>"

echo "</prtg>"
done
