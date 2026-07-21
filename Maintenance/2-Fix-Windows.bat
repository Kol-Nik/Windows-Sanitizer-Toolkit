@echo off
chcp 65001 >nul
net session >nul 2>&1
if %errorLevel% NEQ 0 (echo Please run as Administrator! & pause & exit /b)

title [Maintenance] Windows System Repair
echo === STARTING SYSTEM REPAIR ===
echo.
echo [Step 1/2] Restoring system image (DISM)...
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo [Step 2/2] Scanning system files (SFC)...
sfc /scannow
echo.
echo Repair process finished!
pause
