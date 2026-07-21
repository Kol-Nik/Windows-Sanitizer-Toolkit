@echo off
chcp 65001 >nul

:: Check if the file is running as Administrator
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ============================================================
    echo ERROR: Please run this file as ADMINISTRATOR!
    echo Right-click and select "Run as administrator".
    echo ============================================================
    pause
    exit /b
)

title Windows Optimization & Debloat Suite

echo ============================================================
echo           RUNNING WINDOWS DEBLOAT & TWEAKS
echo ============================================================
echo.

echo [1/5] Removing Native App Bloatware...
echo ------------------------------------------------------------
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Debloat-Apps.ps1"
echo ------------------------------------------------------------
echo.

echo [2/5] Disabling Consumer Features & Spotlight Ads...
echo ------------------------------------------------------------
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Disable-ConsumerFeatures.ps1"
echo ------------------------------------------------------------
echo.

echo [3/5] Disabling Cortana & Web/Bing Search...
echo ------------------------------------------------------------
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Disable-SearchBloat.ps1"
echo ------------------------------------------------------------
echo.

echo [4/5] Disabling Telemetry & Tracking Services...
echo ------------------------------------------------------------
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Disable-TelemetryServices.ps1"
echo ------------------------------------------------------------
echo.

echo [5/5] Configuring Storage Sense (Weekly Automated Cleanup)...
echo ------------------------------------------------------------
PowerShell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Enable-StorageSense.ps1"
echo ------------------------------------------------------------
echo.

echo ============================================================
echo All tweaks and optimizations have been applied successfully!
echo ============================================================
pause