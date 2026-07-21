# Windows Debloat & Privacy Hardening Suite

A lightweight, modular collection of PowerShell scripts designed to remove Windows bloatware, disable telemetry, lock down location tracking, and optimize performance. 

Equipped with an interactive GUI engine that automatically detects and lists available tweaks without requiring manual configuration.

---

## 🛠️ Included Tweaks & Scripts

| Script | Functionality |
| :--- | :--- |
| **`Debloat-Apps.ps1`** | Interactive GUI to selectively uninstall unwanted UWP/Store AppX packages. |
| **`Disable-BraveBloat.ps1`** | Auto-detects Brave Browser and disables Leo AI, Crypto Wallet, Rewards, News, VPN, & IPFS via Group Policy. |
| **`Disable-ConsumerFeatures.ps1`** | Blocks automatic installation of third-party sponsored apps and Start Menu suggestions. |
| **`Disable-CopilotAI.ps1`** | Completely turns off Windows Copilot, Recall, and AI integration features. |
| **`Disable-GameDVR.ps1`** | Disables background game recording, Xbox Game Bar, and suppresses `ms-gamingoverlay` missing protocol popups. |
| **`Disable-LocationAndSensors.ps1`** | Hard-locks location APIs, disables physical sensor polling, stops Find My Device, and kills the Geolocation service (`lfsvc`). |
| **`Disable-NetworkConnectivityStatusIndicator.ps1`** | Stops Windows from sending active background connection pings to `msftconnecttest.com`. |
| **`Disable-OneDrive.ps1`** | Uninstalls the OneDrive desktop client, removes residual files, and cleans up the File Explorer navigation pane icon. |
| **`Disable-PrivacyAndAds.ps1`** | Blocks diagnostic tracking, targeted advertising IDs, activity history harvesting, and feedback prompts. |
| **`Disable-SearchBloat.ps1`** | Removes Web/Bing search results from the Start Menu, forcing local-only file search. |
| **`Disable-TelemetryServices.ps1`** | Stops and disables core Windows diagnostic tracking services (`DiagTrack`, `dmwappushservice`). |
| **`Disable-TypingAndInkingData.ps1`** | Blocks key/pen input telemetry, contact harvesting for autocorrect models, and CEIP scheduled tasks. |
| **`Disable-Widgets.ps1`** | Disables the Windows 11 Widgets board and background web feeds. |
| **`Enable-ClassicContextMenu.ps1`** | Restores the full, traditional Windows 10 right-click context menu on Windows 11. |
| **`Enable-StorageSense.ps1`** | Configures automatic temp file and system cache cleanup. |

---

## 🚀 How to Run

1. **Download or Clone** the repository.
2. Right-click **`Run-All-Tweaks.bat`** and select **Run as Administrator**.
3. Use the interactive GUI to select the tweaks you wish to apply, then click **Run Selected Tweaks**.

> **Note:** Any new `.ps1` script added to the `Tweaks` folder will be dynamically discovered by `Run-All-Tweaks.ps1` on launch.

---

## 📄 License

This project is open-source under the terms of the [LICENSE](LICENSE) included in this repository.
