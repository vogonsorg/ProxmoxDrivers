********************************************************************
*            INTEL CORPORATION PROPRIETARY INFORMATION             *
*                                                                  *
* This software is supplied under the terms of a license agreement *
* or nondisclosure agreement with Intel Corporation and may not be *
* copied or disclosed except in accordance with the terms of that  *
* agreement.                                                       *
*                                                                  *
*    Copyright (c) 2001 Intel Corporation. All Rights Reserved.    *
********************************************************************

Intel(R) PRO Quality of Service (QoS) WMI Provider 1.0
 (PRO 10/100 Adapters Only)
====================================================== 

README CONTENTS
===============

1. Overview
2. System Requirements
3. Installation 
4. Uninstall Procedure
5. Usage with Applications
6. Supported Standards
7. Known Issues


1.  Overview
============

The Intel(R) PRO Quality of Service (QoS) Windows Management
Instrumentation (WMI) Provider is a set of software modules that
allow WMI-based management applications to manage the QoS
capabilities of Intel(R) PRO network adapters. QoS WMI Provider
uses WMI, a kernel-level instrumentation technology for the
Microsoft Windows platform.

WMI is the middleware layer that allows measurement and
instrumentation information to be collected from kernel mode
data providers. This information is then provided to local or 
remote user-mode data consumers through the use of a common set 
of interfaces (Web-based Enterprise Management called WBEM). WMI
is a data-independent pipeline between the data consumer and
the data provider that makes no assumptions about the format
of the data.

The QoS WMI Provider lets WMI-aware management applications
set up priority filters to process high priority network
traffic before normal traffic. By prioritizing traffic at the
host or entry point of the network, network devices can base
forwarding decisions on priority information defined in the
packet.

WMI-aware management applications using QoS WMI Provider
functionality can configure priority filters on the target
system to do the following:
- Tag packets with priority levels for forwarding behaviors.
- Drop incoming packets that match certain criteria.
- Obtain statistics such as number of packets or number of bytes 
  that were tagged with a particular priority.


2. System Requirements
======================

- Intel(R) PROSet II v4.0 
- Intel(R) drivers v4.0 or greater
- Microsoft WMI Core
- Windows* NT4 (SP6a),Windows 95/98 or Millennium

- For Adapter Teaming features (AFT and ALB support), the latest NDIS 
  drivers on the Intel(R) CD or downloaded from support.Intel.com.

DO NOT USE THE Intel(R) Boot Agent (PXE) WMI Provider 1.1 WITH WINDOWS*2000 OR WINDOWS* XP. SUPPORT FOR THESE OS's ARE PROVIDED WHEN PROSET IS INSTALLED.


The WMI Core components are part of the operating system. These 
pieces are required for a WMI-enabled application to work.

The QoS WMI Provider supports all Intel PCI PRO 10/100 adapters except
for 82557 based adapters.
The QoS WMI Provider does not support any PRO 1000 adapters.


3. Installation
===============

To install QoS WMI Provider, double-click on the setup program found in
the "Windows\Wbem\WMI\QOS" directory on the Intel CD. WMI Core components
must be installed before QoS WMI Provider is installed. If 
QoS WMI Provider does not find the WMI Core component's registry
keys, installation fails. If Microsoft WMI Core is not installed,
install it and restart the QoS WMI Provider installer. 
	
The most recently released version of Microsoft WMI Core can be 
downloaded from:

http://www.microsoft.com



4. Uninstall Procedure
======================

To Uninstall QoS WMI Provider:

- From the Control Panel, double click on the Add/Remove
  Programs icon.
- On the Install/Uninstall tab, select "Intel(R) PRO Quality
  of Service (QoS) WMI Provider (Build 1.0)".
- Click the "Add/Remove..." button.


5. Usage with Applications
==========================

WMI-based management applications such as WBEM CIM studio and WBEM 
Object browser in the WMI SDK can be used to access QoS WMI
Provider functionality both locally and remotely. This applies to
Windows NT 4.0 (SP4 and later). 

On Windows 95/98 or Millennium operating systems however, you must 
carefully configure client systems to allow remote access of QoS WMI 
Provider functionality.

To do this, you will need to edit the Windows95/98 or Millennium 
system registry to remotely access QoS WMI Provider functionality.

**CAUTION**: Editing the system's registry incorrectly can cause 
serious problems that may require you to reinstall your operating
system. Be very careful when editing the following registry 
entries. Back up any important data before beginning this 
process. Be aware that enabling DCOM applications to connect 
anonymously to your Windows9x or Millennium system may violate 
your network's security policies. Consult with your system 
administrator before making these changes.

A) Open regedit (Start-Run-regedit) on the Win9x system, and ensure 
   that the following values are set correctly.

  i) HKLM\Software\Microsoft\OLE\EnableDCOM should be set to its 
     default of "Y".
 ii) HKLM\Software\Microsoft\OLE\EnableRemoteConnect should be 
     changed to "Y".
iii) HKLM\software\microsoft\wbem\cimom\AutostartWin9x should be 
     changed to "2".
 iv) HKLM\software\microsoft\wbem\cimom\EnableAnonConnections 
     should be changed to "1". 
  v) Exit the registry editor and restart the Windows9x or Millennium system.

B) Log onto the Windows9x or Millennium system remotely from 
   Windows NT 4.0 using WBEM CIM
   Studio from the WMI SDK. 

  i) Enter the UNC name of the Windows9x or Millennium system in 
     the "Machine name" box and click "Connect." 
 ii) In the WBEM CIM Studio login window, choose "Options" to see 
     the full set of login choices.
iii) Leave "Login as current user" checked. 
 iv) Leave "impersonation level" set to impersonate.
  v) For "authentication level", choose "None." Click OK.
  
This should allow you to connect to your Windows9x or Millennium 
system remotely. 

6. Supported Standards
======================

The QoS WMI Provider implements the CIM specification that was
submitted to DMTF for adoption into CIM 2.4 specification.

7. Known Issues
===============

- Under some circumstances, the process winmngt.exe may not start 
  on a Windows 9x or Millennium system.  This results in a browsing 
  machine being unable to connect to the Win9x or Millennium machine. 
  The browser (CIM Studio or other) may show an error "the RPC server 
  is unavailable".  If pview95.exe shows that winmngt.exe is not 
  executing, double click the file to begin execution. This may be 
  fixed permanently by upgrading to a newer version of the WBEM core.

- All WBEM classes share the same access. There is currently no method to
  define per-class security. Therefore, it is not possible to restrict
  access to the QoS provider without restricting access to all WBEM classes.
  Consult Microsoft's WBEM/WMI documentation for information on setting
  appropriate security.

- It is possible to create filters that conflict. For example, adding the
  same filter with two different names will cause one filter to be ignored.
  Ensure that any filters added will not conflict with existing filters.

--------------------------------------------------------------
* Other product and corporate names may be trademarks of other 
companies and are used only for explanation and to the owner's 
benefit, without intent to infringe.


Readme.txt version 02-27-2002


