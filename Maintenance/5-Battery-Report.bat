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

title [Maintenance] Energy Efficiency and Battery Analysis
color 0B

echo ============================================================
echo      STARTING ENERGY ANALYSIS (RECOMMENDED FOR LAPTOPS)     
echo ============================================================
echo.
echo Please close all other running programs for more accurate results.
echo The system will analyze the computer for 60 seconds...
echo.

set "REPORT_PATH=%USERPROFILE%\Desktop\energy-report.html"

:: Run energy trace and output directly to the user's desktop
powercfg /energy /output "%REPORT_PATH%"

echo.
echo ------------------------------------------------------------
echo Done! The report has been generated successfully.
echo You can find it here: %REPORT_PATH%
echo ------------------------------------------------------------
echo.
set /p open_report="Do you want to open the report in your browser NOW? (Y/N): "
if /i "%open_report%"=="Y" start "" "%REPORT_PATH%"
exit /b