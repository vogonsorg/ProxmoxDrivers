echo off &TITLE Virtio install script
:WELCOME
cls
echo.
echo This will install the "Virtio_Win_Red_Hat_CA.cer" as Trusted Root and Trusted Publisher Certificate.
echo.
set /P "START=Continue? (y/n): "

if '%START%' equ 'y' goto WORK
if '%START%' equ 'n' exit /B
goto WELCOME

:WORK
if not exist "%SYSTEMROOT%\System32\certutil.exe" goto CERTUTIL_NOT_FOUND
set "CA=%~dp0\Virtio_Win_Red_Hat_CA.cer"
cls
echo ***************************************************************************
echo Installing 'Virtio_Win_Red_Hat_CA.cer' as Trusted Root Certificate
echo ***************************************************************************
echo.
call %SYSTEMROOT%\System32\certutil.exe -f -addstore "Root" "%CA%"
echo. &echo.

REM echo ***************************************************************************
REM echo Installing 'Virtio_Win_Red_Hat_CA.cer' as Trusted Publisher Certificate
REM echo ***************************************************************************
REM echo.
REM call %SYSTEMROOT%\System32\certutil.exe -f -addstore "TrustedPublisher" "%CA%"
REM echo. &echo.
@pause
exit /B

:CERTUTIL_NOT_FOUND
cls
echo.
echo Failure: Windows tool "Certutil.exe" not found.
echo Certificate couldn't be installed.
echo.
@pause
exit /B