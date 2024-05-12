cd ..
copy uniata.sys %SystemRoot%\system32\drivers\uniata.sys
.\tools\drv_ctl.exe --inst-nostart uniata.sys %SystemRoot%\system32\drivers\uniata.sys
cd NT351
