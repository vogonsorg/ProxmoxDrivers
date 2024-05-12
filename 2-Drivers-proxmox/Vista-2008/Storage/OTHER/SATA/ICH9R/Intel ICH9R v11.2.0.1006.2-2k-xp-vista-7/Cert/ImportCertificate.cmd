echo off &TITLE Win-RAID CA.cer install script
:WELCOME
cls
echo.
echo This will install the "Win-RAID CA.cer" as Trusted Root and Trusted Publisher Certificate.
echo.
set /P "START=Continue? (y/n): "

if '%START%' equ 'y' goto WORK
if '%START%' equ 'n' exit /B
goto WELCOME

:WORK
if not exist "%SYSTEMROOT%\System32\certutil.exe" goto CERTUTIL_NOT_FOUND
set "CA=%tmp%\Win-RAID CA.cer"
cls
echo ***************************************************************************
echo Creating 'Win-RAID CA.cer'
echo ***************************************************************************
echo.
:: extract certificat informations into tmp file
echo -----BEGIN CERTIFICATE----- > "%CA%.txt"
echo MIIGhzCCBG+gAwIBAgIQ5/ExbCzfI71GlXVExEmkNDANBgkqhkiG9w0BAQsFADCB>> "%CA%.txt"
echo lTElMCMGCSqGSIb3DQEJARYWZmVybmFuZG8udW5vQGdtYWlsLmNvbTELMAkGA1UE>> "%CA%.txt"
echo BhMCREUxCzAJBgNVBAgTAk5JMQ4wDAYDVQQHEwVKZXZlcjEZMBcGA1UEChMQd3d3>> "%CA%.txt"
echo Lndpbi1yYWlkLmNvbTERMA8GA1UECxMIRmVybmFuZG8xFDASBgNVBAMTC1dpbi1S>> "%CA%.txt"
echo QUlEIENBMB4XDTE1MTAyNTE4NTMyMloXDTM5MTIzMTIzNTk1OVowgZUxJTAjBgkq>> "%CA%.txt"
echo hkiG9w0BCQEWFmZlcm5hbmRvLnVub0BnbWFpbC5jb20xCzAJBgNVBAYTAkRFMQsw>> "%CA%.txt"
echo CQYDVQQIEwJOSTEOMAwGA1UEBxMFSmV2ZXIxGTAXBgNVBAoTEHd3dy53aW4tcmFp>> "%CA%.txt"
echo ZC5jb20xETAPBgNVBAsTCEZlcm5hbmRvMRQwEgYDVQQDEwtXaW4tUkFJRCBDQTCC>> "%CA%.txt"
echo AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBANnjNZ0a7ultPdOGQOaEcd2h>> "%CA%.txt"
echo UImcX0685LMsVWei9gk3rpmLy2Sl7BxqeufC5EogXD9LZ1z4WE6Tw3NBUhgt0XrP>> "%CA%.txt"
echo ZWyfCNCUSfcvcV1dVux53LI+ySyUp2AcavHY8sbdhn7/jwHdkgTd3/xE+cn+U+2a>> "%CA%.txt"
echo 7X6Y0zQU7Sy8Up75ls7kq+rp61XfmntWIsGrtJbs09Bt3CYVo7SA57jHDJNGkuSV>> "%CA%.txt"
echo UwDNgUycuRiZT8qnarph0D3RamCpHYyEPnX87t0nRFbdRFMjI5JhBYuD/UE+2PXi>> "%CA%.txt"
echo 4+f2epX52VlpgqZn650kcTEmdl2sS+itxjQZpg1phRLrvYJHjShhNXYJZrq+WU1R>> "%CA%.txt"
echo ZdGOhH0cLz3yoAzW0JKwhOy8HgAjU1EkLcRYLtG6jl46BB6mEM8GXQXdogi9b+ul>> "%CA%.txt"
echo 6J1Pu6v7DvXY+CyJTHTX797DBdcSL/VWH9sA9cZ/ogLwu65BpD/m5ZhjpovX0AS4>> "%CA%.txt"
echo cI74ChYV0lXUhvWQ1KX5hBI4pPFjPZY+j3X5oagg7ERk2XVYdUBkwO8YAnF9O2lI>> "%CA%.txt"
echo s3r0KpZBTp5lvK+EdTp51VlK7LbMQQwwGMDOBGH6JHru7FR6f45a/1nKhcoNU689>> "%CA%.txt"
echo 0EQ9U/1vnOdiU3NVJC+DqtO9b1zvpDlwQUq075a4YizUQA4yj27biJH5dOERipGM>> "%CA%.txt"
echo s8BYrAZSh8m0Om/+/UmhAgMBAAGjgdAwgc0wgcoGA1UdAQSBwjCBv4AQ1POGTxms>> "%CA%.txt"
echo M91sp2WJs2oeOqGBmDCBlTElMCMGCSqGSIb3DQEJARYWZmVybmFuZG8udW5vQGdt>> "%CA%.txt"
echo YWlsLmNvbTELMAkGA1UEBhMCREUxCzAJBgNVBAgTAk5JMQ4wDAYDVQQHEwVKZXZl>> "%CA%.txt"
echo cjEZMBcGA1UEChMQd3d3Lndpbi1yYWlkLmNvbTERMA8GA1UECxMIRmVybmFuZG8x>> "%CA%.txt"
echo FDASBgNVBAMTC1dpbi1SQUlEIENBghDn8TFsLN8jvUaVdUTESaQ0MA0GCSqGSIb3>> "%CA%.txt"
echo DQEBCwUAA4ICAQDHTjgYnmRoQazjtYUXvlVzMDQ+81PN+Wfxe6HYJC2gUGJMFaeJ>> "%CA%.txt"
echo 43kkZPDgy7FAhmqxGTciUK42qRmYmE9cRtvBx/PI+VmtmNAhu3xaJHdFDZsyz6Ac>> "%CA%.txt"
echo 3j/3+HuA63MhXjEeO+XRBplYtg0xDJh8L7jFqLtMSUpET7mRA2i5ltOOv7eOrZcJ>> "%CA%.txt"
echo KGJHLqeGBlQOUyp2XVRO3Atg8H5E9Lr94VCAsN9eMyKkzI//iJLQm89FokjS9Qeo>> "%CA%.txt"
echo bDivRVZKqbcXx0RVSczmU/zAiVk87GEToJQyaKjp9KtOLyGNlEyb1WBb9CZUopaU>> "%CA%.txt"
echo H9b5qYmNJXR8lcmO2aGP61ssp1mQxWi+l9Ru8TKu32uGIazU34X3J8MUapkONLIj>> "%CA%.txt"
echo zboPzituAXyNQ0I6EHhw+RuAWpKhHSTpCzoONS38OJckhHtQImcMB75WUuxZO6LQ>> "%CA%.txt"
echo 1r2L6FrNAnHONSDPsOrYlowlE3qv6rCsKCgYKJEho8OlumLyUer6OYF/ujvmBnxy>> "%CA%.txt"
echo MMIjb8E9leWSexhIa4MipFWJ6JEoF/3TSg5uvUSBmwnVtC4rpuJyLIzIAAIA7I2W>> "%CA%.txt"
echo mkFzt1d8bScgw0aZmgFylOlfs6UG8wFByDqOxrIMMqgs0Uia06wzIWqXhU4UnaII>> "%CA%.txt"
echo 45UIXDc15FPanGjxbrP67bV92l7vpLzsyzxccVnADB6fK/F/EGByZiUAXA== >> "%CA%.txt"
echo -----END CERTIFICATE----- >> "%CA%.txt"

:: create Win-RAID CA.cer and delete tmp file
call %SYSTEMROOT%\System32\certutil.exe -decode "%CA%.txt" "%CA%"
call del /F "%CA%.txt"
echo. &echo.

echo ***************************************************************************
echo Installing 'Win-RAID CA.cer' as Trusted Root Certificate
echo ***************************************************************************
echo.
call %SYSTEMROOT%\System32\certutil.exe -f -addstore "Root" "%CA%"
echo. &echo.

echo ***************************************************************************
echo Installing 'Win-RAID CA.cer' as Trusted Publisher Certificate
echo ***************************************************************************
echo.
call %SYSTEMROOT%\System32\certutil.exe -f -addstore "TrustedPublisher" "%CA%"
echo. &echo.
call del /f "%CA%"
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