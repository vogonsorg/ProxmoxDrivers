@echo off
cd ..
copy uniata.sys "%SystemRoot%\System32\drivers\uniata.sys"
start /wait regedit -s 2k\uniata_w2k.reg
echo Universal ATA driver installed
echo please reboot your computer to complete installation
cd 2k
pause
