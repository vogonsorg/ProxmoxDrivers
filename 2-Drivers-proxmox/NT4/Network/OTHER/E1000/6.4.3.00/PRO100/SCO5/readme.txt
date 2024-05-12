The Intel eeE driver has been tested on SCO OpenServer* version
5.0.7.  It is also supported on versions 5.0.5 and 5.0.6.
For UNIX support or for updated drivers, please contact the
operating system vendor.


Instructions for Installing the eeE Driver for SCO OpenServer
=============================================================
     
1. Copy the eee.vol file to any directory, say /tmp, 
   on the SCO system, renaming the file as VOL.000.000. Also, make
   the file read-only by using 'chmod'.

	For example,
		# cp eee.vol /tmp/VOL.000.000
		# chmod 444 /tmp/VOL.000.000
     
2. If there is an older version of the eeE driver on the system, you 
   must first remove it. To do this, run 'netconfig'. Remove all 
   instances of the "Intel ..." adapters. Exit netconfig 
   without opting to relink the kernel. 
     
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
=======

- Some Intel gigabit ethernet devices may be recogized by this 
  driver due to similar device IDs.  The eeG driver for SCO 5
  provided by Intel should be used for these devices as eeE does
  not support gigabit devices.  It is important to make sure the 
  device selected in netconfig has the slot number corresponding 
  to the device intended for installation. 


* Third-party trademarks are the property of their respective owners.
