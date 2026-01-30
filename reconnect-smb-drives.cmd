@echo off
setlocal

set "SERVER=<YOUR_SERVER_NAME>"
set "USER=%SERVER%\<YOUR_USERNAME>"
set "PASS=<YOUR_PASSWORD>"

rem Wait for approx. 5 seconds to allow network connections to stabilize
rem ping -n 5 %SERVER% >nul 2>&1

rem Beware: This will remove all mapped drives (user scope)
rem Specify SMB drive letters explicitly for more control if needed
rem net use * /delete /y >nul 2>&1

rem Rebuild correct Credential Manager entry (user scope)
rem Do not use UNC path (\\%SERVER%) in cmdkey to avoid errors
cmdkey /delete:%SERVER% >nul 2>&1
cmdkey /add:%SERVER% /user:%USER% /pass:%PASS% >nul 2>&1

rem Establish a persistent connection to the server first
net use \\%SERVER% /user:%USER% %PASS% /persistent:yes

rem Map network drives
net use X: "\\%SERVER%\<SharedFolder1>" /persistent:yes
net use Y: "\\%SERVER%\<SharedFolder2>" /persistent:yes
net use Z: "\\%SERVER%\<SharedFolder3>" /persistent:yes

endlocal
