# ⚙️ System Maintenance Suite

A lightweight collection of batch scripts and an interactive PowerShell GUI designed to repair system files, optimize drive performance, clear junk cache, update software, and diagnose hardware issues.

Equipped with an interactive GUI engine that automatically detects and lists all available maintenance scripts.

---

## 🛠️ Maintenance Utilities

| Script | Purpose |
| :--- | :--- |
| **`1-Update-Apps.bat`** | Upgrades all installed software packages via Windows Package Manager (`winget`). |
| **`2-Fix-Windows.bat`** | Scans and repairs corrupt system files using DISM image servicing and SFC (`SFC /scannow`). |
| **`3-Fix-Network.bat`** | Flushes DNS cache, releases/renews IP configuration, and resets TCP/IP & Winsock socket pools. |
| **`4-Hardware-Check.bat`** | Checks storage drive S.M.A.R.T. health, schedules CHKDSK, and launches Memory Diagnostics (`mdsched`). |
| **`5-Battery-Report.bat`** | Generates a detailed battery health and power efficiency trace outputted to the Desktop (`powercfg /energy`). |
| **`6-Clean-SystemStore.bat`** | Deep WinSxS component store cleanup to reclaim gigabytes of disk space after Windows Updates. |
| **`7-Clean-JunkFiles.bat`** | Purges User/System Temp folders, Prefetch cache, and stale Windows Update download files. |
| **`8-Create-RestorePoint.bat`** | Creates an instant, manual System Restore Point for system safety. |
| **`9-Optimize-Drives.bat`** | Triggers native OS re-TRIM on SSDs and defragmentation on traditional HDDs (`Optimize-Volume`). |

---

## 🚀 How to Run

### Method 1: Interactive GUI Launcher (Recommended)
1. Open the **`Maintenance/`** folder.
2. Right-click **`Run-All-Maintenance.bat`** and select **Run as Administrator**.
3. Select the tasks you wish to run, check **Create System Restore Point** for safety, and click **Run Selected Maintenance**.

### Method 2: Individual Batch Scripts
You can also run any script standalone by right-clicking it and selecting **Run as Administrator**.

> **Note:** Any new `.bat` script added to the `Maintenance` folder will be dynamically discovered by `Run-All-Maintenance.ps1` on launch.
