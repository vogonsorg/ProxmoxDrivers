This driver is provided for convenience.  It has been tested with
UnixWare* version 7.1.3.  It will also work with UnixWare 7.1.0,
UnixWare 7.1.1, and OpenUnix 8.  For any UNIX support questions
as well as updated drivers, please contact the OS vendor (SCO).


Installing the e1008g Driver for UnixWare 7 
=========================================

To install the e1008g driver for UnixWare 7:
     
1. Copy the e1008g.pkg file into any directory on the 
   UnixWare system, such as in the /tmp directory.
     
2. Make sure no other users are logged on and all user applications
   are closed.
     
3. If there is an older version of the e1008g driver on the system, first
   run 'netcfg' and remove any configured NICs. Exit 'netcfg'. Remove
   the old driver by typing 'pkgrm e1008g'. (You can find the driver version
   by typing 'pkginfo -l e1008g'.)
   
4. Install the new driver using 'pkgadd'. For example:
     
        # pkgadd -d /tmp/e1008g.pkg
     
5. Run 'netcfg' to add and configure the NICs. 

6. Reboot the system.
     
NOTE:  If you require Hot Plug PCI capabilities, the DDI 8 e1008g driver must 
be used.  For more information about Hot Plug PCI capabilities please 
refer to SCO UnixWare 7 documentation.

Note: 802.3 Flow - Control should only be enabled when the adapter is
connected to a peer which fully supports 802.3 flow control.

* Third-party trademarks are the property of their respective owners.
