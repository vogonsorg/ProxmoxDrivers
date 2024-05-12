Intel(R) Linux* LAN Adapters PROCfg Application
===============================================

June 29, 2004


Contents
========
- Overview
- Prerequisites
- Supported Features
- Using TCO-Enabled Devices in a Teaming Environment
- Installation
- Running the PROCfg Client
- Known Issues
- Support


Overview
========

This file describes the Intel(R) Linux* LAN Adapters PROCfg Application,
version 2.2.x.

PROCfg is a reporting and configuration tool for the Intel(R) PRO family 
of LAN adapters (10/100 and 1000) and Intel Advanced Network Services 
(ANS). It works with the Intel e100, e1000, and ANS drivers on Intel 
32-bit architectures running Linux. It does not work on Intel 64-bit architectures.

The tool consists of two parts: the PROCfgd daemon and the PROCfg command-
line tool. The daemon should be run on a managed machine. The command-line 
tool should be used on a managing machine. The managing system can be either 
the system that is used for the daemon or a remote system.

Refer to the man page in the tar file for details on specific commands.


Prerequisites
=============

PROCfgd and PROCfg require the following minimal versions:

  - Linux 2.4.x kernels

  - Any combination of the following Intel drivers:

      - e100 version 3.0.x
      - e1000 version 5.3.x
      - ANS version 3.0.x - 3.4.x

      NOTE: The non-Intel driver eepro100 must not be loaded on the managed
            machine.

  - libstdc++-libc6.1-1.so.2 package - available in Red Hat* 7.2 and later. 
    Located in either the libstdc++ or compat-libstdc++ package provided 
    with the operating system.

  - openssl* 
      - If your gcc version is 3.2 or above, install version 0.9.7 of 
        openssl. Use "gcc -v" to determine your gcc version.
     
        NOTE: openssl 0.9.7 is installed with Red Hat* Linux 9.0 and above. 
              If the package is already installed, make sure the libcrypto.so.4 
              file is in /lib or any other directory in the path. If it is not 
	      installed, see the instructions below for creating libcrypto.so.4.
 
              If you do not have openssl installed, download the package 
	      from <http://www.openssl.org/> and configure openssl with 'config 
	      shared' to create the libcrypto.so.0.9.7 shared library.
 
              To create libcrypto.so.4 under /usr/lib, you must copy 
	      libcrypto.so.0.9.7 to /usr/lib and create a link named 
	      libcrypto.so.4 to libcrypto.so.0.9.7 : 

                 cp libcrypto.so.0.9.7 /usr/lib
		 cd /usr/lib
		 ln -s libcrypto.so.0.9.7 libcrypto.so.4 

      - If your gcc version is 2.96, install version 0.9.6<x> of openssl,
        where <x> is "b" or above. 

        NOTE: openssl-0.9.6<x> is installed with Red Hat* Linux 7.2 and above. 
              If the package is already installed, make sure the libcrypto.so.2 
              file is in /lib or any other directory in the path. If it is not 
              installed, see the instructions below for creating libcrypto.so.2. 

              If you do not have openssl installed, download the package from 
              <http://www.openssl.org> and configure openssl with 'config shared'
              to create the libcrypto.so.0.9.6<x> shared library. 

              To create libcrypto.so.2 under /usr/lib, you must copy 
              libcrypto.so.0.9.6<x> to /usr/lib and create a link named 
              libcrypto.so.2 to libcrypto.so.0.9.6<x> : 

                  cp libcrypto.so.0.9.6<x> /usr/lib
                  cd /usr/lib
                  ln -s libcrypto.so.0.9.6<x> libcrypto.so.2 

       - Exception: On Redhat 8.0, install version 0.9.6<x> of openssl, 
         where <x> is "b" or above.


Supported Features
==================

PROCfg includes the following features for Intel adapters:
   
  Viewing: 
    - Bus, Slot, and IRQ numbers for physical adapters
    - Static driver info: name, version, path, date, size (base driver and ANS)
    - Adapter load-time parameters and their values (e100 only)
    - Dynamic information: link state, speed and duplex (Intel adapters 
      only), and statistical counters
    - Interface information on loaded adapters and teams including:
       - Virtual interfaces (VLANs)
       - Aliases
    - The ANS topology (teams, members, VLANs)
    - Team and member parameter values	
    - Dynamic information regarding the state of a team and the state of its 
      members

  Setting: 
    - MAC, inet, mask, and broadcast addresses
    - MTU size
    - Interface state
    - Load-time parameters (e100 only)
    - Team settings: initial config, add members, change teaming mode, 
      change probes settings. Teaming modes include:
        - Adapter Fault Tolerance ("AFT")
        - Switch Fault Tolerance ("SFT")
        - Adaptive Load Balancing ("ALB"), includes Receive Load Balancing 
          ("RLB")
        - Static Link Aggregation ("SLA"), includes Intel® Link Aggregation 
          or Cisco FEC or GEC
        - IEEE 802.3ad: dynamic ("802.3ad")
    - VLAN settings: add/delete VLANs for a physical adapter or team 
      (adapters controlled by e100 or e1000 drivers only)
     
       NOTE: Once a physical adapter is a team member or has VLANs, any 
             operation issued by ifconfig on the individual network 
             interfaces of such an adapter may cause corruption. As a 
             precaution, Intel recommends using PROCfg to configure the 
             interfaces and ifconfig only for operations that PROCfg does not
             support.

    - Loading and unloading of drivers

  Special Functions:
    - Blink hardware LEDs to identify a specific adapter
    - Run diagnostics on adapters
    - Save and restore network configurations. The configuration is saved as 
      a text file in XML-format. It is possible to edit this file, but restore
      fails if either the file is in illegal XML format or if it contains
      invalid configuration data.

      NOTE: Restoring a configuration destroys the current PROCfg system 
            configuration. This includes unloading Intel drivers. Multi-vendor
            team (MVT) drivers are not unloaded, as they might control adapters
            that are not supported by PROCfg and ANS. To avoid MVT adapters 
            using names that are used in the saved configuration file, 
            manually unload the drivers before using the "restore" operation. 
            For additional information, see the Known Issues section.        

  Error messages:
    - User initiated operation failures 
    - Daemon initiated operation failures, usually polling failure

    NOTE: All error messages are printed to the console.

  Logging:
    - Configuration changes 
       - If found during periodic polling noted as "external events"
       - If user change noted as "events generated by session ID X"
    - Errors 
       - Errors that occur only in the daemon

       NOTE: Events are logged in /var/log/procfgd.log.


Using TCO-Enabled Devices in a Teaming Environment
==================================================
If an adapter is TCO enabled and connected to a Baseboard Manageability 
Controller (BMC), you can add it to any type of ANS team. However, if 
you are adding it to a Static Link Aggregation (SLA) or an IEEE 802.3ad 
Dynamic Link Aggregation Team, a warning is displayed indicating that 
all manageability traffic will be lost. The result is that the system 
management capabilities will be non-functional. This is due to load 
balancing requirements within a team and the fact that manageability 
traffic is restricted to a single port on a specific adapter.

Also, if the adapter is connected to a BMC device that does not use a 
dedicated MAC address, Receive Load Balancing and Adaptive Load Balancing 
teams will lose manageability traffic like SLA and Dynamic Link Aggregation 
Teams mentioned above.



Installation
============

NOTE: The following instructions describe installing the PROCfg package 
      through the tar file; although, PROCfg may be installed through a 
      binary RPM* package. To build a binary RPM* package of this 
      application, run 'rpmbuild -tb <filename.tar.gz>'. Replace 
      <filename.tar.gz> with the specific filename of the package.

  PROCfgd
  -------
      There are different tar balls per IA architecture(i386 and x86_64)
      and per gcc compiler version (v2.96 and v3.2). 
      NOTE: For x86_64, there is only support for gcc3.2.

      In the following:
      x.v.z represents the version number of the component,
      VER is the gcc* compiler version: 2.96 or 3.2
      ARC is the machine architecture: i386 or x86_64


  1.  Copy procfgd-x.y.z-VER.ARC.tar.gz and libxerces-c.VER.ARC.tar.gz 
      to the directory of your choice.

      NOTES:
      - Use "gcc -v" to determine your gcc version.
      - On Redhat 8.0, install the gcc2.96 versions.
      - Use "uname -m" to determine your machine architecture. 
      - For i<x>86 architectures use the i386 tar ball.
      - "libxerces" is the xerces XML-parser library; you do not need to 
        install it if it is already installed.

  2.  Untar the procfgd-x.y.z-VER.ARC.tar.gz file.
      The procfgd-x.y.z directory should appear.

  3.  Change directory to the procfgd-x.y.z directory:

        cd procfgd-x.y.z

      The following files should be in the directory:

        INSTALL
        INSTALL_BOOT
        prodfgd_init
        prodfgd_init_def
        prodfgd_init_suse
        prodfgd_init_caldera
        procfgd
        procfgd_adduser
        procfgd.1.gz
        procfgd.spec
        uninstall
        README
        ldistrib.txt
        LICENSE.txt
        LICENSE.net-snmp.txt
        LICENSE.xerces.txt

  4.  Enter:

        ./INSTALL

      The INSTALL script untars necessary tar files and copies the following 
      files to the indicated location:

        procfgd (the server application) and procfgd_adduser to /usr/sbin
        procfgd.1.gz (the man page) to the default man directory
        the licenses, README, and ldistrib.txt files to 
            /usr/share/doc/procfgd-<package_version>

  5.  After procfgd is installed, the INSTALL script asks if you want 
      procfgd to automatically run on boot. If you answer 'yes', a script 
      called 'procfgd' is placed in the directory containing the system's 
      boot scripts (usually in /etc/rc.d/init.d/). If you answer 'no' and 
      later change your mind, you can always enter the 'procfgd-x.x.x'
      directory and run the command:

        ./INSTALL_BOOT install

      Likewise, if you no longer want procfgd to run on boot, use the 
      command:

        ./INSTALL_BOOT uninstall

  6.  To run the PROCfg server, first logon to the system as root. Enter:

        procfgd

      NOTE: To change the configuration for the PRO LAN adapters or iANS 
            PROCfgd requires a non-default username and password. To 
            configure a user, see the instructions in the next step.
      
      The daemon runs by default on port 58086. If this port is taken or if
      PROCfgd is already running on the default port, the following error 
      message is printed on the screen:

        Error opening specified endpoint "58086"
        Server Exiting with code 1

      In order to run the server on an alternate port, use the -p option:

        procfgd -p <port number>

  7.  To add a new read/write-access user to the PROCfg server, first logon
      as root. Make sure PROCfgd is not running. Enter the following, where
      the password is at least 8 characters long:

        /usr/sbin/procfgd_adduser <username> <password>

      Multiple read/write users may be added. The new username(s)/
      password(s) are added to the /var/.procfgd/procfgd.conf file. After 
      running the server once, this file is encrypted, but the password is 
      visible while typing it.

      NOTE: A single read-only user is configured by default on the PROCfg 
            server. To simply view settings no username or password are 
            required, as long as the default username and password 
            (username=procfgd, password=pRoCfGdPaSs) have been left in 
            place.

  To Uninstall
  -----------

  1.  To uninstall enter

         ./UNINSTALL

      The UNINSTALL script will remove all files installed by INSTALL script
      (see step 4 above).

  PROCfg
  ------

      There are different tar balls per gcc compiler version (v2.96 and v3.2).         
      The tar balls support the i386 and x86_64 IA architectures. 
      The tar balls do not depend on architecture.  
      NOTE: For x86_64, there is only support for gcc3.2.

      In the following:
      x.v.z represents the version number of the component,
      VER is the gcc* compiler version: 2.96 or 3.2

  1.  Copy procfg-x.y.z-VER.tar.gz to directory of your choice.
  
      NOTES:
      - Use "gcc -v" to determine your gcc version.
      - On Redhat 8.0, install the gcc2.96 versions.
      - Use "uname -m" to determine your machine architecture. 

  2.  Untar the procfg-x.y.z-VER.tar.gz file.
  
      The procfg-x.y.z directory should appear.


  3.  Change directory to the procfg-x.y.z directory:

        cd procfg-x.y.z

      The following files should be in the directory:

        INSTALL
        procfg
        procfg.1.gz
        procfg.spec
        README
        ldistrib.txt
        uninstall
        LICENSE.txt
        LICENSE.net-snmp.txt

  4.  Enter:

        ./INSTALL

      The INSTALL script copies the following files to the indicated location:

        procfg (the server application) - to /usr/sbin
        procfg.1.gz (the man page) - to the default man directory
        the licenses, README, and ldistrib.txt files to 
            /usr/share/doc/procfg-<package_version>

      To configure a user in the PROCfg client (procfg), see the Switches 
      section below.

      NOTE: A single read-only user is configured by default on the PROCfg 
            server. To simply view settings no username or password are 
            required, as long as the default username and password 
            (username=procfgd, password=pRoCfGdPaSs) have been left in place.

  To Uninstall
  -----------

  1.  To uninstall enter

         ./UNINSTALL

      The UNINSTALL script will remove all files installed by INSTALL script
      (see step 4 above).



Running the PROCfg Client
=========================

The following parameters are used by entering them on the command line with 
the procfg command. When issuing a command, the following syntax must be 
used:

       procfg [<switch(es)>] <command> [<object(s)>] [<option(s)>]

Object(s) can be an interface name (ethx), team name, or list of interfaces 
or team names (eth0 eth1 ...).

Each switch has a long name as well. See the man page for a more detailed 
description of the command options.

CAUTION: The PROCfgd daemon must be running before issuing a command.


   Switches
   --------

   -p <port>
       If the PROCfgd daemon is not using the default port, you must set the 
       PROCfg application to the same port. If a port number is not specified, 
       the default port (58086) is used.

   -h <hostname>
       Hostname or IP address of the managed machine (the one that runs the
       PROCfgd server). If not specified, the default hostname (localhost) is 
       used.

   -U <username> -P <password>
       Set the username and password to access the server application. The 
       username and password must be pre-configured in the server (see the 
       Installation section). If you do not specify a username or password, 
       the defaults are used (username: procfgd, password: pRoCfGdPaSs).

       NOTE: The default username is authorized for 'get' operations only.

   -t <num_seconds>
       This parameter specifies how long, in seconds, the PROCfg application
       waits for response from PROCfgd. The default is 4 seconds and should 
       only be increased for a highly stressed server.

   -f "Force mode". Commands do not issue warning to the user.


   To allow a non-default User to write without having to input the username
   and password on each command, or to save changes to any of these values
   create a configuration file named procfg.conf. Place it in your home 
   directory under a procfg directory (~/.procfg/procfg.conf). This file may
   contain the new username, password, port, hostname, force-mode or timeout. 
   The new settings are retained across reboots. An example of the procfg.conf file:

       username anyone
       password anyonepassword
       port 1012
       hostname localhost
       force
       timeout 20

   NOTE: The configuration file must not contain any white spaces following 
         any of the switches.


   Commands - Informational
   ------------------------
        
   help [<command_in-question> [-a]]
       Displays command usage. Use -a for advanced information.

   adapters [<ethx(s) or lspci_adapter_name(s)>]  [-a -v -i -h -p[d] -g]
       Displays general information on adapters in the system including: 
       unique name, system name, link state, speed, duplex, team membership, 
       type (Intel100 for Intel adapters using e100, Intel1000 for Intel
       adapters using e1000, non-Intel vendor names otherwise), VLANs, interfaces, 
       hardware info, adapter load time parameters, and GVRP parameters.
        
       NOTE: Link state, speed, and duplex are not supplied for non-Intel 
             adapters. Non-Intel adapters are shown only if they are
             supported by ANS. For specific switches see the man page.

   adpdiag [<ethx(s)>] [-d <diagnostic_name1>]
           [-d <diagnostic_name2>] ...
       Runs diagnostics on adapters. If no adapter names are given the 
       command displays a list of adapters and their driver, on which a 
       diagnostic can be run. If one adapter name is given without any 
       diagnostic names the command displays a list of diagnostics that can 
       be run on the adapter. If both adapter names and diagnostic names are 
       given the command runs the specified diagnostics on the specified 
       adapters.
       
       Diagnostic options include online, offline, and phyinfo. Online tests 
       do not break network connectivity. Offline tests will disable network 
       connectivity while while they are running. Phyinfo tests check the 
       network cable. 

       NOTE: Tests included in online and offline testing will 
             vary based on the type of adapter being tested.

   blink ethx [-t <num_seconds>]
       Identifies adapter by blinking hardware LED. Default blink time is 10 
       seconds.

       NOTE: procfgd blocks all other network configuration while the blink 
             operation is running.

   interfaces [<ethx(s)>]   [-a -d -s -x]
       Displays general information on all interfaces in the system 
       including: interface name, inet address, broadcast address, netmask, 
       VLAN ID, MTU size, driver info, and statistics.  		       	
   
   teams [<team_name(s)>]  [-m -p -v -i -g]  
       Displays information on the teams in the system including: teaming 
       mode, team current primary, team state, team link state, team speed, 
       team members table, team VLANs table, team MAC, team probe 
       parameters, forward delay, interface table, RLB state, and GVRP 
       parameters.

       Teams probe parameters are: addressing mode, check time out, send 
       time, max retry count, receive time out, receive back cycles, probe 
       burst size.

       Team speed is defined differently for the different teaming modes. For
       AFT, SFT, and ALB team speed equals primary speed. For SLA  team speed 
       equals sum of speeds of all members.

   tree
       Demonstrates the topology of the system. Gives a non-detailed listing 
       of all stand-alone adapters and their VLANs, teams and their VLANs, 
       and members.

       Example of the output of the tree command:
          - adapter eth0
                VLANs:
                  veth0_2    2
                  veth0_4    4
          -adapter eth1
                VLANs:
          -team t0
                VLANs:
                  vt0_5    5
                  vt0_8    8
                members:
                  eth2 
                  eth3  

   vlans
       Displays information on VLANs including: interface name, VLAN name and 
       ID. 


   Commands - Save and Restore
   ---------------------------

   restore [<file_name>] [-c -i -b]
       Restore a network configuration from the host. The configuration is 
       restored from a file in the /etc/procfgd directory. The default file 
       name is saved_conf.procfgd.

       The -c option forces the client to restore the configuration on the 
       server(s). When using this option, you must have a configuration file 
       that contains the server list and hostname (or IP address) for each 
       host on which the configuration should be restored. If you have 
       multiple servers, they must be exact copies of each other; they must 
       have the same types and number of adapters, and same driver versions. 
       When the -c option is used the path to the configuration file may be 
       either relative to the current directory or absolute.

       The -i option restores the IP addresses for the server(s) from the 
       restore IP file. This feature is recommended to prevent connection 
       losses. To use this option, you must first create a restore IP file 
       that contains, for each hostname or IP address in the configuration 
       files described above, a list of interface names and their IP 
       addresses. The restore IP file must be located in the same directory 
       as the configuration file, and this file must be in the directory from
       which the procfg command is run. When the -i option is not used, the 
       IP addresses are as defined in the configuration file.

       The -b option is used for restore on boot.

       For examples of the configuration and restore IP files, see below.

       NOTE: Do not modify hardware configuration if teams are set to restore 
       on reboot. Unexpected results may occur.


   save [<file_name>] [-c]
       Save the current network configuration on the host. The file is saved 
       in the /etc/procfgd directory. The default file name is 
       saved_conf.procfgd.

       The -c option saves the configuration on the client that is configuring
       the server. When the -c option is used the path to the configuration 
       file may be either relative to the current directory or absolute.

       NOTE: Do not insert hardware if teams are set to restore on reboot. 
       If hardware is added, the teams must be recreated.


   To ensure network configuration is restored:

   1. Ensure that you have installed procfgd with the option to automatically
      run on boot. For instructions, see the PROCfgd Installation section.

   2. Ensure that procfg is installed on the server where procfgd is 
      installed before implementing the following procedure.

   3. Save the current configuration as the default saved configuration:

          procfg -f save

      The default file name is /etc/procfgd/saved_conf.procfgd.

      NOTE: You can run 'procfg -f save' once or multiple times. You can also 
            save multiple configurations to different files using 
            '/usr/sbin/procfg save <file_name>'. Then, copy the configuration 
            file you want to restore on boot to the default restore file 
            location (/etc/procfgd/saved_conf.procfgd). The file must be 
            saved to /etc/procfgd or any subdirectory under this location.

   During the next reboot, the default configuration will load and restore 
   your network configuration. 

   NOTE: Saving a configuration on boot does not save operating system-specific 
         network settings, such as an IP address or bound protocols.


   Definition of multi server conf_file:
       [any_name]
       username <user>
       password <password>
       port <n>
       timeout <n>
       hostname <ip_address>
       [any_other_name]
       hostname <ip>
       .....

   Definition of restore_ip.procfgd:
       [name(as in hostname from conf file)]
       <interface_name> <ip_addr> [-b <broadcast>] [-n <netmask>] [-d] 
           [-a <ipv6_address>] [-a <other_address>]
       ...
       [other name]
       ...
       [...]

     NOTES: -d is used for removing the default IPv6 address.
            -a is used to add IPv6 addresses (many -a flags may appear).

            The management adapter's IP address (hostname IP address) in the 
            above examples must be an IPv4 address.


   Commands - Team/VLAN Configuration
   ----------------------------------

   addmem <team_name> <ethx> [-p <priority>] <ethx> [-p <priority>] ...
       Add adapter to team. Default priority is none.

   addteam <team_name> eth0 eth1 ... [-M <mode>] [-e/-d] [-a <addrmode>] 
          [-c <num>] [-s <num>] [-m <num>] [-t <num>] [-r <num>] [-b <num>]
          [-g <aggregation mode>] [-R <on|off>] [-f <num>]
       Add team. <team_name> must be no longer than 8 characters, must start 
       with a letter, and must NOT start with "eth","lo", "ippp" or "cipcb".
       The default teaming mode is AFT. For other default values, see the 
       man page.

   addvlans <ethx>/<team_name> -i <VLAN_ID(s)> [-n <VLAN_name>] -i 
          <VLAN_ID(s)> [-n <VLAN_name>] ...
       Add VLANs to a team or a physical adapter. Each set of VLAN IDs can be 
       tagged with a VLAN name. The VLAN ID range is 0 - 4094.

       NOTES: If a VLAN ID appears twice in the list an error occurs.

              Due to a third-party limitation, adding VLANs when the IPv6 
              module is loaded might cause a network connectivity failure.

   delmem <team_name> <member_names_list>
       Delete members from team.

   delteam <team_name> 
       Delete team.

   delvlans <ethx>/<team_name> -i <VLAN_ID(s)>
       Delete VLANs from a team or physical adapter. If a VLAN ID appears 
       twice in the list an error occurs. delvlans will not remove VLANs if 
       their interface is up.

   NOTE: After configuring teaming and VLAN settings, you must save the 
         configuration as the default to make sure it is restored after the 
         next reboot. To ensure network configuration is restored, see the 
         instructions under the Save and Restore commands.

   Commands - Setting Parameters
   -----------------------------

   NOTES: Enter 'procfg <command>' for a list of the objects that can be 
          configured by the specfied command.

          Enter 'procfg <command> <object>' for a list of parameters that
          can be set by the specfied command and the current values of those
          parameters.   


   adpcfg [<ethx>] [-h <hwaddr>] 
          [-s <10_full|10_half|100_full|100_half|1000_full|autoneg>] 
       Sets adapter hardware address, speed, and duplex.

   adpsetp [<ethx(s)>] [-p <parameter_name1> = <val1>] 
          [-p <parameter_name2> = <val2>] ...
       Sets load time parameters for adapters that are using the e100 driver.

       NOTE: This operation is only available for PRO/100 adapters.

   ifcfg [<ethx>] [-i <addr>] [-n <mask>] [-b <addr>] [-u <pktsize>] 
          [-s <up/down>] [-a <inet6_address>] [-d <inet6_address>]
       Sets interfaces (all set to same value).

       NOTES: Setting aliased interfaces to the same IP address should fail. 
              "ifcfg ethx:i -i 0.0.0.0" removes the alias i from ethx.
              "ifcfg ethx:i -s down" also removes the alias. 

   memcfg <member_name> -p <priority>
       Sets member priority. Possible values = none, primary, secondary.

   teamcfg [<team_name>] [-h <addr>] [-M <mode>] [-e/-d] [-a <addrmode>] 
          [-c <num>] [-s <num>] [-m <num>] [-t <num>] [-r <num>] [-b <num>] 
          [-g <aggregation mode>] [-R <on|off>] [-f <num>]
       Configures team.

   vlancfg <ethx>/<team_name> [-g <on|off> [-t <num>] ]
       Sets GVRP information.


   Commands - Drivers
   ------------------

    loaddrv [<driver_name>] 
       Loads a driver. If no arguments are given, the operation lists the 
       loadable drivers. If a driver name is given, the operation executes the
       modprobe command to load the driver. 

   unloaddrv [<driver_name>]
       Unloads a driver. If no arguments are given, the operation lists the 
       removable drivers. If a driver name is given, the operation executes 
       the rmmod command to unload the driver. 


Known Issues
============

NOTE: For Linux distribution-specific information, see the ldistrib.txt file
      included in the PROCfg tar file.

1.  An error message, "procfg: Unknown engine id, Unable to connect to host", 
    may be seen for every PROCfg command.

    Since PROCfg is a client-server application, the loopback interface in the 
    system (lo) must be up, and it must contain an IP address. Configure the 
    loopback interface up by entering:

      ifconfig lo <IP_address>

2.  Restoring a configuration destroys the current PROCfg system 
    configuration. 

    The restore operation might fail in the following cases:

    - Adapters in the system on which the restore is done are of a different
      type or have different capabilities than the adapters in the system on
      which the configuration was saved.

    - The adapter names in the configuration file are being used by other
      drivers.

    - The system is in a state that does not allow loaded drivers to occupy 
      the adapter names that are specified in the configuration file (adapter 
      names are determined when loading the drivers).

    In order to overcome these situations either edit the configuration file
    and change the adapter names to match the system state and the adapter
    capabilities, or change the system state and/or its adapters in a way
    which will allow restoring the configuration.

3.  Restoring a configuration does not restore the machine's routing table. 
    Therefore, when issuing a restore operation from a remote machine through 
    a gateway defined on the "restored" machine, communication could stop.

    If you have local access to the managed machine, try rebuilding that 
    machine's routing table.

4.  When running PROCfg commands in a script, some commands may fail because 
    of timing issues (some commands take longer than script allows). As a 
    workaround run the script again or insert pauses between the commands in 
    the script.


Support
=======

For general information, go to the Intel support website at:

    http://support.intel.com

If an issue is identified with the released source code on the supported
kernel with a supported adapter, email the specific information related to 
the issue to linux.nics@intel.com.


License
=======

This software program is released under the terms of a license agreement 
between you ('Licensee') and Intel. Do not use or load this software or any 
associated materials (collectively, the 'Software') until you have carefully 
read the full terms and conditions of the LICENSE located in this software 
package. By loading or using the Software, you agree to the terms of this 
Agreement. If you do not agree with the terms of this Agreement, do not 
install or use the Software.

This product also contains copyrighted programs that are used with permission 
and are the property of the respective owners as described in 
LICENSE.net-snmp.txt and LICENSE.xerces.txt.

* Other names and brands may be claimed as the property of others.