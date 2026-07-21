# Windows Debloat & Tweaks Engine

A modular, GUI-driven PowerShell toolkit designed to debloat Windows, disable telemetry, block ads, and optimize system performance.

---

## ⚡ Features

* **Dynamic Script Loader:** Automatically detects all `.ps1` scripts in the directory—add, remove, or edit tweak files without changing any launcher code.
* **Granular App Debloater:** Interactive GUI allowing you to pick and choose exactly which built-in Windows apps and bloatware to remove.
* **Clean System Purge:** Removes both active user packages and provisioned app stubs (`Remove-AppxProvisionedPackage`) to prevent Windows from auto-reinstalling bloatware during updates.
* **Safe & Non-Destructive:** Granular check-box selection for both script modules and individual apps—never forces a one-size-fits-all tweak.

---

## 🛠️ Included Tweak Modules

| Module | Focus Area |
| :--- | :--- |
| **Debloat Apps** | Removes pre-installed UWP bloatware, games, and OEM packages. |
| **Disable Copilot & AI** | Disables Windows Copilot, Recall, and AI Hub integrations. |
| **Disable Privacy & Ads** | Turns off advertising ID, tailored experiences, and diagnostic tracking. |
| **Disable Search Bloat** | Removes web search, Bing integrations, and ads from the Start Menu/Search. |
| **Disable Telemetry Services** | Stops background diagnostic data collection services. |
| **Disable Consumer Features** | Prevents Windows from automatically downloading recommended apps/games. |
| **Disable Widgets** | Removes the Widgets board and taskbar button. |
| **Disable Game DVR** | Turns off background Xbox game recording to free up system resources. |
| **Enable Storage Sense** | Enables automated temporary file cleanup. |
| **Enable Classic Context Menu** | Restores the legacy Windows 10 right-click menu (Windows 11). |

---

## 🚀 How to Use

1. Download or clone this repository.
2. Right-click **`Run-All-Tweaks.bat`** and select **Run as Administrator**.
3. **Master Tweaks GUI:** Select which tweak modules you want to apply, then click **Run Selected Tweaks**.
4. **App Selection GUI:** If *Debloat Apps* is selected, a second popup will appear letting you pick specific apps to keep or remove.
