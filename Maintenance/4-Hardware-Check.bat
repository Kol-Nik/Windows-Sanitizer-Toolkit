@echo off
chcp 65001 >nul
net session >nul 2>&1
if %errorLevel% neq 0 (echo [!] Please run as Administrator! & pause & exit /b)

title [Maintenance] Hardware Diagnostic
color 0B

echo ===================================================
echo            Hardware Health Diagnostic              
echo ===================================================
echo.

echo [+] Checking Drive S.M.A.R.T. Status...
wmic diskdrive get model,status

echo.
echo [+] Scheduling CHKDSK scan for C: drive...
chkdsk C: /f /r

echo.
echo ===================================================
echo             Hardware Check Initiated!              
echo ===================================================
echo.
pause