@echo off
chcp 65001 >nul
net session >nul 2>&1
if %errorLevel% NEQ 0 (echo Please run as Administrator! & pause & exit /b)

title [4/6] Hardware Diagnostics
echo === HARDWARE HEALTH CHECK ===
echo.
echo [1/3] Quick physical disk status:
powershell "Get-PhysicalDisk | Format-Table FriendlyName, MediaType, HealthStatus, OperationalStatus"
echo.
echo [2/3] Scheduling file system check (chkdsk)...
echo Note: For SSDs, /f flag is recommended (gentler). For HDDs, use /r.
chkdsk C: /f
echo.
echo [3/3] Preparing Windows Memory Diagnostic (MDSCHED) for RAM...
echo A window will pop up - select the first option "Restart now and check for problems".
echo.
pause
mdsched.exe
exit