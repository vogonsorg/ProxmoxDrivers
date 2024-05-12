<!-- Copyright (c) 2001-2005 by Alter -->
<html lang="en">
  <head>
    <title>Universal ATA driver for Windows NT4/2000/XP</title>
    <link rel="stylesheet" href="http://10.0.0.11/alter/common.css" type="text/css">
    <meta name="keywords" content="UniATA, PnP, port, miniport, hardware dependency">
    <meta name="description" content="Universal ATA driver for Windows NT4/2000/XP">
  </head>
  <body align="center">



<!--<center><img src="/blank.gif" width="3" height="3" alt=""><br><a href="http://ccnp.kiev.ua/"><img src="/academy480v1.gif" width="468" height="60" alt="Региональная сетевая академия  Cisco " border="0"></a></center> 
-->



  <center>
  <table valign="top" height="100%" width="770" bgcolor="#ffffff"
         cellspacing="0" cellpadding="0" align="center" style="align: center;">
  <tr height="30"><td class="head1">Alter.Org.UA</td>
  </tr>
  <tr height="1"><td bgcolor="white" >
    <img height="1" width="770" src="http://10.0.0.11/alter/img/1x1.gif" alt=""></td></tr>
  <tr height="20"><td class="head2">
  <table cellspacing="0" cellpadding="0" width="100%"><tr>
    <td width="72" class="head3">&nbsp;<a class="head3" href="http://10.0.0.11/alter/soft/index.php_lang=en&amp;">&lt;&lt;&nbsp;Back</a></td>
    <td width="2" bgcolor="white"><img width="2" height="19" src="http://10.0.0.11/alter/img/1x1.gif" alt=""></td>
    <td width="40" class="head3"><a class="head3" href="http://10.0.0.11/alter/index.php_lang=en">Home</a></td>
    <td width="2" bgcolor="white"><img width="2" height="19" src="http://10.0.0.11/alter/img/1x1.gif" alt=""></td>
  <td width="55" class="head3"><a class="head3" href="uniata_pnp.php_lang=ru&amp;">RU&nbsp;<img height="12" width="20" alt="ru" src="http://10.0.0.11/alter/img/lang_ru.gif"></a></td>
  <td width="2" bgcolor="white"><img width="2" height="19" src="http://10.0.0.11/alter/img/1x1.gif" alt=""></td>
  <td class="head3">&nbsp;</td>
  <td width="150" class="head3">
    <a class="head3" href="http://www.alter.org.ua">www</a>/<a class="head3" href="http://www1.alter.org.ua">www1</a>/<a class="head3" href="http://www2.alter.org.ua">www2</a>  </td>
  </tr></table>
  </td></tr>

  
  
  
  <tr><td>
    <table width="100%" height="100%" valign="top" align="center"
           cellspacing="0" cellpadding="0"><tr>
    <td width="1" class="mainb"><img width="1" height="1" src="http://10.0.0.11/alter/img/1x1.gif" alt=""></td>
    <td height="100%" class="main">
    

<h4>Port/Miniport model</h4>

  <p>Windows NT developers like Port/Miniport driver design.</p>

  <p>_Port_ driver is almost always loaded. It communicates to OS,
implements some common for specific device class functionality
(like interrupt routing, hardware resource claiming,
registering devices in the system, etc.). On other hand,
it exports some API, useful for _MiniPort_ driver (see below).</p>

  <p>_MiniPort_ driver can be loaded either automatically or
by PnP manager. _MiniPort_ contains device detection and init code,
it services standard (device class specific) requests from
_Port_.</p>

  <p>For example if scsiminiport (e.g. atapi, uniata)
informs scsiport about detected devices and their capabilties,
scsiport will create device objects, set up interrupt handler
and inform OS about detected hardware.</p>

<h4>About UniATA</h4>

  <p>First versions used scsiport.sys to claim detected devices
and used hardware resources. All dirty work like creating
device objects, initializing interrupt request service routines,
command queue management, etc. was done by scsiport.sys.</p>

  <p>Later some limitations was meat: impossibility of PCI device enumeration
and searching for generic (but unknown) IDE controllers,
PIO/DMA on single channel, simultaneous
functioning of multiple channels of single controller with 1
interrupt). In addition command queue reordering required
own queue management. Thus I made workarounds using kernel API instead of
scsiport API.</p>

  <p>Currently one of the the main problems is w2k/XP PnP model.
UniATA was initially invented to work on _any_ IDE-compatible
controller on _any_ machine without driver reinstall.
But when device driver is installed, PnP manager remembers, for
what particular hardware the driver is. On further system startups
PnP manager enumerates devices and look in registry what driver should
be loaded. If we attempt to connect HDD to another MotherBoard (with
different controller), PnP manager will not find suitable driver
and system will never boot up.</p>

  <p>Another thing - non pnp-enumerated devices. Device driver for
such device will be loaded anyway (this is driver, which does not
belong to any specific device driver class). If such driver simply
scan PCI bus and inform ScsiPort about detected controllers, PnP
manager will decide, that some devices in system are not pnp-compliant
and block Sleep/Hibernate and IDE hot-swap functionality.</p>

  <p>Both cases described above comes from scsiport behavior.</p>

  <p>We discussed this problem with Vitaliy and came to solution:
For w2k/XP UniATA needs own analogue of scsiport, which
will always expose to OS either single controller or a set of hardware
idependent virtual controllers. All bus scans and device-dependent staff will
be hidden from OS.</p>

  <p>In this case we shall have logical controller and
connected device enumaretion like it was under NT4
(I think that it is much better and flexible architecture)</p>

  <p>It will also has dummy hardware dependent
do-nothing driver. This do-nothing driver will be installed for each
newly detected controller to make PnP manager happy.
Like currently UniATA does: it claims in .inf-file all known
controllers.</p>

    </td>
    <td width="1" class="mainb"><img width="1" height="1" src="http://10.0.0.11/alter/img/1x1.gif" alt=""></td>
    </tr></table>
  </td></tr>


  <tr height="20"><td class="head2">

    <table cellspacing="0" cellpadding="0" width="100%"><tr height="20">
    <td class="head3" width="72">
    <a class="head3" href="http://10.0.0.11/alter/soft/index.php_lang=en&amp;">&lt;&lt;&nbsp;Back</a>
    </td>

    <td width="2" bgcolor="white"><img width="1" height="1" src="http://10.0.0.11/alter/img/1x1.gif" alt=""></td>
    <td class="tail">designed by Alter aka Alexander A. Telyatnikov</td>
    <td width="2" bgcolor="white"><img width="2" height="1" src="http://10.0.0.11/alter/img/1x1.gif" alt=""></td>
    <td class="tail">powered by Apache+PHP under FBSD</td>
    <td width="2" bgcolor="white"><img width="2" height="1" src="http://10.0.0.11/alter/img/1x1.gif" alt=""></td>
    <td class="tail">&copy; 2002&#150;2005</td>
    </tr></table>

  </td></tr></table>
  <center>
</body>
</html>
