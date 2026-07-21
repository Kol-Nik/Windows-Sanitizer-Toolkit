# ⚙️ System Maintenance Suite

A lightweight collection of batch scripts designed to repair system files, optimize drive performance, clear junk cache, update software, and diagnose hardware issues.

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

1. Open the **`Maintenance/`** folder.
2. Right-click any `.bat` script you wish to run and select **Run as Administrator**.
3. Follow the on-screen prompts in the Command Prompt window.

> **Tip:** Running **`8-Create-RestorePoint.bat`** first is recommended before performing deep repairs or component store cleanups.
