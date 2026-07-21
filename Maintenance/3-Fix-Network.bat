@echo off
chcp 65001 >nul
net session >nul 2>&1
if %errorLevel% NEQ 0 (echo Please run as Administrator! & pause & exit /b)

title [3/6] Network Reset
echo === COMPLETE NETWORK FLUSH AND RESET ===
echo.
echo Flushing DNS cache...
ipconfig /flushdns
echo Releasing current IP address...
ipconfig /release
echo Renewing IP address...
ipconfig /renew
echo.
echo Resetting network protocols (Winsock and IP)...
netsh winsock reset
netsh int ip reset
netsh int tcp reset
echo.
echo Done! The computer MUST be restarted to apply changes.
set /p choice="Do you want to restart NOW? (Y/N): "
if /i "%choice%"=="Y" shutdown /r /t 5
exit