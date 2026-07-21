@echo off
:: Ensure Administrator Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Requesting Administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo ====================================================
echo    Windows Sanitizer - Executing All Tweaks
echo ====================================================
echo.

set SCRIPT_DIR=%~dp0

:: 1. Debloat Native Apps
echo [*] Step 1/9: Running Debloat-Apps.ps1...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Debloat-Apps.ps1"
echo.

:: 2. Disable Consumer Features
echo [*] Step 2/9: Running Disable-ConsumerFeatures.ps1...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Disable-ConsumerFeatures.ps1"
echo.

:: 3. Disable Search Bloat & Cortana
echo [*] Step 3/9: Running Disable-SearchBloat.ps1...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Disable-SearchBloat.ps1"
echo.

:: 4. Disable Telemetry Services
echo [*] Step 4/9: Running Disable-TelemetryServices.ps1...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Disable-TelemetryServices.ps1"
echo.

:: 5. Enable Storage Sense
echo [*] Step 5/9: Running Enable-StorageSense.ps1...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Enable-StorageSense.ps1"
echo.

:: 6. Disable Copilot & AI
echo [*] Step 6/9: Running Disable-CopilotAI.ps1...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Disable-CopilotAI.ps1"
echo.

:: 7. Disable Widgets & News Feed
echo [*] Step 7/9: Running Disable-Widgets.ps1...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Disable-Widgets.ps1"
echo.

:: 8. Enable Classic Context Menu
echo [*] Step 8/9: Running Enable-ClassicContextMenu.ps1...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Enable-ClassicContextMenu.ps1"
echo.

:: 9. Disable Game DVR Background Recording
echo [*] Step 9/9: Running Disable-GameDVR.ps1...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%Disable-GameDVR.ps1"
echo.

echo ====================================================
echo    All Tweaks Applied Successfully!
echo ====================================================
echo.
pause
