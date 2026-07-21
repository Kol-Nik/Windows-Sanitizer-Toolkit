# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "Disabling Windows Copilot, Recall, Edge AI, and App AI Features..." -ForegroundColor Yellow

# Disable Copilot Taskbar Button for Current User
$AdvancedExplorer = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if (-not (Test-Path $AdvancedExplorer)) { New-Item -Path $AdvancedExplorer -Force | Out-Null }
Set-ItemProperty -Path $AdvancedExplorer -Name "ShowCopilotButton" -Value 0 -ErrorAction SilentlyContinue

# Disable Copilot Group Policies (User & System)
New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1 -ErrorAction SilentlyContinue

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1 -ErrorAction SilentlyContinue

# Disable Windows Recall & AI Data Snapshots
$WinAI = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI"
New-Item -Path $WinAI -Force | Out-Null
Set-ItemProperty -Path $WinAI -Name "DisableAIDataAnalysis" -Value 1 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $WinAI -Name "AllowRecallEnablement" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $WinAI -Name "TurnOffSavingSnapshots" -Value 1 -ErrorAction SilentlyContinue

# Disable Paint AI Features (Cocreator, Generative Fill, Image Creator)
$Paint = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint"
New-Item -Path $Paint -Force | Out-Null
Set-ItemProperty -Path $Paint -Name "DisableCocreator" -Value 1 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Paint -Name "DisableGenerativeFill" -Value 1 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Paint -Name "DisableImageCreator" -Value 1 -ErrorAction SilentlyContinue

# Disable Notepad AI Features
New-Item -Path "HKLM:\SOFTWARE\Policies\WindowsNotepad" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\WindowsNotepad" -Name "DisableAIFeatures" -Value 1 -ErrorAction SilentlyContinue

# Disable Edge AI, Copilot Sidebar & Bing Chat on New Tab
$Edge = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
New-Item -Path $Edge -Force | Out-Null
Set-ItemProperty -Path $Edge -Name "CopilotPageContext" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Edge -Name "NewTabPageBingChatEnabled" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Edge -Name "HubsSidebarEnabled" -Value 0 -ErrorAction SilentlyContinue

Write-Host "All Windows Copilot and AI features disabled successfully!" -ForegroundColor Green
