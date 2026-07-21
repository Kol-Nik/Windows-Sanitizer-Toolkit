@echo off
:: Force UTF-8 encoding for clean character rendering
chcp 65001 >nul

:: Ensure Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ============================================================
    echo ERROR: Please run this file as ADMINISTRATOR!
    echo Right-click and select "Run as administrator".
    echo ============================================================
    pause
    exit /b
)

title [Maintenance] Windows System Repair
color 0B

echo ===================================================
echo             Windows System File Repair             
echo ===================================================
echo.

echo [+] Step 1/2: Repairing Windows System Image (DISM)...
echo     This may take several minutes. Please do not close this window.
echo.
DISM /Online /Cleanup-Image /RestoreHealth

echo.
echo ---------------------------------------------------
echo.

echo [+] Step 2/2: Scanning and Repairing System Files (SFC)...
echo.
sfc /scannow

echo.
echo ===================================================
echo          System Repair Process Completed!           
echo ===================================================
echo.
pause
