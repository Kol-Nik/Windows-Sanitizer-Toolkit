@echo off
echo [!] Creating System Restore Point...
powershell -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'Manual Maintenance Checkpoint' -RestorePointType 'MODIFY_SETTINGS'"
echo [v] Restore Point Created.
pause
