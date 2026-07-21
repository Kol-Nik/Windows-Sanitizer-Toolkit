@echo off
:: Force working directory to script location immediately
cd /d "%~dp0"

:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Requesting Administrator privileges...
    powershell -Command "Start-Process cmd.exe -ArgumentList '/c \"\"%~f0\"\"' -Verb RunAs"
    exit /b
)

title Windows Maintenance Engine
color 0B

echo [+] Launching Maintenance GUI...
echo.

:: Launch GUI script using absolute path and ExecutionPolicy Bypass
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Run-All-Maintenance.ps1"

:: Keep window open if an error occurs instead of silently closing
if %errorLevel% neq 0 (
    echo.
    echo [!] Launcher exited with error code: %errorLevel%
    pause
)
