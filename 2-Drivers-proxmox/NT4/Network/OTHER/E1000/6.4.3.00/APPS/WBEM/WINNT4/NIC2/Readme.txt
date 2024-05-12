********************************************************************
*            INTEL CORPORATION PROPRIETARY INFORMATION             *
*                                                                  *
* This software is supplied under the terms of a license agreement *
* or nondisclosure agreement with Intel Corporation and may not be *
* copied or disclosed except in accordance with the terms of that  *
* agreement.                                                       *
*                                                                  *
*    Copyright (c) 2002 Intel Corporation. All Rights Reserved.    *
********************************************************************

Intel(R) PRO Network Adapters WMI Provider 2.0
============================================== 


README CONTENTS
===============

1. Overview
2. System Requirements
3. Installation 
4. Uninstall Procedure
5. Usage with Applications
6. Supported Standards
7. New Features in this Release
8. Known Issues


1.  Overview
============

The Intel(R) PRO Network Adapters WMI Provider is a set of software 
modules that allow WMI-based management applications such as 
LANDesk Client Manager 6.0 to monitor status of PCI network 
adapters. Intel(R) PRO Network Adapters WMI Provider uses WMI, a 
kernel-level instrumentation technology for the Microsoft Windows 
platform. 

Windows Management Instrumentation (WMI) is a middleware layer that 
allows measurement and instrumentation information to be collected 
from kernel mode data providers. This information can then be provided 
to local or remote user-mode data consumers through the use of a common 
set of interfaces (Web-based Enterprise Management called WBEM). 
WMI is a data-independent pipeline between the data consumer and 
the data provider that makes no assumptions about the format of 
the data.

For example, Intel(R) PRO Network Adapters WMI Provider uses WMI
event notification mechanism to send an event if a loosely 
plugged-in cable falls free and the Ethernet signal is lost.

The driver from this CD is required to be able to view custom
information regarding Adapter Fault Tolerance and Adapter Load
Balancing (AFT/ALB). 


2. System Requirements
======================

- Any Intel(R) PRO/100, PRO/1000 Adapters and related driver 
software.

- Microsoft WMI Core. 

- Windows* NT4 (SP4 or later), Windows 9x (Win98 OSR1 or later).

- For Adapter Teaming features, AFT and ALB support, the latest NDIS 
drivers on this CD are also required.


The WMI Core components are part of the operating system. These 
pieces are required for a WMI enabled application to work.

The Intel(R) PRO Network Adapters WMI Provider supports all Intel(R) 
PCI PRO/100 and PRO/1000 adapters. If you are running an NDIS based 
driver under Windows NT 4.0, there is no need to install any new 
drivers to get full WMI support.


3. Installation
===============

To install Intel(R) PRO Network Adapters WMI Provider, click on the 
setup program found in the "Apps\WBEM\Win9x\Nic2" or
"Apps\WBEM\Winnt4\Nic2" directory on the CD.
WMI Core components must be installed before Intel(R) PRO Network Adapters 
WMI Provider is installed. If Intel(R) PRO Network Adapters WMI 
Provider does not find the WMI Core components' registry keys, installation
fails. If Microsoft WMI Core is not installed, install it and restart 
Intel(R) PRO Network Adapters WMI Provider installation. 
	
The most recently released version of the Microsoft WMI Core can be 
downloaded from Microsoft's web site - "http://www.microsoft.com".


Upgrade Notes:

Prior to installation of the Intel(R) PRO Network Adapters WMI 
Provider, all running programs using Intel(R) PRO Network Adapters WMI 
Provider must be stopped. Once all programs have been stopped, older 
installations of the Intel(R) PRO Network Adapters WMI Provider 
need to be removed.


4. Uninstall Procedure
======================

To uninstall Intel(R) PRO Network Adapters WMI Provider:

- Select Start -> Settings -> Control Panel.
- Double-click the Add/Remove Programs icon.
- On the Install/Uninstall tab, select "Intel(R) PRO Network Adapters 
WMI Provider (Build 2.0)".
- Press the "Add/Remove..." button.


5. Usage with Applications
==========================

WMI-based management applications such as WBEM CIM studio and WBEM 
Object browser in the WMI SDK can be used to access Intel(R) Client 
Instrumentation properties both locally and remotely. 

On Windows 95/98 or Millennium operating systems, however, you must 
carefully configure client systems to allow remote access of Intel(R)
PRO Network Adapters WMI Provider properties.

To do this, you will need to edit the Windows 95/98 or Millennium 
registry to remotely access Intel(R) PRO Network Adapters WMI Provider 
properties.

**CAUTION**: Editing the system's registry incorrectly can cause 
serious problems that may require you to reinstall the operating system. 
Be very careful when editing the following registry entries. Please 
back up any important data before beginning this process. Please be 
aware that enabling DCOM applications to connect anonymously to your 
system may violate your network's security policies. Please consult 
with your system administrators before making these changes.

A)Open regedit (Start-Run-regedit) on the Win9x or Millennium system, 
and ensure that the following values are set correctly.
  i) HKLM\Software\Microsoft\OLE\EnableDCOM should be set to its 
default of "Y".
 ii) HKLM\Software\Microsoft\OLE\EnableRemoteConnect should be 
changed to "Y".
iii) HKLM\software\microsoft\wbem\cimom\AutostartWin9x should be 
changed to "2".
 iv) HKLM\software\microsoft\wbem\cimom\EnableAnonConnections should 
be changed to "1". 
  v) Exit the registry editor and restart the Windows 95/98 or Millennium system.

B)Log into the Windows 95/98 or Millennium system remotely from a Windows NT 
4.0, Windows 2000, or Windows XP system using WBEM CIM Studio from the WMI 
SDK. 
  i) Enter the UNC name of the Windows 95/98 or Millennium system in the 
box and "Machine name" click "Connect." 
 ii) In the WBEM CIM Studio login window, choose "Options" to see the 
full set of login choices.
iii) Leave "Login as current user" checked. 
 iv) Leave "impersonation level" set to impersonate.
  v) For "authentication level", choose "None." Click OK.
  
This should allow you to connect to your Windows 95/98 or Millennium system 
remotely. The Intel(R) PRO Network Adapters WMI Provider properties 
are available within the CIMv2 class structure.


6. Supported Standards
======================

The Intel(R) PRO Network Adapters WMI Provider 2.0 supports the 
standards based CIM 2.2 specification. 


7. Features in this Release
===========================

Support for AFT/ALB management (Windows NT 4.0).


8. Known Issues
===============

1. This Intel(R) PRO Network Adapters WMI Provider cannot jointly 
operate with the Intel(R) DMI-SNMP instrumentation.

2. Under some circumstances, the process winmngt.exe may not start on
a Windows 9x system.  This results in a browsing machine being unable
to connect to the Win9x machine.  The browser (CIM Studio or other)
may show an error "the RPC server is unavailable".  If pview95.exe
shows that winmngt.exe is not executing, double click on the file to
begin execution. This may be fixed permanently by upgrading to a 
newer version of the WBEM core.

3. Do not install the Intel(R) PRO Network Adapters WMI Provider to
a mapped network drive.  This configuration does not work and is not
supported.

--------------------------------------------------------------
* Other product and corporate names may be trademarks of other 
companies and are used only for explanation and to the owner's 
benefit, without intent to infringe.


Readme.txt version 03-05-2003
