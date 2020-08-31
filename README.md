# PRTG_Zpool_Monitoring
PRTG Scripts to monitor ZPool Capacity in %, total size and used size.
Script handle Gigabyte and TeraByte capacities

# USE:
On the device side:
Put script in /var/prtg/scriptsxml/ - if folder does not exist, create it
chmod +x the script to make it executable
#On the Server side:
Add advanced ssh script sensor on the target host
Name sensor and select the script - adjust Scan interval in case of need
Add sensor
Edit channel limits as needed
