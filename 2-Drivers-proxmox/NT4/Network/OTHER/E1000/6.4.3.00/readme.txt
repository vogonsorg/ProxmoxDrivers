Intel(R) Network Adapter Software Version 9.0 Release Notes
===========================================================

July 6, 2004

This release includes software and drivers for Intel® PRO/100 
and PRO/1000 adapters and integrated network connections.

Contents
========

- What's New in This Release
- User Guides
- Platform Types Supported
- Intel fiber-Based Adapters
- Intel® PRO/1000 MT Quad Port Server Adapter
- Service Pack 4 Required for Windows* 2000
- Changing Offload Settings for an Adapter in an ANS Team
- Updating Drivers and Utilities on Systems using IPSec
- Upgrading Drivers and Utilities from Previous Versions
- Team Setup Requirement
- IEEE 802.3ad Teaming with Foundry* Switches
- Locally Administered Address (LAA) in Windows* 98SE
- Windows 98 SE Driver Installation Issues
- Controller Information not available in Windows 98 and Windows NT
- Known Limitations
- Customer Support


What's New in This Release
==========================

- Support for the Intel PRO/1000 ** Dual Port Server Connection
- Support for the Intel PRO/1000 GT Desktop Adapter


User Guides
===========

Several user guides for Intel PCI and PCI-X adapters are available for 
this product.  You may access them in the following ways: 
- On Windows-based systems, start the autorun program on the Intel CD, 
  then click "View User Guides".
- Double-click "index.htm" located in the root of the Intel CD.
- Go to http://support.intel.com. 

User's Guides for Intel PCI and PCI-X adapters are available by running 
the Autorun program (only applicable for Windows operating systems), 
located at the root of the CD or webpack and selecting "View User 
Guides". 

You can also locate the guides by viewing the index.htm file located
in the root of the CD or download directory.


Platform Types Supported
========================

Intel provides network drivers for the following environments:
  - Intel® Pentium®-based computers (IA-32 architecture)
  - Intel® Itanium®-based computers

Drivers and feature support for each operating system varies under each 
platform type.  See the online user guides for complete information. 


Intel Fiber-Based Adapters
==========================

Caution: The fiber optic ports may utilize Class 1 or Class 1M laser 
devices. Do not stare into the end of a fiber optic connector 
connected to a "live" system.  Do not use optical instruments to 
view the laser output. Using optical instruments increases eye hazard.  
Laser radiation is hazardous and may cause eye injury.  To inspect a 
connector, receptacle or adapter end, be sure that the fiber optic 
device or system is turned off, or the fiber cable is disconnected 
from the "live" system. 

The Intel PRO/1000 adapters with fiber optic connections operate only 
at their native speed and only at full-duplex.  Therefore you do not
need to make any adjustments.  Use of controls or adjustments or 
performance of procedures other than those specified herein may result 
in hazardous radiation exposure.  The laser module contains no 
serviceable parts.  


Intel PRO/1000 MT Quad Port Server Adapter
==========================================

This adapter operates in 3.3 volt slots only. For best performance, 
this adapter should be installed in a 64-bit PCI-X slot. Refer to the 
detailed installation instructions in the User's Guide for additional 
requirements.

Wake-on-LAN and Hot Plug operations are not supported by this adapter.

This adapter supports Intel Boot Agent functionality on ports A and B, 
however it is disabled by default. To enable and use the Intel Boot 
Agent, refer to the User's Guide and other information in the 
\APPS\BOOTAGNT directory.

  Known Issues
  ------------

  Multiple Intel PRO/1000 MT Adapters in one system
  -------------------------------------------------
  Installing more than two Intel PRO/1000 MT Quad Port Server Adapters in 
  the same system is not recommended. Many systems are unable to support 
  the power requirements for more than two of these adapters. 

  Wake on LAN (WOL)* not supported
  --------------------------------
  The Intel PRO/1000 MT Quad Port Server Adapter does not support WOL. 
  If you try to enable this feature with IBAUTIL.EXE, this action does 
  not have any effect. 

  Not recommended for use on some systems
  ---------------------------------------
  The Intel PRO/1000 MT Quad Port Server Adapter does not function 
  correctly while running on the following systems:
 
  Dell* PowerEdge* 2500
  Dell PowerEdge 6400
  Dell PowerEdge 6450
  Dell PowerEdge 6650SC
  Intel Saber, Saber-R, and Saber-Rx Systems
  SuperMicro* 370DE6
  SuperMicro P4DP6
 
  Using this adapter in these configurations is not recommended.

  Heavy traffic may cause system reboot in some systems
  -----------------------------------------------------
  Using an Intel PRO/1000 MT Quad Port Server Adapter may cause a reboot 
  in systems with the Intel Profusion chipset including: Intel OCPRF100 
  and SRPM8 server systems; Compaq* ProLiant* 8000, 8500, ML750, DL760; 
  Dell PowerEdge 8450, 6300, 6350; IBM* x370.  Using this adapter in 
  these configurations is not recommended.

  Use only in a PCI-X Slot
  ------------------------
  Reduced performance has been observed when the Intel PRO/1000 MT Quad 
  Port Server Adapter is installed in a slot other than a PCI-X slot.

  Shared Interrupt Limitation 
  ---------------------------
  In some systems, the BIOS and OS assign the same interrupt number to 
  two or more different ports on the Intel PRO/1000 MT Quad Port Server 
  Adapter. If this occurs, these ports do not function properly. To 
  address this issue, reassign the system resources so that each port 
  of the adapter has its own unique interrupt number or disable one of 
  the ports sharing the same interrupt number. 

  Downshifting
  ------------
  When connecting to any Gigabit switch via a faulty CAT 5 cable where 
  one pair is broken, the adapter does not downshift from 1 Gig to 
  100Mbps. For the adapter to downshift, it must identify two broken 
  pairs in the cable.
  
  Installing the Base Driver on systems running Windows XP 
  or Windows Server 2003
  --------------------------------------------------------
  After inserting the adapter in the system, you must install the base
  driver. This is true even if you previously installed base drivers
  for other Intel Ethernet adapters.


Service Pack 4 Required for Windows 2000
========================================

Intel network drivers and software in Windows 2000 require Service Pack 
4 to function correctly.


Changing Offload Settings for an Adapter in an ANS Team
=======================================================

When you disable an offload setting for an adapter in an ANS team, the team
reloads and the team capabilities are recalculated. As a result, the offload 
setting is disabled for the remaining adapters in the ANS team. 

By design, Intel PROSet does not reflect the fact that the offload setting
is disabled for the remaining adapters in the team. 

If you re-enable the offload setting for the original adapter in the team,
the team reloads and the setting is automatically re-enabled for the 
remaining adapters.


Updating Drivers and Utilities on Systems Using IPSec
=====================================================

If you have a Windows NT 4.0 or Windows 9x system and you are using IPSec,
upgrading drivers and utilities might cause changes to your security 
setting or potential mismatches with the adapter drivers or applications. 
If you want to continue using IPSec, Intel recommends that you NOT update 
to this software version. If you do not wish to continue using IPSec, 
uninstall the existing Intel IPSec software before installing this version.


Upgrading Drivers and Utilities from Previous Versions
======================================================

If you downloaded a driver package from the Intel support web site, note 
that the installer program performs several operations in "silent mode."  
The first time you run the installer, it starts the Intel(R) PROSet 
installer, which automatically installs (or upgrades) drivers and related 
components, including the Intel PROSet control panel utility.  Any 
subsequent time you run the downloaded installer, it upgrades the drivers 
only if necessary.  

The Autorun program on the Intel CD does not behave this way.  The CD's 
autorun gives you the option of selecting driver, PROSet, or other 
component services such as DMI, WMI NIC Provider, and SNMP.  From there, 
the MSI installer takes over and provides additional choices for upgrading 
or uninstalling, where applicable. 


Repairing installation of utilities
===================================

When attempting to repair the installation of DMI or the WMI NIC provider, 
you must first uninstall and then reinstall the utility. To uninstall a 
utility:

  1. Run the Intel PROSet Installer.
  2. In the Program Maintenance dialog box, select Modify. The Custom Setup
     dialog box is displayed.
  3. By default, the WMI NIC provider is not installed. Click Next. 
  4. Follow the onscreen directions to finish the installation.

After completing the uninstall, use the Intel PROSet Installer to reinstall 
the utility. 


Team setup requirement
======================

Before adding an adapter to a team, make sure each adapter is configured 
to match the lowest-common denominator feature set of all adapters in the team. 
For team members to successfully implement teaming functionality, each team 
member must be configured similarly. To check team member configuration, view 
each team members' settings in the Advanced tab in Intel PROSet.  Settings to 
check include QoS Packet Tagging, Jumbo Frames, and the various offloads. If 
team members implement Advanced features differently, failover and team 
functionality are affected.  


IEEE 802.3ad teaming with Foundry switches
==========================================

Foundry switches require an even number of ports in an aggregated link. If 
you remove an adapter from an 802.3ad team connected to a Foundry switch, 
make sure you maintain an even number of adapters in the team.


Locally administered address (LAA) in Windows 98SE
==================================================

If you want to use the default address after using a manually-assigned 
(LAA) address, perform one of these procedures:

  - From the Network Properties dialog box’s Advanced tab, select Locally 
    Administered Address and change its value to 0. Click OK to apply the 
    setting.

  - In Intel PROSet II, click the Advanced tab, then click Restore Default 
    or clear all characters from the Value field. Click OK to apply the 
    setting.


Windows 98 SE Driver Installation Issues
========================================

When installing drivers on Windows 98 SE, the Hardware Installation
Wizard is displayed. If you use the wizard, you must specify a
location for the drivers. After checking the Specify a Location
checkbox, browse to the Intel CD and then to the \PRO1000\WIN_98ME
directory.  Similarly, for Intel PRO/100 adapters, go to the 
\PRO100\WIN_98ME directory.


Controller Information not available in Windows 98 and Windows NT
=================================================================

In systems running Windows 98 and Windows NT, Intel PROSet does not 
display controller information in the Adapter Details window. However, 
Intel PROSet help indicates that this setting is available. 


Known limitations
=================

  Procedure for installing and upgrading drivers and utilities
  ------------------------------------------------------------
  Intel does not recommend installing or upgrading drivers and Intel(R)
  PROSet software over a network connection. Instead, install or upgrade
  drivers and utilities from each system. To install or upgrade drivers
  and utilities, follow the instructions in the User Guide.

  Installing Intel PROSet and Intel PROSet for Windows Device Manager on 
  the same system
  ----------------------------------------------------------------------
  Intel does not recommend installing both Intel PROSet and Intel PROSet 
  for Windows Device Manager on the same system.

  Enabling GMRP with AFT Teaming May Create Multicast Group
  ---------------------------------------------------------
  If GMRP is enabled at the switch, with AFT teaming in a Windows environment, 
  you may find a new multicast group within all the ports connected to the 
  team members participating in it.  This occurs only in Microsoft Windows 
  XP and Server 2003.  The multicast address is used by IEEE 802.1x protocol, 
  which is supported by these operating systems. 

  "Test switch configuration" in PROSet fails when using Cisco 6500 switch
  ------------------------------------------------------------------------
  If you are connecting a team with GVRP support to a Cisco 6500 switch, and 
  then run the "test switch configuration" selection in PROSet, the test 
  will fail.  This is because the Cisco 6500 switch does not support 
  dynamic VLAN de-registration.  

  Changing Teaming Settings from Device Manager
  ---------------------------------------------
  If Intel PROSet is installed on your system, changing the advanced 
  settings for a teamed adapter in Device Manager may impact performance 
  of the team.  This problem does not occur if you change the advanced 
  settings for the adapter and the team using Intel PROSet. 

  "The Location You Specified Does Not Exist or Cannot Be Reached" Error 
  during driver installation
  ----------------------------------------------------------------------
  This is a known issue with Windows Server 2003.  Please see Microsoft
  Knowledge Base article 819586 for workarounds and a possible patch.
  <http://support.microsoft.com/default.aspx?scid=kb;en-us;819586>
  
  "Out Of Disk Space" Message during Installation
  -----------------------------------------------
  The boot drive requires a minimum of 15 MB free space in order to install 
  Intel PROSet, regardless of which drive you specify for installation.  If 
  there is insufficient space on the boot drive, you will see this error 
  message, and the product will not install.  

  Windows Code 10 Error Message on Driver Install or Upgrade
  ----------------------------------------------------------
  If you encounter a Windows Code 10 error message when installing or 
  upgrading drivers, rebooting resolves the issue. To prevent the error from 
  occurring, either disable your existing NICs through Windows Device Manager 
  or uninstall all of your existing NICs through Windows Device Manager. You 
  do not need to remove the adapter cards from the system. In either case, all 
  NICs will be upgraded to use the new drivers.

  "Fail to load one of the network components" error on Windows XP, SP 2
  ----------------------------------------------------------------------
  This occurs if the current user is logged in on a guest account.  Logging in 
  to an account that has administrative rights will correct this.

  Throughput reduction after Hot-Replace
  --------------------------------------
  If an Intel gigabit adapter is under extreme performance stress and is 
  hot-swapped, throughput may significantly drop.  This may be due to the 
  PCI property configuration by the Hot-Plug software.  If this occurs, 
  throughput can be restored by restarting the system.

  Uninstalling PROSet II in Windows 98
  ------------------------------------
  Occasionally, if you uninstall Intel PROSet II from a system running 
  Windows 98, PROSETP.HLP and PROSETP.CNT remain in the C:\WINDOWS\SYSTEM 
  directory.  These files are only used by Intel PROSet II, and can be 
  left as-is or manually deleted with no consequence.  

  Running diagnostics on Windows 98 SE
  ------------------------------------
  Before running diagnostics in Intel PROSet II, determine whether ACPI 
  power management is installed and running. If so, open the Device
  Manager and make sure that the option "Allow the computer to turn
  off this device to save power" is turned off.  This will require that 
  you reboot the computer for the change to take effect. 
  
  If you still encounter a problem when running diagnostics from 
  PROSet II, use the DOS diagnostics tool. To start the tool, navigate 
  to the APPS/TOOLS directory on the Intel CD. From a DOS prompt, type 
  DIAGS.

  System Wakes-Up from a Remote VLAN
  ----------------------------------
  If a system goes into standby mode, and a directed packet is sent to the 
  IP address of the removed VLAN, the system will wake-up.  This occurs 
  because a directed packet bypasses VLAN filtering. 

  Removing a teamed adapter from a hot-plug system
  ------------------------------------------------
  When you physically remove an adapter that is part of a team or a VLAN, 
  you must reboot or reload the team/VLAN before using that adapter in the 
  same network. This will prevent Ethernet address conflicts. 

  PRO1000 Receive Errors on Windows NT 4.0
  ----------------------------------------
  If you experience high received error counts on a Windows NT 4.0 system 
  with a PRO1000 adapter installed, increasing the Receive Descriptors 
  setting to 384 will alleviate the problem.

  No I/O Access for Older Adapters on Windows NT 4.0
  --------------------------------------------------
  Some older adapters do not support I/O. When these adapters are removed 
  with the hot plug lever on a Windows NT 4.0 system, the system no longer 
  functions. Before using the hot plug lever on a system running Windows NT
  4.0, make sure that the adapter supports I/O. If the adapter does not 
  support I/O, power down the system before removing the adapter.

  TCP Segmentation for Windows 2000
  ---------------------------------
  The advanced feature, TCP segmentation, is not supported in windows
  2000 for Intel PRO adapters. This is due to a limitation of the 
  Windows 2000 operating system.

  Saving and Restoring Adapter Settings
  -------------------------------------
  You can save and then restore adapter settings through Intel PROSet
  or through the script savres.vbs. When you save and restore the 
  settings for an adapter, the preferred primary adapter setting is not 
  saved or restored. You must change the preferred primary adapter
  setting after restoring the team.

  Intel PRO Adapters ignore consecutive Wake Up signals while
  transitioning into standby mode
  -----------------------------------------------------------
  While sending a system into standby, occasionally a wake up packet 
  arrives before the system completes the transition into standby mode.
  When this happens, the system ignores consecutive wake up signals
  and remains in standby mode until manually powered up using the
  mouse, keyboard, or power button.

  Changing speed and duplex of adapters in a team
  -----------------------------------------------
  When you add an adapter to a Fast EtherChannel, Gigabit EtherChannel, 
  or Link Aggregation team using Intel PROSet, make sure that the
  adapter is running at the speed of the other adapters in the team.

  Netware 5.1 (and later) with PRO/1000 adapters
  ----------------------------------------------
  When manually installing drivers in a Netware 5.1 (and later) environment, 
  there may not be enough resources for all adapters during installation, 
  so the parameter of all PRO/1000 adapters' RX buffer should be equal to 
  or lower than 32 (in multiples of 8). 
  
  Enabling/Disabling an adapter in Windows 98 SE and Windows Me 
  requires restart
  -------------------------------------------------------------
  Due to a technical limitation in Microsoft Windows 98 SE and Windows 
  Me, if you enable or disable an adapter, you must restart the 
  computer to ensure stable operation.  

  Windows 98SE - Wake On Directed Packets
  ---------------------------------------
  When trying to enable Wake On Directed Packets on Windows 98SE
  systems, the system does not instruct the driver to wake on
  directed packets. Due to this operating system limitation, this
  feature will not work properly with Intel PROSet.

  Link Difficulties With 82541 or 82547 Based Connections
  -------------------------------------------------------
  The PROSet Advanced tab now contains a setting allowing the 
  master/slave mode to be forced. This improves time-to-link with 
  some unmanaged switches. For older adapters and controllers, you 
  may encounter difficulty with 82541 or 82547 based connections.

  Using Intel PRO/1000 XT or T Adapters and e1000ODI.COM Driver
  -------------------------------------------------------------
  In some cases, an Intel PRO/1000 T or PRO/1000 XT adapter or network 
  connection using the e1000ODI.COM driver will not receive traffic. 
  You can fix this problem by disabling Wake On LAN (WOL) in the 
  adapter hardware before connecting to the network. 
 
  Use IBAUtil to disable WOL. For more information, see the IBAUTIL.TXT 
  file for more information (\APPS\BOOTAGNT directory).  

  Intel PRO/1000 Adapters (copper only) do not detect active link 
  during load time
  ---------------------------------------------------------------
  Some Intel PRO/1000 adapters, especially copper adapters, cannot
  detect an active link during load time. To resolve this issue, try
  the following workarounds.
  - Re-attach to the server without reloading the driver.
  - For DOS-based installations, add a delay of 4 to 5 seconds in the 
    batch file after the load driver command.
  - Load the configuration by manually entering commands.
  - Set adapter to link at 1000 Mbps only. 

  Solaris Drivers
  ---------------
  Solaris drivers are provided for your convenience. However, contact your
  OS vendor for Solaris support regarding these drivers.


Customer Support
================

- Main Intel web support site: http://support.intel.com

- Network products information: http://www.intel.com/network

- Worldwide access: Intel has technical support centers worldwide.  Many of
  the centers are staffed by technicians who speak the local languages. For
  a list of all Intel support centers, the telephone numbers, and the times
  they are open, visit http://www.intel.com/support/9089.htm.

- Telephone support: US and Canada: 1-916-377-7000 
  (07:00 - 17:00 M-F Pacific Time) 


Legal / Disclaimers
===================

Copyright (C) 1998-2004, Intel Corporation.  All rights reserved.

Intel Corporation assumes no responsibility for errors or omissions in 
this document. Nor does Intel make any commitment to update the information 
contained herein.

* Other product and corporate names may be trademarks of other companies 
and are used only for explanation and to the owners' benefit, without intent 
to infringe.
