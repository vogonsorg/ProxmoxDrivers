   Windows NT 4.0

   Introduction:
   -------------
   This document describes the procedure to install  Windows NT v4.0
   driver for Realtek RTL8139 PCI Fast Ethernet adapter.

   Location of Driver:     \WINNT4\RTLNIC4.SYS

   Installing driver procedure on Microsoft Windows NT :
   -----------------------------------------------------
   When you are in Windows NT :
   1. In the Main group of NT, select the "Control Panel" icon.

   2. In the Control Panel window, choose the "Network" icon.

   3. In the Network Settings dialog box, choose the "Add Adapter" button.
      The Add Network Adapter dialog box appears.

   4. In the list of network cards, select "<other> Requires disk from
       manufacturer", and then press <Enter> button.

   5. Insert the driver disk in drive A, enter drive and pathname
      A:\WINNT4  which is the path  where the setup file OEMSETUP.INF is
      located, and then choose the OK button.

   6. The screen will appear "Select Line Speed" dialog box which is provide
      by RTL8139.SYS driver. The default value is "auto" so that the
      RTL8139 PCI Fast Ethernet adapter and its driver RTL8139.SYS will
      auto-detect the line speed, 10 Mb or 100Mb, while the RTL8139.SYS is
      loading. The other values, "10" or "100", are only used when you want
      to forced RTL8139 PCI Fast Ethernet adapter to 10Mb or 100Mb.

   7. The screen will appear "Input EthernetID" dialog box which is provide
      by  RTL8139.SYS  driver.  This option is only required when you have
      more  than  one Realtek  RTL8139  PCI Fast Ethernet adapters on this
      computer. Select "SKIP"  if  only  one  adapter is installed on this
      computer.

   8. "Bus Location"  display in next screen.  Your machine contains more
      than one hardware bus, please select the Bus Type and Bus number on
      which  your network adapter card is installed.

   9. NT will then perform the binding process.  If any additional network
      software options were installed,  you may be  prompted for  specific
      information for these packages.

  10. Restarting your system you will acquire network service.


   NOTES:
   ------
      *  Installing Multiple LAN Adapters:
         Enter Windows NT and follow above setup procedure step 2,in the
         "Network Settings" dialog box, choose the "Configure.." button.
         The "Input Ethernet ID"  dialog box appears and input adapter's
         Ethernet ID. Last step to select OK and close NETWORK SETUP.
         Select SKIP if only one adapter is installed on this computer.


                                                   -- Vincent Cheng --
