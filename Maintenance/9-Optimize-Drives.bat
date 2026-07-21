@echo off
echo [!] Optimizing Drives (TRIM for SSDs / Defrag for HDDs)...
powershell -ExecutionPolicy Bypass -Command "Optimize-Volume -DriveLetter C -ReTrim -Defrag -Verbose"
echo [v] Drive Optimization Complete.
pause
