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

title [5/6] Energy Efficiency and Battery Analysis
echo === STARTING ENERGY ANALYSIS (RECOMMENDED FOR LAPTOPS) ===
echo.
echo Please close all other running programs for more accurate results.
echo The system will analyze the computer for 60 seconds...
echo.

powercfg /energy

echo.
echo ------------------------------------------------------------
echo Done! The report has been generated successfully.
echo You can find it here: C:\Windows\system32\energy-report.html
echo ------------------------------------------------------------
echo.
set /p open_report="Do you want to open the report in your browser NOW? (Y/N): "
if /i "%open_report%"=="Y" start C:\Windows\system32\energy-report.html
exit