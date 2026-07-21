@echo off
:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Requesting Administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Windows Debloat & Tweaks Engine
color 0A
echo ===================================================
echo       Running Core Windows Tweaks & Debloat        
echo ===================================================
echo.

cd /d "%~dp0"

echo [+] Running: Debloat Apps...
powershell -ExecutionPolicy Bypass -File "Debloat-Apps.ps1"

echo [+] Running: Disable Consumer Features...
powershell -ExecutionPolicy Bypass -File "Disable-ConsumerFeatures.ps1"

echo [+] Running: Disable Privacy, Ads & Tracking...
powershell -ExecutionPolicy Bypass -File "Disable-PrivacyAndAds.ps1"

echo [+] Running: Disable Search Bloat...
powershell -ExecutionPolicy Bypass -File "Disable-SearchBloat.ps1"

echo [+] Running: Disable Telemetry Services...
powershell -ExecutionPolicy Bypass -File "Disable-TelemetryServices.ps1"

echo [+] Running: Enable Storage Sense...
powershell -ExecutionPolicy Bypass -File "Enable-StorageSense.ps1"

echo [+] Running: Disable Copilot & AI Features...
powershell -ExecutionPolicy Bypass -File "Disable-CopilotAI.ps1"

echo [+] Running: Disable Widgets...
powershell -ExecutionPolicy Bypass -File "Disable-Widgets.ps1"

echo [+] Running: Enable Classic Context Menu...
powershell -ExecutionPolicy Bypass -File "Enable-ClassicContextMenu.ps1"

echo [+] Running: Disable Game DVR...
powershell -ExecutionPolicy Bypass -File "Disable-GameDVR.ps1"

echo.
echo ===================================================
echo       All Core System Tweaks Applied Successfully! 
echo ===================================================
echo.
pause
