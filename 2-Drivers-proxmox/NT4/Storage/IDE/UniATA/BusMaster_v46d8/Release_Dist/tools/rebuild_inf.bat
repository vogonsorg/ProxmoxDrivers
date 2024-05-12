rem @echo off
echo rebuilding .INF files
build_inf.exe uata_2k.in_ > uata_2k.inf

set SET_BAT=$set_root$.bat

copy $set_root$.ba_ $set_root$.bat >nul 2>nul
.\build_inf.exe --ver >> %SET_BAT%
call %SET_BAT% ver_dot
del %SET_BAT%

copy $set_root$.ba_ $set_root$.bat >nul 2>nul
.\build_inf.exe --timestamp >> %SET_BAT%
call %SET_BAT% ver_ts
del %SET_BAT%

.\build_inf.exe --html > ..\doc\devices.html

srchrep -src "%%BUILD_TS%%" -dest "%ver_ts%"      uata_2k.inf > nul
srchrep -src "%%DRIVER_VER%%" -dest "%ver_dot%"   uata_2k.inf > nul

copy uata_2k.in_ uata_nt4.inf
srchrep -src ";DEVLIST" -dest "%%DeviceDesc%%"  uata_nt4.inf > nul
srchrep -src ";DEVNAMELIST" -dest "DeviceDesc"  uata_nt4.inf > nul
srchrep -src "%%EDITION%%" -dest " (Win NT4)"   uata_nt4.inf > nul
srchrep -src "uata_2k.inf" -dest "uata_nt4.inf" uata_nt4.inf > nul
srchrep -src "%%CLASSNAME%%" -dest "IDE ATA/ATAPI"       uata_nt4.inf > nul
srchrep -src "System Bus Extender" -dest "SCSI miniport" uata_nt4.inf > nul
srchrep -src "ExcludeFromSelect" -dest ";ExcludeFromSelect"    uata_nt4.inf > nul

srchrep -src "%%EDITION%%" -dest " (Win 2000)"       uata_2k.inf  > nul
copy uata_2k.inf uata_2kh.inf
srchrep -src "%%COMMENT%%" -dest " (SCSI)"           uata_2k.inf  > nul
srchrep -src "Class=SCSIAdapter" -dest "Class=hdc"   uata_2kh.inf > nul
srchrep -src "ClassGuid={4D36E97B-E325-11CE-BFC1-08002BE10318}" -dest "ClassGuid={4D36E96A-E325-11CE-BFC1-08002BE10318}" uata_2kh.inf > nul
srchrep -src " %%COMMENT%%" -dest ""                 uata_2kh.inf > nul
srchrep -src "%%COMMENT%%" -dest ""                  uata_2kh.inf > nul
srchrep -src "uata_2k.inf" -dest "uata_2kh.inf"      uata_2kh.inf > nul
srchrep -src "%%CLASSNAME%%" -dest "IDE ATA/ATAPI"   uata_2kh.inf > nul
srchrep -src "%%CLASSNAME%%" -dest "SCSI/RAID"       uata_2k.inf  > nul

build_inf.exe uata_xp.in_ > uata_xp.inf
copy uata_xp.inf uata_xph.inf
srchrep -src "Class=SCSIAdapter" -dest "Class=hdc"   uata_xph.inf > nul
srchrep -src "ClassGuid={4D36E97B-E325-11CE-BFC1-08002BE10318}" -dest "ClassGuid={4D36E96A-E325-11CE-BFC1-08002BE10318}" uata_xph.inf > nul
srchrep -src "%%COMMENT%%" -dest " (SCSI)"           uata_xp.inf  > nul

build_inf.exe uata_2k3.in_ > uata_2k3.inf
copy uata_2k3.inf uata_2k3h.inf
srchrep -src "Class=SCSIAdapter" -dest "Class=hdc"   uata_2k3h.inf > nul
srchrep -src "ClassGuid={4D36E97B-E325-11CE-BFC1-08002BE10318}" -dest "ClassGuid={4D36E96A-E325-11CE-BFC1-08002BE10318}" uata_2k3h.inf > nul
srchrep -src "%%COMMENT%%" -dest " (SCSI)"           uata_2k3.inf  > nul

rem build_inf.exe uata_w7.in_ > uata_w7.inf
rem copy uata_w7.inf uata_w7h.inf
rem srchrep -src "%%COMMENT%%" -dest "" uata_w7.inf              > nul
rem srchrep -src "Class=SCSIAdapter" -dest "Class=hdc" uata_w7h.inf > nul
rem srchrep -src "ClassGuid={4D36E97B-E325-11CE-BFC1-08002BE10318}" -dest "ClassGuid={4D36E96A-E325-11CE-BFC1-08002BE10318}" uata_w7h.inf > nul
rem srchrep -src "%%COMMENT%%" -dest " (SCSI)" uata_w7h.inf      > nul

srchrep -src "%%BUILD_TS%%" -dest "%ver_ts%"         uata_*.inf > nul
srchrep -src "%%DRIVER_VER%%" -dest "%ver_dot%"      uata_*.inf > nul

copy uniata_w2k.re_ uniata_w2k.reg
srchrep -src "%%DRIVER_VER%%" -dest "%ver_dot%"      uniata_w2k.reg > nul

mkdir ..\NT4
mkdir ..\2K
mkdir ..\XP
mkdir ..\2k3
rem mkdir ..\W7

del /q ..\NT4\uata_nt4.inf
del /q ..\2K\uata_2k*.inf
del /q ..\2K\uniata_w2k.reg
del /q ..\XP\uata_xp*.inf
del /q ..\2k3\uata_2k3*.inf
rem del /q ..\W7\uata_w7*.inf

move uata_nt4.inf   ..\NT4
move uata_2k3*.inf  ..\2k3
move uata_2k*.inf   ..\2K
move uniata_w2k.reg ..\2K
move uata_xp*.inf   ..\XP
rem move uata_w7*.inf   ..\W7
