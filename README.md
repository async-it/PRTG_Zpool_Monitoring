# PRTG Zpool / ZFS Monitoring
PRTG Script to monitor ZPool Capacity in %, total size and used size.
Script handle Gigabyte and TeraByte capacities


![PRTG Probes](https://i.ibb.co/RPSBf0P/Screenshot-2020-09-18-104948.png)

# USE:
# On the device side:
Put script in /var/prtg/scriptsxml/ - if folder does not exist, create it
chmod +x the script to make it executable

# On the Server side:
Add advanced ssh script sensor on the target host
Name sensor and select the script - adjust Scan interval in case of need
Add sensor
Edit channel limits as needed
