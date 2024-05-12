filename: README.txt
description: How to extend the NetWare* SNMP.NLM module to support the
INTEL(R)-LAN-ADAPTERS MIB.


Overview:
=========

The LANAgent module extends the SNMP agent for NetWare*. It provides 
information on Intel PRO/100 and PRO/1000 adapters through the ce100b and 
ce1000 adapter drivers. Additional information regarding server features, 
such as teaming and VLANs, is provided through the Intel Advanced Networking 
Services (iANS) module.

This file describes how to enable the NetWare SNMP module to support the
INTEL-LAN-ADAPTERS MIB.


Prerequisites:
==============

For optimal performance by the SNMP agent, install the Intel PRO/100 and/or 
PRO/1000 adapter drivers (ce100b, ce1000) and/or the Intel ANS module (iANS).

The SNMP agent package is compliant with the following driver versions:

   - CE100b.lan: ver 4.11 and above
   - CE1000.lan: ver 3.03 and above
   - iANS.lan  : ver 4.14 and above


Installation Instructions:
==========================

1. Type "Load <path\>LANAgent" at the server prompt.

2. Configure the SNMP community name according to Novell* documentation. For
   example, type "Load SNMP ControlCommunity=" to enable GET and SET for
   any community name. For more information, go to http://www.novell.com
   and search for "Providing SNMP and ConnectView Support".

3. Register to receive Traps by adding the IP address of the management
   station to the list in the file SYS:\ETC\TRAPTARG.CFG.


Available Commands:
===================

"-h" or "help"
   Description: View the help description.

"cache_time=<nn>"
   Default value: 50 (5 seconds)
   Description: Define a time period in which the data structure is 
     considered valid. Two consecutive queries within that time will not 
     cause update of the data. <nn> is an integer value set to 1/10 second.

"trap_time=<nn>"
   Default value: 10 (1 second)
   Description: Define the time period between two consecutive trap checks. 
     The units are the same as for cache_time.

"status"
   Description: View the current values for cache_time and trap_time.



* Other names and brands may be claimed as the property of others.