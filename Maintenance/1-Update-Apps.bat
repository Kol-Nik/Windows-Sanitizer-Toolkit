@echo off
chcp 65001 >nul

:: Ensure Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] ERROR: Please run this script as Administrator!
    pause
    exit /b
)

title [Maintenance] Software Updates
color 0B

echo ===================================================
echo             Updating Installed Applications        
echo ===================================================
echo.

echo [+] Refreshing Winget package sources...
winget source update >nul 2>&1

echo [+] Checking for software updates...
echo     This may take a few minutes. Please wait...
echo.

winget upgrade --all --include-unknown --accept-package-agreements --accept-source-agreements --disable-interactivity

echo.
echo ===================================================
echo           Software Update Process Completed!       
echo ===================================================
echo.
pause
