# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "=== Disabling Windows Copilot, Recall, AI Services, and App AI Features ===" -ForegroundColor Yellow

# 1. Disable Copilot Taskbar Button for Current User
$AdvancedExplorer = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if (-not (Test-Path $AdvancedExplorer)) { New-Item -Path $AdvancedExplorer -Force | Out-Null }
Set-ItemProperty -Path $AdvancedExplorer -Name "ShowCopilotButton" -Value 0 -Type DWord -ErrorAction SilentlyContinue

# 2. Disable Copilot Group Policies (User & System)
$UserCopilot = "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot"
if (-not (Test-Path $UserCopilot)) { New-Item -Path $UserCopilot -Force | Out-Null }
Set-ItemProperty -Path $UserCopilot -Name "TurnOffWindowsCopilot" -Value 1 -Type DWord -ErrorAction SilentlyContinue

$SysCopilot = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot"
if (-not (Test-Path $SysCopilot)) { New-Item -Path $SysCopilot -Force | Out-Null }
Set-ItemProperty -Path $SysCopilot -Name "TurnOffWindowsCopilot" -Value 1 -Type DWord -ErrorAction SilentlyContinue

# 3. Disable Windows AI Policies (Recall, Snapshots, Click to Do, Settings Agent)
$WinAI = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsAI"
if (-not (Test-Path $WinAI)) { New-Item -Path $WinAI -Force | Out-Null }
Set-ItemProperty -Path $WinAI -Name "DisableAIDataAnalysis" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $WinAI -Name "AllowRecallEnablement" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $WinAI -Name "TurnOffSavingSnapshots" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $WinAI -Name "DisableClickToDo" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $WinAI -Name "DisableSettingsAgent" -Value 1 -Type DWord -ErrorAction SilentlyContinue

# 4. Disable Paint AI Features (Cocreator, Generative Fill, Image Creator)
$Paint = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Paint"
if (-not (Test-Path $Paint)) { New-Item -Path $Paint -Force | Out-Null }
Set-ItemProperty -Path $Paint -Name "DisableCocreator" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Paint -Name "DisableGenerativeFill" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Paint -Name "DisableImageCreator" -Value 1 -Type DWord -ErrorAction SilentlyContinue

# 5. Disable Notepad AI Features
$Notepad = "HKLM:\SOFTWARE\Policies\WindowsNotepad"
if (-not (Test-Path $Notepad)) { New-Item -Path $Notepad -Force | Out-Null }
Set-ItemProperty -Path $Notepad -Name "DisableAIFeatures" -Value 1 -Type DWord -ErrorAction SilentlyContinue

# 6. Disable Edge AI, Copilot Sidebar & Bing Chat
$Edge = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
if (-not (Test-Path $Edge)) { New-Item -Path $Edge -Force | Out-Null }
Set-ItemProperty -Path $Edge -Name "CopilotPageContext" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Edge -Name "NewTabPageBingChatEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Edge -Name "HubsSidebarEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue

# 7. Stop and Disable WSAIFabricSvc (Windows AI Fabric Service)
$AIService = "WSAIFabricSvc"
if (Get-Service -Name $AIService -ErrorAction SilentlyContinue) {
    Stop-Service -Name $AIService -Force -ErrorAction SilentlyContinue
    Set-Service -Name $AIService -StartupType Disabled -ErrorAction SilentlyContinue
    Write-Host "[+] Disabled $AIService (Windows AI Fabric Service)" -ForegroundColor Green
}

Write-Host "[+] All Windows Copilot, Recall, Edge AI, and App AI features disabled successfully!" -ForegroundColor Green
