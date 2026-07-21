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

title [Maintenance] Create System Restore Point
echo === CREATING SYSTEM RESTORE POINT ===
echo.

powershell -ExecutionPolicy Bypass -Command "Enable-ComputerRestore -Drive '$env:SystemDrive' -ErrorAction SilentlyContinue; Checkpoint-Computer -Description 'Manual Maintenance Checkpoint' -RestorePointType 'MODIFY_SETTINGS'"

echo.
echo ------------------------------------------------------------
echo Done! System restore point created successfully.
echo ------------------------------------------------------------
echo.
pause
exit
