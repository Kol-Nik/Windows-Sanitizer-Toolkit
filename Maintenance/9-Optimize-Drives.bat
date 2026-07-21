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

title [Maintenance] Optimize Drives (TRIM / Defrag)
echo === OPTIMIZING DRIVES ===
echo.
echo Re-trimming SSDs and defragmenting HDDs...
echo.

powershell -ExecutionPolicy Bypass -Command "Optimize-Volume -DriveLetter C -ReTrim -Defrag -Verbose"

echo.
echo ------------------------------------------------------------
echo Done! Drive optimization complete.
echo ------------------------------------------------------------
echo.
pause
exit
