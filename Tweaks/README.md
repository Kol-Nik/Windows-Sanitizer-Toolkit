## 🚀 Quick Start: Tweaks & Debloat (`/Tweaks`)

The scripts in this directory remove built-in Windows bloatware, disable telemetry, location, and AI tracking, clean up background network usage, and customize the desktop interface.

### ⚙️ How to Run:
* **Run All Core Tweaks (Automated):** Right-click **`Run-All-Tweaks.bat`** and select **Run as Administrator**.
* **Run Individual Tweaks:** Right-click any specific `.ps1` file and select **Run with PowerShell** (ensure Admin rights).

---

### 📦 Core System Tweaks (Automated via `Run-All-Tweaks.bat`)

| Script Name | Target Area | Primary Action |
| :--- | :--- | :--- |
| **`Debloat-Apps.ps1`** | Apps | Uninstalls pre-installed UWP bloatware (Xbox, Solitaire, Bing apps, etc.). |
| **`Disable-ConsumerFeatures.ps1`** | System Bloat | Blocks auto-installing apps (Candy Crush) and Windows Spotlight content. |
| **`Disable-PrivacyAndAds.ps1`** | Privacy & Ads | Blocks activity history, targeted advertising, lock screen/Edge ads, location tracking, Find My Device, and hides Settings 'Home'. |
| **`Disable-SearchBloat.ps1`** | Search / Explorer | Disables Cortana, removes Bing web search from Start, and strips `Gallery` / `OneDrive` from the sidebar. |
| **`Disable-TelemetryServices.ps1`** | Services & Bandwidth | Stops `DiagTrack` service, clears diagnostic logs, and turns off P2P Delivery Optimization background uploads. |
| **`Enable-StorageSense.ps1`** | Storage | Configures Windows Storage Sense for automated background temporary file cleanup. |
| **`Disable-CopilotAI.ps1`** | AI & Recall | Disables Copilot, Recall snapshots, Click to Do, `WSAIFabricSvc`, Paint AI, Notepad AI, and Edge AI integrations. |
| **`Disable-Widgets.ps1`** | Taskbar | Hides the Taskbar Widgets icon and kills the background News & Interests process (`TaskbarDa`). |
| **`Enable-ClassicContextMenu.ps1`** | Interface | Restores the full, traditional Windows 10 right-click context menu in Windows 11. |
| **`Disable-GameDVR.ps1`** | Performance | Disables Xbox Game DVR background screen capture to free up CPU and GPU overhead. |

---

### 🌐 Optional / App-Specific Tweaks (Run On-Demand)

* **`Debloat-BraveBrowser.ps1`**  
  * **Description:** Checks if Brave Browser is installed. If detected, applies group policies to disable built-in bloat features including **Leo AI Chat, Crypto Wallet, Brave VPN, Brave News, Brave Rewards, and Brave Talk**.
  * **Usage:** Safe to run manually at any time without modifying systems where Brave is not installed.
