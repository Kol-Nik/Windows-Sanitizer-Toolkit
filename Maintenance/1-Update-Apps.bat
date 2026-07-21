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

echo [+] Checking WinGet environment...

:: Forcefully reset sources and accept agreement terms headlessly
winget source reset --force --accept-source-agreements >nul 2>&1

:: Verify if source is responding; if failed, repair via PowerShell MSIX cache
winget source update --source winget >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Source database corrupted. Repairing WinGet source index...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Add-AppxPackage -Path 'https://cdn.winget.microsoft.com/cache/source.msix' -ErrorAction SilentlyContinue" >nul 2>&1
    winget source reset --force --accept-source-agreements >nul 2>&1
)

echo [+] Checking for software updates...
echo     This may take a few minutes. Please wait...
echo.

:: Execute upgrade across all repositories with auto-agreements enabled
winget upgrade --all --include-unknown --accept-package-agreements --accept-source-agreements --disable-interactivity

echo.
echo ===================================================
echo           Software Update Process Completed!       
echo ===================================================
echo.
pause
