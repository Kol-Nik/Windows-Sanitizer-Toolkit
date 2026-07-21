@echo off
chcp 65001 >nul
net session >nul 2>&1
if %errorLevel% NEQ 0 (echo Please run as Administrator! & pause & exit /b)

title [6/6] Deep WinSxS Cleanup (Component Store)
echo === STARTING DEEP SYSTEM CLEANUP ===
echo.
echo NOTE: This process removes old versions of Windows Update files.
echo It will free up significant disk space, but you won't be able to uninstall current updates.
echo.
echo [1/2] Checking current state and cleaning up...
echo Please wait (this may take several minutes)...
echo ------------------------------------------------------------
DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
echo ------------------------------------------------------------
echo.
echo [2/2] Clearing leftover temporary system caches...
del /q /f /s %WINDIR%\Temp\* >nul 2>&1
echo.
echo Cleanup completed successfully!
pause