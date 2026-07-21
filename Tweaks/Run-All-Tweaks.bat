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
cd /d "%~dp0"

:: Launch Master PowerShell GUI Engine
powershell -ExecutionPolicy Bypass -File "Run-All-Tweaks.ps1"
