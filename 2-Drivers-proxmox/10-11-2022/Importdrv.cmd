REM SYSTEM MAY CRASH WHEN INSTALLING THE QXL VIDEO DRIVER!
pnputil /add-driver "%~dp0*.inf" /subdirs /install
@pause
