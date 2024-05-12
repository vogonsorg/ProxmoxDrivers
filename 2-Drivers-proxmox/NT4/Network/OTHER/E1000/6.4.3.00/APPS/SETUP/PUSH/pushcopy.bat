@echo off
rem *******************************************************************************
rem Make sure we are in the right directory
rem *******************************************************************************
if NOT exist .\PUSHCOPY.BAT GOTO WRONGDIR


rem *******************************************************************************
rem %1 = Destination Path
rem %2 = W98 or WMe or W2K or NT
rem *******************************************************************************

if "%2"=="w98" goto Win9x
if "%2"=="W98" goto Win9x
if "%2"=="wme" goto Win9x
if "%2"=="WME" goto Win9x
if "%2"=="w2k" goto Win2K
if "%2"=="W2K" goto Win2K
if "%2"=="xp"  goto WinXP
if "%2"=="XP"  goto WinXP
if "%2"=="nt"  goto WinNT
if "%2"=="NT"  goto WinNT
if "%2"=="ws03"  goto WS03
if "%2"=="WS03"  goto WS03
if "%2"=="ws03_32e"  goto WS32E
if "%2"=="WS03_32E"  goto WS32E

goto Usage

rem *******************************************************************************
rem 	WIN9X file copies
rem *******************************************************************************
:Win9x

rem *****************************************************
rem copy the base driver files for win9x
rem *****************************************************

rem 10/100 specific files
copy ..\..\..\PRO100\WIN_98ME\e100b9x.inf %1
copy ..\..\..\PRO100\WIN_98ME\e100b9xa.inf %1
copy ..\..\..\PRO100\WIN_98ME\e100b9x.din %1
copy ..\..\..\PRO100\WIN_98ME\E100BNT.SYS %1
copy ..\..\..\PRO100\WIN_98ME\E100BNT5.SYS %1
copy ..\..\..\PRO100\WIN_98ME\8255iNDI.DLL %1
copy ..\..\..\PRO100\WIN_98ME\8255xdel.exe %1
copy ..\..\..\PRO100\WIN_98ME\WOL558.vxd %1

rem Gigabit specific files
copy ..\..\..\PRO1000\WIN_98ME\E1000W9x.INF %1
copy ..\..\..\PRO1000\WIN_98ME\E1000W9x.DIN %1
copy ..\..\..\PRO1000\WIN_98ME\E1000W9x.SYS %1


copy ..\..\TOOLS\DIAGS.EXE %1



rem *******************************************************************************
rem Copy MSBATCH.INF and CUSTOM.INF
rem *******************************************************************************
copy win9x\*.inf            %1

rem *******************************************************************************
rem Copy the ANS files
rem *******************************************************************************

if NOT Exist ..\..\PROSet\WN98SEME\iansw98.sys goto NO9XANS
copy ..\..\PROSet\WN98SEME\iansw98.sys  %1
copy ..\..\PROSet\WN98SEME\iansw98.cat  %1
:NO9XANS

rem *******************************************************************************
rem Copy the NDIS2 DOS driver so network connectivity can be re-established if necessary
rem *******************************************************************************
copy ..\..\..\PRO100\dos\e100bodi.com       %1

rem *******************************************************************************
rem Copy the PROSet files
rem *******************************************************************************
copy ..\..\PROSet\WN98SEME\Proset.exe             %1
copy ..\..\PROSet\WN98SEME\Proset.msi             %1
copy ..\..\PROSet\WN98SEME\instmsia.exe            %1

goto end

rem *******************************************************************************
rem 	WIN2K file copies
rem *******************************************************************************

:Win2K
echo *** Win2K file copy

rem *******************************************************************************
rem Create the OEM driver directory structure
rem *******************************************************************************
md %1\$oem$
md %1\$oem$\$$
md %1\$oem$\$$\system32
md %1\$oem$\$1
md %1\$oem$\$1\drivers
md %1\$oem$\$1\drivers\net
md %1\$oem$\$1\drivers\net\INTEL

rem *************************************************************************
rem  Copy the base driver files
rem *************************************************************************

rem 10/100 specific files
copy ..\..\..\PRO100\WS03XP2K\e100b325.cat %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100b325.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100bnt5.din %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100bnt5.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100bmsg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\intelnic.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\PROunstl.exe %1\$OEM$\$1\DRIVERS\NET\INTEL

rem Gigabit specific files
copy ..\..\..\PRO1000\WS03XP2K\e1000325.cat %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000325.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000nt5.din %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000nt5.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000msg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\ETCoinst.dll %1\$OEM$\$1\DRIVERS\NET\INTEL

if NOT exist ..\..\..\PRO1000\WS03XP2K\ASFSTUP.DLL GOTO 2K_ASF

copy ..\..\..\PRO1000\WS03XP2K\ASFSTUP.dll %1\$OEM$\$1\DRIVERS\NET\INTEL

:2K_ASF

if NOT exist ..\..\..\PRO1000\WS03XP2K\e101dnt5.inf GOTO 2K_E101D

copy ..\..\..\PRO1000\WS03XP2K\e101dnt5.inf %1\$OEM$\$1\DRIVERS\NET\INTEL

:2K_E101D

rem *******************************************************************************
rem Copy the sample UNATTEND.TXT
rem *******************************************************************************
copy win2k\*.*               %1\$oem$\$1\drivers\net\INTEL

rem *******************************************************************************
rem Copy the ANS files
rem *******************************************************************************
copy ..\..\PROSet\WS03XP2K\ansm2kxp.inf         %1\$oem$\$1\drivers\net\INTEL
copy ..\..\PROSet\WS03XP2K\ansp2kxp.inf         %1\$oem$\$1\drivers\net\INTEL
copy ..\..\PROSet\WS03XP2K\iansmsg.dll         	%1\$oem$\$1\drivers\net\INTEL
copy ..\..\PROSet\WS03XP2K\iansw2k.sys         	%1\$oem$\$1\drivers\net\INTEL
copy ..\..\PROSet\WS03XP2K\ians2kxp.cat 	%1\$OEM$\$1\drivers\net\INTEL


rem *******************************************************************************
rem Copy the PROSetII files
rem *******************************************************************************
copy ..\..\PROSet\WS03XP2K\proset.msi %1\$oem$\$1\drivers\net\INTEL
copy ..\..\PROSet\WS03XP2K\proset.exe %1\$oem$\$1\drivers\net\INTEL
copy ..\..\PROSet\WS03XP2K\s8023Dev.reg %1\$oem$\$1\drivers\net\INTEL
copy ..\..\PROSet\WS03XP2K\*.MST %1\$oem$\$1\drivers\net\INTEL
copy ..\..\PROSet\WS03XP2K\*.CAB %1\$oem$\$1\drivers\net\INTEL

if exist ..\..\PROSet\WS03XP2K\OEMVER.REG GOTO 2K_OEMVER

goto end
:2K_OEMVER
copy ..\..\PROSet\WS03XP2K\OEMVER.REG %1\$oem$\$1\drivers\net\INTEL

Goto end

rem *******************************************************************************
rem 	WINXP file copies
rem *******************************************************************************
:WinXP
echo *** WinXP file copy

rem *******************************************************************************
rem Create the OEM driver directory structure
rem *******************************************************************************
md %1\$oem$
md %1\$oem$\$$
md %1\$oem$\$$\system32
md %1\$oem$\$1
md %1\$oem$\$1\drivers
md %1\$oem$\$1\drivers\net
md %1\$oem$\$1\drivers\net\INTEL


REM **********************************************************************
REM  COPY Base driver files for Windows XP
REM **********************************************************************

copy ..\..\..\PRO100\WS03XP2K\e100b325.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100b325.din %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100b325.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100b325.cat %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100bmsg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\intelnic.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\prounstl.exe %1\$OEM$\$1\DRIVERS\NET\INTEL


rem Gigabit specific files (IA 32)
copy ..\..\..\PRO1000\WS03XP2K\e1000325.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000325.din %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000325.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000325.cat %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000msg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\ETCoinst.dll %1\$OEM$\$1\DRIVERS\NET\INTEL

if NOT exist ..\..\..\PRO1000\WS03XP2K\ASFSTUP.DLL GOTO XP_ASF

copy ..\..\..\PRO1000\WS03XP2K\ASFSTUP.dll %1\$OEM$\$1\DRIVERS\NET\INTEL

:XP_ASF

if NOT exist ..\..\..\PRO1000\WS03XP2K\e101d325.inf goto XP_E101D

copy ..\..\..\PRO1000\WS03XP2K\e101d325.inf %1\$OEM$\$1\DRIVERS\NET\INTEL

:XP_E101D

rem *******************************************************************************
rem Copy the sample UNATTEND.TXT
rem *******************************************************************************
copy WS03XP32\Unattend.txt               %1\$oem$\$1\drivers\net\INTEL
copy WS03XP32\Pushxp.txt               %1\$oem$\$1\drivers\net\INTEL

rem *******************************************************************************
rem Copy the ANS and PROSet II files
rem *******************************************************************************

copy ..\..\PROSet\WS03XP2K\Ansm2kXp.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\Ansp2kXp.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\iansmsg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\ianswxp.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\ians2kxp.cat %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\PROSet.exe %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\PROSet.msi %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\s8023Dev.reg %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\*.MST %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\*.CAB %1\$OEM$\$1\DRIVERS\NET\INTEL

if exist ..\..\PROSet\WS03XP2K\OEMVER.REG GOTO XP_OEMVER

goto end

:XP_OEMVER
copy ..\..\PROSet\WS03XP2K\OEMVER.REG %1\$OEM$\$1\DRIVERS\NET\INTEL

Goto end


rem *******************************************************************************
rem 	WINDOWS SERVER 2003 file copies
rem *******************************************************************************
:WS03
echo *** Windows Server 2003 file copy

rem *******************************************************************************
rem Create the OEM driver directory structure
rem *******************************************************************************
md %1\$oem$
md %1\$oem$\$$
md %1\$oem$\$$\system32
md %1\$oem$\$1
md %1\$oem$\$1\drivers
md %1\$oem$\$1\drivers\net
md %1\$oem$\$1\drivers\net\INTEL


REM **********************************************************************
REM  COPY Base driver files for Windows Server 2003
REM **********************************************************************

copy ..\..\..\PRO100\WS03XP2K\e100b325.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100b325.din %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100b325.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100b325.cat %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\e100bmsg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\intelnic.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03XP2K\prounstl.exe %1\$OEM$\$1\DRIVERS\NET\INTEL


rem Gigabit specific files (IA 32)
copy ..\..\..\PRO1000\WS03XP2K\e1000325.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000325.din %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000325.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000325.cat %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\e1000msg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03XP2K\ETCoinst.dll %1\$OEM$\$1\DRIVERS\NET\INTEL

if NOT exist ..\..\..\PRO1000\WS03XP2K\ASFSTUP.DLL GOTO W3_ASF

copy ..\..\..\PRO1000\WS03XP2K\ASFSTUP.dll %1\$OEM$\$1\DRIVERS\NET\INTEL

:W3_ASF

if NOT exist ..\..\..\PRO1000\WS03XP2K\e101d325.inf goto W3_E101D

copy ..\..\..\PRO1000\WS03XP2K\e101d325.inf %1\$OEM$\$1\DRIVERS\NET\INTEL

:W3_E101D

rem *******************************************************************************
rem Copy the sample UNATTEND.TXT
rem *******************************************************************************
copy WS03XP32\Unattend.txt               %1\$oem$\$1\drivers\net\INTEL
copy WS03XP32\PushWs3.txt               %1\$oem$\$1\drivers\net\INTEL


rem *******************************************************************************
rem Copy the ANS and PROSet II files
rem *******************************************************************************

copy ..\..\PROSet\WS03XP2K\Ansm2kXp.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\Ansp2kXp.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\iansmsg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\ianswxp.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\ians2kxp.cat %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\PROSet.exe %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\PROSet.msi %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\s8023Dev.reg %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\*.MST %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\PROSet\WS03XP2K\*.CAB %1\$OEM$\$1\DRIVERS\NET\INTEL

if exist ..\..\PROSet\WS03XP2K\OEMVER.REG GOTO WS_OEMVER

goto end

:WS_OEMVER
copy ..\..\PROSet\WS03XP2K\OEMVER.REG %1\$OEM$\$1\DRIVERS\NET\INTEL

Goto end


rem *******************************************************************************
rem 	WINDOWS SERVER 2003  IA32E file copies
rem *******************************************************************************
:WS32E
echo *** Windows Server 2003 IA32E file copy

rem *******************************************************************************
rem Create the OEM driver directory structure
rem *******************************************************************************
md %1\$oem$
md %1\$oem$\$$
md %1\$oem$\$$\system32
md %1\$oem$\$1
md %1\$oem$\$1\drivers
md %1\$oem$\$1\drivers\net
md %1\$oem$\$1\drivers\net\INTEL


REM **********************************************************************
REM  COPY Base driver files for Windows Server 2003
REM **********************************************************************

copy ..\..\..\PRO100\WS03_32E\eFE5b32E.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03_32E\eFE5b32E.din %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03_32E\eFE5b32E.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03_32E\e100bmsg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03_32E\intnc32e.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO100\WS03_32E\prounstl.exe %1\$OEM$\$1\DRIVERS\NET\INTEL

if NOT exist ..\..\..\PRO100\WS03_32E\eFE5b32E.cat GOTO W3E_CAT1

copy ..\..\..\PRO100\WS03_32E\eFE5b32E.cat %1\$OEM$\$1\DRIVERS\NET\INTEL

:W3E_CAT1

rem Gigabit specific files (IA 32e)
copy ..\..\..\PRO1000\WS03_32E\e1G5132e.inf %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03_32E\e1G5132e.din %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03_32E\e1G5132e.sys %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03_32E\e1000msg.dll %1\$OEM$\$1\DRIVERS\NET\INTEL
copy ..\..\..\PRO1000\WS03_32E\EtCol32e.dll %1\$OEM$\$1\DRIVERS\NET\INTEL

if NOT exist ..\..\..\PRO1000\WS03_32E\e1G5132e.cat GOTO W3E_CAT2

copy ..\..\..\PRO1000\WS03_32E\e1G5132e.cat %1\$OEM$\$1\DRIVERS\NET\INTEL

:W3E_CAT2

if NOT exist ..\..\..\PRO1000\WS03_32E\ASFSTUP.DLL GOTO W3E_ASF

copy ..\..\..\PRO1000\WS03_32E\ASFSTUP.dll %1\$OEM$\$1\DRIVERS\NET\INTEL

:W3E_ASF

if NOT exist ..\..\..\PRO1000\WS03_32E\e101d325.inf goto W3E_E101D

copy ..\..\..\PRO1000\WS03_32E\e101d325.inf %1\$OEM$\$1\DRIVERS\NET\INTEL

:W3E_E101D

rem *******************************************************************************
rem Copy the sample UNATTEND.TXT
rem *******************************************************************************
copy WS03_32E\Unattend.txt               %1\$oem$\$1\drivers\net\INTEL
copy WS03_32E\PushWs3e.txt               %1\$oem$\$1\drivers\net\INTEL


rem *******************************************************************************
rem Copy the PROSet/NCS files
rem *******************************************************************************

copy ..\..\PROSet\WS03_32E\*.* %1\$OEM$\$1\DRIVERS\NET\INTEL

Goto end


rem *******************************************************************************
rem 	WINNT file copies
rem *******************************************************************************
:WinNT
echo *** WinNT file copy


rem *******************************************************************************
rem Create the OEM driver directory structure
rem *******************************************************************************
md %1\$OEM$
md %1\$OEM$\Net
md %1\$OEM$\Net\PRO100
md %1\$OEM$\Net\PRO100\WINNT4
md %1\$OEM$\Net\PRO1000
md %1\$OEM$\Net\PRO1000\WINNT4
md %1\$OEM$\Net\APPS
md %1\$OEM$\Net\APPS\PROSET
md %1\$OEM$\Net\APPS\PROSET\WINNT4





xcopy /s ..\..\..\PRO100\WINNT4\*.* %1\$OEM$\Net\PRO100\WINNT4
xcopy /s ..\..\..\PRO1000\WINNT4\*.* %1\$OEM$\Net\PRO1000\WINNT4
xcopy /s ..\..\..\APPS\PROSET\WINNT4\*.* %1\$OEM$\Net\APPS\PROSET\WINNT4
copy Winnt\*.* %1\$OEM$\Net

goto end

:WRONGDIR
echo.
echo.
echo PUSHCOPY must be run from the \APPS\SETUP\PUSH directory on the CD or 
echo CD image to work properly.  
echo.
echo  Please change directories to the \APPS\SETUP\PUSH directory before running PUSHCOPY.
echo.
echo.


:Usage
echo.
echo usage rules;
echo pushcopy [Destination Path] [OS]
echo where [destination] is the drive letter and path (such as Z:)
echo       Do not add a trailing backslash (\) to the destination path. 
echo [OS] is the OS family
echo W98   = Microsoft Windows 98 and Windows 98SE*
echo WMe   = Microsoft Windows ME*
echo W2K   = Microsoft Windows* 2000
echo NT    = Microsoft Windows NT*
echo XP    = Microsoft Windows XP*
echo WS03  = Microsoft Windows Server 2003*
echo WS03_32E  = Microsoft Windows Server 2003 for 64-bit Extended Systems*
echo.

:end
