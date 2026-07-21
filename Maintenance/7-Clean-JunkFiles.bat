@echo off
chcp 65001 >nul
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ============================================================
    echo ERROR: Please run this file as ADMINISTRATOR!
    echo Right-click and select "Run as administrator".
    echo ============================================================
    pause
    exit /b
)

title [Maintenance] Clean System Temp & Cache Files
color 0B

echo ============================================================
echo              CLEANING TEMPORARY FILES & CACHES              
echo ============================================================
echo.

echo [+] Cleaning User & System Temp folders...
del /q /f /s "%TEMP%\*" >nul 2>&1
del /q /f /s "%SystemRoot%\Temp\*" >nul 2>&1

echo [+] Cleaning Prefetch cache...
del /q /f /s "%SystemRoot%\Prefetch\*" >nul 2>&1

echo [+] Stopping Windows Update service to clear download cache...
net stop wuauserv >nul 2>&1
del /q /f /s "%SystemRoot%\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1

echo.
echo ------------------------------------------------------------
echo Done! Temporary files and caches have been cleaned.
echo ------------------------------------------------------------
echo.
pause
exit /b