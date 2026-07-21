## ⚙️ Maintenance Suite (`/Maintenance`)

Navigate to the `Maintenance/` folder and run any batch script as Administrator for regular system care:

| Script | Purpose |
| :--- | :--- |
| **`1-Update-Apps.bat`** | Upgrades all installed software via Winget. |
| **`2-Fix-Windows.bat`** | Repairs corrupt Windows system files (`DISM` + `SFC`). |
| **`3-Fix-Network.bat`** | Flushes DNS, releases/renews IP, and resets TCP/IP & Winsock. |
| **`4-Hardware-Check.bat`** | Checks drive health, schedules `CHKDSK`, and launches RAM diagnostics (`MDSCHED`). |
| **`5-Battery-Report.bat`** | Generates an in-depth energy/battery health report (`powercfg /energy`). |
| **`6-Clean-SystemStore.bat`** | Deep WinSxS cleanup to reclaim disk space after Windows Updates. |
