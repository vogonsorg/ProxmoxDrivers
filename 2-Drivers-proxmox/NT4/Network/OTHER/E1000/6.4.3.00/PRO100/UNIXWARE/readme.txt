This driver is provided for convenience.  It has been tested with
UnixWare* version 7.1.3 and will also run on UnixWare 7.1.0, 7.1.1 and OpenUnix 8.
For OS questions as well as updated drivers, please contact SCO.


Installing the eeE8 Driver for UnixWare 7 
=========================================

To install the eeE8 driver for UnixWare 7:
     
1. Copy the eeE8.pkg file into any directory on the 
   UnixWare system, such as in the /tmp directory.
     
2. Make sure no other users are logged on and all user applications
   are closed.
     
3. If there is an older version of the eeE8 driver on the system, first
   run 'netcfg' and remove any configured NICs. Exit 'netcfg'. Remove
   the old driver by typing 'pkgrm eeE8'. (You can find the driver version
   by typing 'pkginfo -l eeE8'.)
   
4. Install the new driver using 'pkgadd'. For example:
     
        # pkgadd -d /tmp/eeE8.pkg
     
5. Run 'netcfg' to add and configure the NICs. 

6. Reboot the system.
     
NOTE:  If you require Hot Plug PCI capabilities, the DDI 8 eeE8 driver must 
be used.  The DDI 8 driver is supported on UnixWare 7.1.0 and later 
versions.  For more information about Hot Plug PCI capabilities please 
refer to SCO UnixWare 7 documentation.

Note: 802.3 Flow - Control should only be enabled when the adapter is
connected to a peer which fully supports 802.3 flow control.

* Third-party trademarks are the property of their respective owners.
