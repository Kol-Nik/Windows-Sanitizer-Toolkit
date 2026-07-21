@echo off
chcp 65001 >nul
net session >nul 2>&1
if %errorLevel% neq 0 (echo [!] Please run as Administrator! & pause & exit /b)

title [Maintenance] Network Reset
color 0B

echo ===================================================
echo               Resetting Network Stack              
echo ===================================================
echo.

echo [+] Flushing DNS cache...
ipconfig /flushdns

echo [+] Releasing and renewing IP address...
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1

echo [+] Resetting Winsock and TCP/IP stack...
netsh winsock reset >nul
netsh int ip reset >nul

echo.
echo ===================================================
echo             Network Reset Completed!               
echo ===================================================
echo.
pause