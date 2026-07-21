## 🚀 Quick Start: Tweaks & Debloat (`/Tweaks`)

The scripts in this directory allow you to remove built-in Windows bloatware, disable telemetry and AI tracking, clean up background resources, and customize the system interface.

### ⚙️ How to Run:
* **Run All Core Tweaks (Automated):** Right-click **`Run-All-Tweaks.bat`** and select **Run as Administrator**.
* **Run Individual Tweaks:** Right-click any specific `.ps1` file and select **Run with PowerShell** (ensure Admin rights).

---

### 📦 Core System Tweaks (Automated via `Run-All-Tweaks.bat`)

| Script Name | Target Area | Primary Action |
| :--- | :--- | :--- |
| **`Debloat-Apps.ps1`** | Apps | Uninstalls pre-installed UWP bloatware (Xbox, Solitaire, Bing apps, etc.). |
| **`Disable-ConsumerFeatures.ps1`** | System Ads | Blocks auto-installing apps (Candy Crush), lock screen ads, Settings app ads, and setup prompts. |
| **`Disable-SearchBloat.ps1`** | Search / Explorer | Disables Cortana, removes Bing web search from Start, and strips `Gallery` / `OneDrive` from the sidebar. |
| **`Disable-TelemetryServices.ps1`** | Privacy & Network | Disables `DiagTrack`, clears diagnostic logs, blocks Location Tracking, and turns off P2P Delivery Optimization uploads. |
| **`Enable-StorageSense.ps1`** | Storage | Configures Windows Storage Sense for automated background temporary file cleanup. |
| **`Disable-CopilotAI.ps1`** | AI & Recall | Completely disables Copilot, Windows Recall snapshots, Paint AI, Notepad AI, and Edge AI sidebar integrations. |
| **`Disable-Widgets.ps1`** | Taskbar | Hides the Taskbar Widgets icon and kills the background News & Interests process (`TaskbarDa`). |
| **`Enable-ClassicContextMenu.ps1`** | Interface | Restores the full, traditional Windows 10 right-click context menu in Windows 11. |
| **`Disable-GameDVR.ps1`** | Performance | Disables Xbox Game DVR background screen capture to free up CPU and GPU overhead. |

---

### 🌐 Optional / App-Specific Tweaks (Run On-Demand)

* **`Debloat-BraveBrowser.ps1`**  
  * **Description:** Automatically checks if Brave Browser is installed. If detected, it applies group policies to disable built-in bloatware features including **Leo AI Chat, Crypto Wallet, Brave VPN, Brave News, Brave Rewards, and Brave Talk**.
  * **Usage:** Safe to run manually at any time without cluttering systems where Brave is not installed.
