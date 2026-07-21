@echo off
:: Force UTF-8 encoding for clean character rendering
chcp 65001 >nul

:: Ensure Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Error: Please run this script as Administrator!
    pause
    exit /b
)

title [Maintenance] Software Updates
color 0B

echo ===================================================
echo             Updating Installed Applications        
echo ===================================================
echo.

echo [+] Checking Winget repository for updates...
echo     This may take a few minutes depending on your internet connection.
echo.

:: Automatically accept package agreements and handle updates quietly
winget upgrade --all --include-unknown --accept-package-agreements --accept-source-agreements

echo.
echo ===================================================
echo           Software Update Process Completed!       
echo ===================================================
echo.
pause