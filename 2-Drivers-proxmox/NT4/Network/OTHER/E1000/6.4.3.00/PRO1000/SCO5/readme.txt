The Intel eeG driver has been tested on SCO OpenServer* version 
5.0.7.  It is also supported on versions 5.0.5 and 5.0.6.
For UNIX support or for updated drivers, please contact the 
operating system vendor.


Instructions for Installing the eeG Driver for SCO OpenServer
=============================================================
     
1. Copy the eeG.vol file to any directory, say /tmp, 
   on the SCO system, renaming the file as VOL.000.000. Also, make
   the file read-only by using 'chmod'.

	For example,
		# cp eeG.vol /tmp/VOL.000.000
		# chmod 444 /tmp/VOL.000.000
     
2. If there is an older version of the eeG driver on the system, you 
   must first remove it. To do this, run 'netconfig'. Remove all 
   instances of the "Intel PRO/1000..." adapters. Exit netconfig 
   without opting to relink the kernel. Next, run 'custom' and 
   remove the previous "Intel(R) PRO/1000 Network Drivers" version.
     
3. Install the new driver using 'custom'. When asked for the 
   installation media, choose 'media images', and type the directory 
   path to the VOL.000.000 file. (In step 1, if you copied it to 
   /tmp, type '/tmp'). After the installation of the driver is 
   complete, exit 'custom'.
     
4. Run 'netconfig' and add the adapters. For each adapter that is 
   present in the system, enter the appropriate TCP/IP parameters. 
   By default, the driver automatically detects the line speed and 
   duplex mode. If you want to force any of these settings, choose 
   'Advanced Options' and set the speed and duplex modes. Exit 
   'netconfig' and choose to relink the kernel.
     
5. Reboot the system.


Notes:

This driver supports 82544, 82540, 82545, 82546, 82541, and 82547 MAC based 
devices.  Legacy adapters based on the 82542 and 82543 MAC controllers are NOT
supported by this driver.
If any of these legacy devices, or any other devices are recognized by this 
driver, it is advised NOT to configure them.

* Third-party trademarks are the property of their respective owners.
