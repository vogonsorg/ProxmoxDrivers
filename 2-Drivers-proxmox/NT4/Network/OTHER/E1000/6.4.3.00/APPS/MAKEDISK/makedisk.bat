@echo off
cls
rem makedisk batch file
rem created 07/19/2002
rem Version 4.11
rem last modified 06/15/04


rem minimum requirements DOS 6.22 or NT 3.51 or Windows 95 or newer

rem Check available environment space
set env_chk=0123456789abcdef
if %env_chk% == 0123456789abcdef goto preprocess
goto env_bad

:preprocess
set env_chk=
if "%4" == "copy" set gui=copy
if "%4" == "copy_second" set gui=copy_second
if NOT "%_silent%" == "" goto env_ok
set _silent=TRUE
if "%3" == "silent" %0 %1 %2
if "%3" == "SILENT" %0 %1 %2
if "%2" == "silent" %0 %1 %3
if "%2" == "SILENT" %0 %1 %3
if "%1" == "silent" %0 %2 %3
if "%1" == "SILENT" %0 %2 %3
set _silent=FALSE

:env_ok
rem Check that OS (%1) and destination (%2) are supplied and valid
if "%1" == "" goto USAGE
set dest=
if NOT "%gui%" == "" goto gui_dest
if "%2" == "" set dest=A:
if "%2" == "A:" set dest=A:
if "%2" == "a:" set dest=A:
if "%2" == "A:\" set dest=A:
if "%2" == "a:\" set dest=A:
if "%2" == "B:" set dest=B:
if "%2" == "b:" set dest=B:
if "%2" == "B:\" set dest=B:
if "%2" == "b:\" set dest=B:
if "%dest%" == "" goto setdest
set _mdisk_floppy=TRUE
goto dest_ok

:gui_dest
if %2 == "" set dest=A:
if %2 == "A:" set dest=A:
if %2 == "a:" set dest=A:
if %2 == "A:\" set dest=A:
if %2 == "a:\" set dest=A:
if %2 == "B:" set dest=B:
if %2 == "b:" set dest=B:
if %2 == "B:\" set dest=B:
if %2 == "b:\" set dest=B:
if "%dest%" == "" goto setdest
set _mdisk_floppy=TRUE
goto dest_ok

:setdest
set dest=%2
set _mdisk_floppy=FALSE
goto dest_ok

:dest_ok
if not exist ..\..\VERFILE.TIC goto wrongdir
if "%1" == "nt" goto valid
if "%1" == "NT" goto valid
if "%1" == "ws0364gig" goto valid
if "%1" == "WS0364GIG" goto valid
if "%1" == "ws0364fe" goto valid
if "%1" == "WS0364FE" goto valid
if "%1" == "ws0332fe" goto valid
if "%1" == "WS0332FE" goto valid
if "%1" == "WS0332GIG" goto valid
if "%1" == "ws0332gig" goto valid
if "%1" == "w2kfe" goto valid
if "%1" == "W2KFE" goto valid
if "%1" == "w2kgig" goto valid
if "%1" == "W2KGIG" goto valid
if "%1" == "w9x" goto valid
if "%1" == "W9X" goto valid
if "%1" == "nw" goto valid
if "%1" == "NW" goto valid
if "%1" == "dos" goto valid
if "%1" == "DOS" goto valid
goto invalid

:invalid
echo !!! COMMAND LINE PARAMETERS ARE NOT CORRECT !!!
goto usage

:valid
if NOT "%gui%" == "" goto gui_valid
if "%dest%" == "A:" goto floppy
if "%dest%" == "B:" goto floppy
goto nofloppy

:gui_valid
if %dest% == "A:" goto floppy
if %dest% == "B:" goto floppy
goto nofloppy

:nofloppy
set mode=nofloppy
cls
echo The destination you specified (%dest%) does not
echo appear to be a diskette. If you are trying to create a diskette,
echo press Control-C and answer Y. Then enter this command again, be sure
echo to enter the drive letter without a trailing backslash (A: or B:).
echo.
echo If you do want the files copied to %dest%
if "%_silent%" == "FALSE" pause
goto cont_1

:floppy
set mode=floppy
if NOT "%gui%" == "" goto cont_1 
cls
if exist %dest%\*.* echo !! THIS DISKETTE DOES NOT APPEAR TO BE FORMATTED !!
echo.
echo Please be sure that the disk in %dest% is 1.44 meg, formatted non-bootable and
echo has no pre-existing files. To format the diskette, press Control-C
echo and answer Y, then enter the command FORMAT %dest%. Otherwise,
if "%_silent%" == "FALSE" pause
goto cont_1

:cont_1
if not exist ..\..\verfile.tic goto wrongdir
if "%1" == "nt" goto nt
if "%1" == "NT" goto nt
if "%1" == "ws0364gig" goto ws0364gig
if "%1" == "WS0364GIG" goto ws0364gig
if "%1" == "ws0364fe" goto ws0364fe
if "%1" == "WS0364FE" goto ws0364fe
if "%1" == "ws0332fe" goto ws0332fe
if "%1" == "WS0332FE" goto ws0332fe
if "%1" == "WS0332GIG" goto ws0332gig
if "%1" == "ws0332gig" goto ws0332gig
if "%1" == "w2kfe" goto W2K_FE
if "%1" == "W2KFE" goto W2K_FE
if "%1" == "w2kgig" goto W2K_Gig
if "%1" == "W2KGIG" goto W2K_Gig
if "%1" == "w9x" goto w9x
if "%1" == "W9X" goto w9x
if "%1" == "nw" goto nw
if "%1" == "NW" goto nw
if "%1" == "dos" goto dos
if "%1" == "DOS" goto dos
goto USAGE

:nt
rem     *** Start of the Windows NT section ***
rem Echo what we are about to do
cls
if "%_mdisk_floppy%" == "FALSE" goto skip_1
REM if "%gui%" == "copy" goto skip_1
if "%gui%" == "copy_second" goto skip_2

echo.
echo This batch file will copy the Microsoft Windows NT
echo files to %dest%.  You will need two (2) floppy diskettes.
echo Press CTRL-C and answer Y if this is NOT correct,
echo otherwise,
if "%_silent%" == "FALSE" pause

:skip_1
cls
echo.
echo Copying files to %dest%
echo.

copy /v OEMSETUP.INF %dest%
if exist ..\..\verfile.tic copy ..\..\verfile.tic %dest%
goto nttest_1

:nt4hotadd
REM copy /v ..\Windows\Setup\Hotadd.nt4\oemsetup.inf %dest%
goto nttest_1

:nttest_1
if not exist %dest%\oemsetup.inf goto NOCOPY
goto nt_copyfile

:nt_copyfile
REM MAKE DIRECTORIES FIRST
md %dest%\Drivers
md %dest%\PROSetII
md %dest%\NMS

REM COPY FILES
copy /v ..\..\PRO100\WINNT4\D100Disk %dest%
copy /v ..\..\APPS\PROSet\WINNT4\NMS\IA32\nmscfg.sy_ %dest%\NMS
copy /v ..\..\APPS\PROSet\WINNT4\NMS\IA32\nmsdd.sy_ %dest%\NMS
copy /v ..\..\APPS\PROSet\WINNT4\NMS\IA32\nmssvc.ex_ %dest%\NMS
copy /v ..\..\APPS\PROSet\WINNT4\NMS\IA32\nmssvcps.dl_ %dest%\NMS
copy /v ..\..\APPS\PROSet\WINNT4\NMS\IA32\nmsmsg.dl_ %dest%\NMS
copy /v ..\..\APPS\PROSet\WINNT4\NMS\IA32\nmsapi.dl_ %dest%\NMS
copy /v ..\..\APPS\PROSet\WINNT4\NMS\IA32\regsvr32.ex_ %dest%\NMS

copy /v ..\..\APPS\PROSet\WINNT4\PROSET2\IA32\promon.ex_ %dest%\PROSetII
copy /v ..\..\APPS\PROSet\WINNT4\PROSET2\IA32\prosetp.hl_ %dest%\PROSetII
copy /v ..\..\APPS\PROSet\WINNT4\PROSET2\IA32\prosetp.cn_ %dest%\PROSetII
copy /v ..\..\APPS\PROSet\WINNT4\PROSET2\IA32\roboex32.dl_ %dest%\PROSetII
copy /v ..\..\APPS\PROSet\WINNT4\PROSET2\IA32\inetwh32.dl_ %dest%\PROSetII
echo.

if "%_mdisk_floppy%" == "FALSE" goto skip_2
REM FINISH_FIRST_DISKETTE
if "%gui%" == "copy" set gui=insertsecond
if "%gui%" == "insertsecond" goto END
echo Please remove the diskette and label it
echo Intel(R) PRO LAN Adapter Configuration and Microsoft Windows NT
echo Drivers (Release # from your CD) Disk 1
echo.
echo When ready, insert disk two and then press ENTER to continue
echo.
if "%gui%" == "" pause

echo Making second disk...

if "%gui%" == "" if exist %dest%\*.* echo !! THIS DISKETTE DOES NOT APPEAR TO BE FORMATTED !!
echo.
echo Please be sure that the disk in %dest% is 1.44 meg, formatted non-bootable and
echo has no pre-existing files. To format the diskette, press Control-C
echo and answer Y, then enter the command FORMAT %dest%. Otherwise,
if "%_silent%" == "FALSE" pause

:skip_2

copy /v oemsetup.inf %dest%
if exist ..\..\verfile.tic copy ..\..\verfile.tic %dest%
goto nttest_2

:more_heat
REM copy /v ..\Windows\Setup\Hotadd.nt4\oemsetup.inf %dest%
goto nttest_2

:nttest_2
if not exist %dest%\oemsetup.inf goto NOCOPY
goto cont_2

:cont_2
REM DISK 2 Make Directories
if "%_mdisk_floppy%" == "TRUE" md %dest%\Drivers
if "%_mdisk_floppy%" == "TRUE" md %dest%\PROSetII

REM Disk 2 Copy Files
copy /v ..\..\PRO100\WINNT4\d100dsk2 %dest%
copy /v ..\..\APPS\PROSet\WINNT4\PROSET2\IA32\prosetp.cp_ %dest%\PROSetII

if exist ..\..\APPS\PROSet\WINNT4\PROSET2\IA32\prosetp.re_ copy /v ..\..\APPS\PROSet\WINNT4\PROSET2\IA32\prosetp.re_ %dest%\PROSetII
if exist ..\..\PRO100\WINNT4\DRIVERS\cbmodem.sy_ copy /v ..\..\PRO100\WINNT4\DRIVERS\cbmodem.sy_ %dest%\DRIVERS
if exist ..\..\PRO100\WINNT4\DRIVERS\e100bnt.sy_ copy /v ..\..\PRO100\WINNT4\DRIVERS\e100bnt.sy_ %dest%\DRIVERS
if exist ..\..\PRO1000\WINNT4\DRIVERS\e1000nt4.sy_ copy /v ..\..\PRO1000\WINNT4\DRIVERS\e1000nt4.sy_ %dest%\DRIVERS
if exist ..\..\PRO100\WINNT4\DRIVERS\iansnt4n.sy_ copy /v ..\..\PRO100\WINNT4\DRIVERS\iansnt4n.sy_ %dest%\DRIVERS
if exist ..\..\PRO100\WINNT4\DRIVERS\iansnt4e.sy_ copy /v ..\..\PRO100\WINNT4\DRIVERS\iansnt4e.sy_ %dest%\DRIVERS
if exist ..\..\PRO100\WINNT4\DRIVERS\iansnt4.sy_ copy /v ..\..\PRO100\WINNT4\DRIVERS\iansnt4.sy_ %dest%\DRIVERS
if exist ..\..\PRO100\WINNT4\DRIVERS\MVFT.re_ copy /v ..\..\PRO100\WINNT4\DRIVERS\MVFT.re_ %dest%\DRIVERS

echo.
echo Base driver files have been copied to media or path. 
echo Advanced Networking Features must be installed from
echo a CD-ROM drive, or over the network after a connection
echo to your network file service is established.
echo.

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo.
echo.
echo Please remove the diskette and label it
echo Intel(R) PRO LAN Adapter Configuration and Microsoft Windows NT
echo Drivers (Release # from your CD) Disk 2
echo.
goto end



:ws0364gig
rem     *** Start of the Windows Server 2003 64 section Gigabit drivers ***
cls
echo.
echo This batch file will copy the Microsoft Windows Server 2003 64 and
echo Microsoft Windows XP 64 Gigabit driver files to %dest%
echo.
echo press CTRL-C and answer Y if this is NOT correct, otherwise
if "%_silent%" == "FALSE" pause

cls
echo.
echo Copying files to %dest%
echo.

copy /v ..\..\PRO1000\WS03XP64\e1000645.inf %dest%
if not exist %dest%\e1000645.inf goto NOCOPY
if exist ..\..\verfile.tic copy ..\..\verfile.tic %dest%

copy /v ..\..\PRO1000\WS03XP64\e1000msg.dll %dest%
copy /v ..\..\PRO1000\WS03XP64\e1000645.cat %dest%
copy /v ..\..\PRO1000\WS03XP64\e1000645.din %dest%
copy /v ..\..\PRO1000\WS03XP64\e1000645.sys %dest%
copy /v ..\..\PRO1000\WS03XP64\EtCoIn64.dll %dest%

rem common files 
copy /v ..\..\PRO1000\WS03XP64\intlnc64.dll %dest%
copy /v ..\..\PRO1000\WS03XP64\PROUnstl.exe %dest%


echo.
echo Base driver files have been copied to media or path. 
echo Advanced Networking Features must be installed from
echo a CD-ROM drive, or over the network after a connection
echo to your network file service is established.
echo.

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo PLEASE LABEL YOUR DISKETTE
echo Intel(R) PRO LAN Adapter Configuration and
echo Microsoft Windows Server 2003 64 and
echo Microsoft Windows XP 64 Gigabit Drivers (Release # from your CD)
echo.
goto end

:ws0364fe
rem     *** Start of the Windows Server 2003 64 section 10/100 drivers ***
cls
echo.
echo This batch file will copy the Microsoft Windows Server 2003 64 and
echo Microsoft Windows XP 64 10/100 driver files to %dest%
echo.
echo press CTRL-C and answer Y if this is NOT correct, otherwise
if "%_silent%" == "FALSE" pause

cls
echo.
echo Copying files to %dest%
echo.

copy /v ..\..\PRO100\WS03XP64\e100b645.inf %dest%
if not exist %dest%\e100b645.inf goto NOCOPY
if exist ..\..\verfile.tic copy ..\..\verfile.tic %dest%
copy /v ..\..\PRO100\WS03XP64\e100b645.cat %dest%
copy /v ..\..\PRO100\WS03XP64\e100b645.din %dest%
copy /v ..\..\PRO100\WS03XP64\e100b645.sys %dest%
copy /v ..\..\PRO100\WS03XP64\e100bmsg.dll %dest%

rem common files 
copy /v ..\..\PRO100\WS03XP64\intlnc64.dll %dest%
copy /v ..\..\PRO100\WS03XP64\PROUnstl.exe %dest%


echo.
echo Base driver files have been copied to media or path. 
echo Advanced Networking Features must be installed from
echo a CD-ROM drive, or over the network after a connection
echo to your network file service is established.
echo.

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo PLEASE LABEL YOUR DISKETTE
echo Intel(R) PRO LAN Adapter Configuration and
echo Microsoft Windows Server 2003 64 and
echo Microsoft Windows XP 64 10/100 Drivers (Release # from your CD)
echo.
goto end

:ws0332gig
rem     *** Start of the Windows Server 2003 32 section Gigabit drivers ***
cls
echo.
echo This batch file will copy the Microsoft Windows Server 2003 32 and
echo Microsoft Windows XP 32 Gigabit driver files to %dest%
echo.
echo press CTRL-C and answer Y if this is NOT correct, otherwise
if "%_silent%" == "FALSE" pause

cls
echo.
echo Copying files to %dest%
echo.

copy /v ..\..\PRO1000\WS03XP2K\e1000325.inf %dest%
if not exist %dest%\e1000325.inf goto NOCOPY
if exist ..\..\verfile.tic copy ..\..\verfile.tic %dest%
rem Gigabit specific files
if exist ..\..\PRO1000\WS03XP2K\E101D325.INF copy ..\..\PRO1000\WS03XP2K\E101D325.INF %dest%
if exist ..\..\PRO1000\WS03XP2K\E101D325.CAT copy ..\..\PRO1000\WS03XP2K\E101D325.CAT %dest%
copy /v ..\..\PRO1000\WS03XP2K\e1000msg.dll %dest%
copy /v ..\..\PRO1000\WS03XP2K\e1000325.cat %dest%
copy /v ..\..\PRO1000\WS03XP2K\e1000325.din %dest%
copy /v ..\..\PRO1000\WS03XP2K\E1000325.sys %dest%
copy /v ..\..\PRO1000\WS03XP2K\EtCoInst.dll %dest% 

rem common files 
copy /v ..\..\PRO1000\WS03XP2K\AsfStup.dll %dest%
copy /v ..\..\PRO1000\WS03XP2K\intelnic.dll %dest%
copy /v ..\..\PRO1000\WS03XP2K\PROUnstl.exe %dest%


echo.
echo Base driver files have been copied to media or path. 
echo Advanced Networking Features must be installed from
echo a CD-ROM drive, or over the network after a connection
echo to your network file service is established.
echo.

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo PLEASE LABEL YOUR DISKETTE
echo Intel(R) PRO LAN Adapter Configuration and
echo Microsoft Windows Server 2003 32 and
echo Microsoft Windows XP 32 Gigabit Drivers (Release # from your CD)
echo.
goto end

:ws0332fe
rem     *** Start of the Windows Server 2003 section 10/100 drivers ***
cls
echo.
echo This batch file will copy the Microsoft Windows Server 2003 32 and
echo Microsoft Windows XP 32 10/100 driver files to %dest%
echo.
echo press CTRL-C and answer Y if this is NOT correct, otherwise
if "%_silent%" == "FALSE" pause

cls
echo.
echo Copying files to %dest%
echo.

copy /v ..\..\PRO100\WS03XP2K\e100b325.inf %dest%
if not exist %dest%\e100b325.inf goto NOCOPY
if exist ..\..\verfile.tic copy ..\..\verfile.tic %dest%
rem 10/100 specific files
copy /v ..\..\PRO100\WS03XP2K\e100b325.cat %dest%
copy /v ..\..\PRO100\WS03XP2K\e100b325.din %dest%
copy /v ..\..\PRO100\WS03XP2K\e100b325.sys %dest%
copy /v ..\..\PRO100\WS03XP2K\e100bmsg.dll %dest%

rem common files 
copy /v ..\..\PRO100\WS03XP2K\AsfStup.dll %dest%
copy /v ..\..\PRO100\WS03XP2K\intelnic.dll %dest%
copy /v ..\..\PRO100\WS03XP2K\PROUnstl.exe %dest%


echo.
echo Base driver files have been copied to media or path. 
echo Advanced Networking Features must be installed from
echo a CD-ROM drive, or over the network after a connection
echo to your network file service is established.
echo.

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo PLEASE LABEL YOUR DISKETTE
echo Intel(R) PRO LAN Adapter Configuration and
echo Microsoft Windows Server 2003 32 and
echo Microsoft Windows XP 32 10/100 Drivers (Release # from your CD)
echo.
goto end

:w2k_fe
rem     *** Start of the Windows 2000 section ***
rem Echo what we are about to do
cls
echo.
echo This batch file will copy the Microsoft Windows 2000 driver
echo files to %dest%
echo.
echo press CTRL-C and answer Y if this is NOT correct, otherwise
if "%_silent%" == "FALSE" pause

cls
echo.
echo Copying files to %dest%
echo.

copy /v ..\..\PRO100\WS03XP2K\e100b325.inf %dest%
if not exist %dest%\e100b325.inf goto NOCOPY
if exist ..\..\verfile.tic copy ..\..\verfile.tic %dest%
rem 10/100 specific files
copy /v ..\..\PRO100\WS03XP2K\e100b325.cat %dest%
copy /v ..\..\PRO100\WS03XP2K\e100bmsg.dll %dest%
copy /v ..\..\PRO100\WS03XP2K\e100bnt5.din %dest%
copy /v ..\..\PRO100\WS03XP2K\e100bnt5.sys %dest%

rem common files 
copy /v ..\..\PRO100\WS03XP2K\AsfStup.dll %dest%
copy /v ..\..\PRO100\WS03XP2K\intelnic.dll %dest%
copy /v ..\..\PRO100\WS03XP2K\PROUnstl.exe %dest%

echo. 
echo Base driver files have been copied to media or path. 
echo Advanced Networking Features must be installed from
echo a CD-ROM drive, or over the network after a connection
echo to your network file service is established.
echo.

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo PLEASE LABEL YOUR DISKETTE
echo Intel(R) PRO LAN Adapter Configuration and
echo Microsoft Windows 2000 10/100 Drivers (Release # from your CD)
echo.
goto end

:w2k_gig
rem     *** Start of the Windows 2000 section ***
rem Echo what we are about to do
cls
echo.
echo This batch file will copy the Microsoft Windows 2000 driver
echo files to %dest%
echo.
echo press CTRL-C and answer Y if this is NOT correct, otherwise
if "%_silent%" == "FALSE" pause

cls
echo.
echo Copying files to %dest%
echo.

copy /v ..\..\PRO1000\WS03XP2K\e1000325.inf %dest%
if not exist %dest%\e1000325.inf goto NOCOPY
if exist ..\..\verfile.tic copy ..\..\verfile.tic %dest%
rem Gigabit specific files
if exist ..\..\PRO1000\WS03XP2K\E101DNT5.INF copy ..\..\PRO1000\WS03XP2K\E101DNT5.INF %dest%
if exist ..\..\PRO1000\WS03XP2K\E101DNT5.CAT copy ..\..\PRO1000\WS03XP2K\E101DNT5.CAT %dest%
copy /v ..\..\PRO1000\WS03XP2K\e1000325.cat %dest%
copy /v ..\..\PRO1000\WS03XP2K\e1000msg.dll %dest%
copy /v ..\..\PRO1000\WS03XP2K\e1000nt5.din %dest%
copy /v ..\..\PRO1000\WS03XP2K\E1000NT5.SYS %dest%
copy /v ..\..\PRO1000\WS03XP2K\EtCoInst.dll %dest%

rem common files 
copy /v ..\..\PRO1000\WS03XP2K\AsfStup.dll %dest%
copy /v ..\..\PRO1000\WS03XP2K\intelnic.dll %dest%
copy /v ..\..\PRO1000\WS03XP2K\PROUnstl.exe %dest%

echo. 
echo Base driver files have been copied to media or path. 
echo Advanced Networking Features must be installed from
echo a CD-ROM drive, or over the network after a connection
echo to your network file service is established.
echo.

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo PLEASE LABEL YOUR DISKETTE
echo Intel(R) PRO LAN Adapter Configuration and
echo Microsoft Windows 2000 Gigabit Drivers (Release # from your CD)
echo.
goto end

:w9x
rem     *** Start of the Windows 9x section ***
rem The drivers copied are only valid for Windows 98SE and Windows Me
rem Echo what we are about to do
cls
echo.
echo.
echo This batch file will copy the driver files for Microsoft
echo Windows 95/98/Me operating systems to %dest%
echo.
echo press CTRL-C and answer Y if this is NOT correct,
echo otherwise,
if "%_silent%" == "FALSE" pause

cls
echo.
echo Copying files to %dest%
echo.

md %dest%\WIN95
md %dest%\WIN_98ME

:testcopy
copy /v ..\..\PRO100\WIN95\NET5579X.INF %dest%\WIN95
if not exist %dest%\WIN95\NET5579X.INF goto NOCOPY
if exist ..\..\VERFILE.TIC copy ..\..\VERFILE.TIC %dest%
rem Windows 95 specific files
copy /v ..\..\PRO100\WIN95\NET55A9X.INF %dest%\WIN95
copy /v ..\..\PRO100\WIN95\NET82557.DIN %dest%\WIN95
copy /v ..\..\PRO100\WIN95\8255INDI.DLL %dest%\WIN95
copy /v ..\..\PRO100\WIN95\WOL558.VXD %dest%\WIN95
copy /v ..\..\PRO100\WIN95\E100B.SYS %dest%\WIN95
copy /v ..\..\PRO100\WIN95\E100BNT.SYS %dest%\WIN95
copy /v ..\..\PRO100\WIN95\E100BNT5.SYS %dest%\WIN95
copy /v ..\..\PRO100\WIN95\E100BODI.COM %dest%\WIN95
copy /v ..\..\PRO100\WIN95\8255XDEL.EXE %dest%\WIN95

rem Windows 98/Me specific files - 10/100
copy /v ..\..\PRO100\WIN_98ME\E100B9X.INF %dest%\WIN_98ME
copy /v ..\..\PRO100\WIN_98ME\E100B9X.CAT %dest%\WIN_98ME
copy /v ..\..\PRO100\WIN_98ME\E100B9XA.INF %dest%\WIN_98ME
copy /v ..\..\PRO100\WIN_98ME\E100B9XA.CAT %dest%\WIN_98ME
copy /v ..\..\PRO100\WIN_98ME\E100B9X.DIN %dest%\WIN_98ME
copy /v ..\..\PRO100\WIN_98ME\E100BNT.SYS %dest%\WIN_98ME
copy /v ..\..\PRO100\WIN_98ME\E100BNT5.SYS %dest%\WIN_98ME
copy /v ..\..\PRO100\WIN_98ME\8255INDI.DLL %dest%\WIN_98ME
copy /v ..\..\PRO100\WIN_98ME\WOL558.VXD %dest%\WIN_98ME

rem Windows 98/Me specific files - Gigabit
copy /v ..\..\PRO1000\WIN_98ME\E1000W9X.INF %dest%\WIN_98ME
copy /v ..\..\PRO1000\WIN_98ME\E1000W9X.CAT %dest%\WIN_98ME
copy /v ..\..\PRO1000\WIN_98ME\E1000W9X.DIN %dest%\WIN_98ME
copy /v ..\..\PRO1000\WIN_98ME\E1000W9X.SYS %dest%\WIN_98ME

rem common files
copy /v ..\..\PRO100\WIN_98ME\8255XDEL.EXE %dest%\WIN_98ME

echo. 
echo Base driver files copied to diskette. 
echo Advanced Networking Features must be installed from
echo a CD-ROM drive, or over the network after a connection
echo to your network file service is established.
echo.

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo PLEASE LABEL YOUR DISKETTE
echo Intel(R) PRO LAN Adapter Configuration and
echo Microsoft Windows Drivers (Release # from your CD)
echo.
goto end

:nw
rem     *** Start of the NetWare section ***
echo.
rem Echo what we are about to do
cls
echo.
echo This batch file will copy the NetWare server and client
echo driver files to %dest%
echo press CTRL-C and answer Y if this is NOT correct,
echo otherwise,
if "%_silent%" == "FALSE" pause

cls
echo.
echo Copying files to %dest%
echo.

:TESTCOPY
rem MAKE DIRECTORIES FIRST
md %dest%\NWSERVER
md %dest%\DOS
md %dest%\DOS\E1000
copy ..\..\PRO1000\NWSERVER\CE1000.LAN %dest%\NWSERVER
if not exist %dest%\NWSERVER\CE1000.LAN goto nocopy
if exist ..\..\verfile.tic copy ..\..\verfile.tic %dest%

rem Gigabit Drivers
copy /v ..\..\PRO1000\NWSERVER\CE1000.LDI %dest%\NWSERVER
copy /v ..\..\PRO1000\DOS\IPXODI.COM %dest%\DOS
copy /v ..\..\PRO1000\DOS\LSL.COM %dest%\DOS
copy /v ..\..\PRO1000\DOS\E1000ODI.COM %dest%\DOS\E1000
copy /v ..\..\PRO1000\DOS\NET.CFG %dest%\DOS\E1000

rem 10/100 Drivers
copy /v ..\..\PRO100\NWSERVER\*.* %dest%\NWSERVER
copy /v ..\..\PRO100\DOS\NET.CFG %dest%\DOS
copy /v ..\..\PRO100\DOS\DRIVERS.DOS %dest%\DOS
copy /v ..\..\PRO100\DOS\E100BODI.INS %dest%\DOS
copy /v ..\..\PRO100\DOS\E100BODI.COM %dest%\DOS

rem ians
copy /v ..\..\PRO1000\NWSERVER\ians.lan %dest%\NWSERVER
copy /v ..\..\PRO1000\NWSERVER\ians.ldi %dest%\NWSERVER

rem Other files
if exist ..\..\README.TXT copy ..\..\README.TXT %dest%
if exist ..\..\WIREDPCI.TXT copy ..\..\WIREDPCI.TXT %dest%

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo.
echo PLEASE LABEL YOUR DISKETTE
echo Intel(R) PRO LAN Adapter Configuration
echo and Novell Drivers (Release # from your CD)
echo.
goto END

:dos
rem     *** Start of the DOS and OS2 section ***
rem Echo what we are about to do
cls
echo.
echo This batch file will copy the driver files for Microsoft
echo DOS and IBM OS/2 operating systems
echo to %dest%
echo press CTRL-C and answer Y if this is NOT correct,
echo otherwise,
if "%_silent%" == "FALSE" pause

cls
echo.
echo Copying files to %dest%
echo.

:testcopy
rem Make directories first
md %dest%\PRO100
md %dest%\PRO1000
md %dest%\PRO100\DOS
md %dest%\PRO100\OS2
md %dest%\PRO1000\DOS
md %dest%\PRO1000\OS2

copy /v ..\..\PRO1000\DOS\E1000.DOS %dest%\PRO1000\DOS
if not exist %dest%\PRO1000\DOS\E1000.DOS goto NOCOPY
if exist ..\..\verfile.tic copy /v ..\..\verfile.tic %dest%
if exist ..\..\WIREDPCI.TXT copy /v ..\..\WIREDPCI.TXT %dest%
if exist ..\..\README.TXT copy /v ..\..\README.TXT %dest%
copy /v ..\..\PRO100\DOS\*.* %dest%\PRO100\DOS
copy /v ..\..\PRO100\OS2\*.* %dest%\PRO100\OS2
copy /v ..\..\PRO1000\DOS\*.* %dest%\PRO1000\DOS
copy /v ..\..\PRO1000\OS2\*.* %dest%\PRO1000\OS2

if NOT "%gui%" == "" set gui=done
if "%_mdisk_floppy%" == "FALSE" goto end
echo.
echo PLEASE LABEL YOUR DISKETTE
echo Intel(R) PRO LAN Adapter Configuration
echo and DOS - OS/2 Drivers (Release # from your CD)
echo.
goto END

:env_bad
set env_chk=
cls
echo ERROR: Your computer does not have sufficient environment space to
echo run this batch file. Please increase the available environment space
echo and run this batch file again. To increase the avaiable environment
echo space, please do the following;
echo.
echo                                  DOS
echo If you are running DOS, edit the CONFIG.SYS file and find the statement
echo COMMAND=C:\(PATH)\COMMAND.COM /e:(number)
echo where (path) is the directory path to your COMMAND.COM file and (number)
echo is a numerical value. Increase the numerical value by at least 32.
echo If this line does not exist, add the following line;
echo COMMAND=C:\COMMAND.COM /E:512
echo Reboot the computer before running this batch file again.
echo.
echo                        Windows 2000 and Windows NT
echo Click Start, then Run, then enter "CMD /E:4096" (without the quotes) to
echo open a DOS window, and then re-run this batch file in that window.
echo.
echo                    Windows 95, Windows 98 and Windows ME
echo Click Start, then Run, then enter "COMMAND /E:4096" (without the quotes) to
echo open a DOS window, and then re-run this batch file in that window.
goto end

:WRONGDIR
if NOT "%gui%" == "" set gui=wrongdir
if NOT "%gui%" == "" goto end
cls
echo You must run this utility from the \MAKEDISK directory.
goto usage

:NOCOPY
if NOT "%gui%" == "" set gui=nocopy
if NOT "%gui%" == "" goto end
cls
echo.
echo Can not copy to %dest%.
echo Please check your syntax and try again
goto usage

:usage
echo.
echo usage rules:
echo MAKEDISK [operating system] [destination (optional)] [silent (optional)]
echo.
echo where [operating system] is the OS family you are creating the diskette for
echo WS0332EFE  = Microsoft Windows Server 2003 for 64-bit Extended Systems 10/100 based solutions
echo WS0332EGIG = Microsoft Windows Server 2003 for 64-bit Extended Systems Gigabit based solutions
echo WS0364FE  = Microsoft Windows Server 2003/XP 64 10/100 based solutions
echo WS0364GIG = Microsoft Windows Server 2003/XP 64 Gigabit based solutions
echo WS0332FE  = Microsoft Windows Server 2003/XP 32 10/100 based solutions
echo WS0332GIG = Microsoft Windows Server 2003/XP 32 Gigabit based solutions
echo W2KFE     = Microsoft Windows 2000 10/100 based solutions
echo W2KGIG    = Microsoft Windows 2000 Gigabit based solutions
echo NT        = Microsoft Windows NT
rem echo NT4HOTADD = Microsoft Windows NT for Hot Add
echo W9X       = Microsoft Windows 95/98/Me
echo NW        = Novell NetWare servers and clients
echo DOS       = Microsoft DOS and IBM OS/2
rem echo Modem    = Modem drivers for the PRO/100 Mobile Adapter (All Microsoft OS)
echo.
echo and where [destination] is the drive letter and path (such as A:)
echo and where [silent] = run in silent mode (does not pause for user input)
echo Do not add a trailing backslash (\) to the destination path.
echo [destination] (will be A: if none specified) is expected to be formatted media.
echo This utility MUST be run from the \MAKEDISK directory.
echo.
pause 
echo EXAMPLE:

echo To create a Windows NT install diskette in A: for an Intel(R) PRO LAN
echo  Adapter Connection, from the MAKEDISK directory run: MAKEDISK NT    
echo.
pause
goto END
										   
:END
set dest=
set mode=
set _silent=
set _mdisk_floppy=
if "%gui%" == "" goto CLI_EXIT

REM FINISH_ALL
if NOT "%gui%" == "done" goto GUI_INSERTSECOND
echo 0 > %TEMP%\makediskoutput.txt
cls
exit 0

:GUI_INSERTSECOND
if NOT "%gui%" == "insertsecond" goto GUI_INSERTSECOND
echo 1 > %TEMP%\makediskoutput.txt
cls
exit 1

:GUI_NOCOPY
if NOT "%gui%" == "nocopy" goto GUI_WRONGDIR
echo 2 > %TEMP%\makediskoutput.txt
cls
exit 2

:GUI_WRONGDIR
if NOT "%gui%" == "wrongdir" goto GUI_GENFAILURE
echo 4 > %TEMP%\makediskoutput.txt
cls
exit 4

:GUI_GENFAILURE
echo 9 > %TEMP%\makediskoutput.txt
cls
exit 9

:CLI_EXIT


