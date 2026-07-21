@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Requesting Administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Windows Maintenance Engine
color 0B
cd /d "%~dp0"

powershell -ExecutionPolicy Bypass -File "Run-All-Maintenance.ps1"
