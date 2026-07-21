@echo off
chcp 65001 >nul
title [Maintenance] Software Updates
echo === CHECKING AND UPDATING INSTALLED APPLICATIONS ===
echo Please wait...
echo.
winget upgrade --all
echo.
echo Process completed!
pause
