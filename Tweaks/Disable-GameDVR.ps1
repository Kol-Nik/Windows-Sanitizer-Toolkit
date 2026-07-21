# Disable-GameDVR.ps1
Write-Host "[+] Disabling Xbox Game Bar & Background Game Recording..." -ForegroundColor Cyan

# 1. Disable Game DVR & Game Bar in Current User registry
$HKCU_GameDVR = "HKCU:\System\GameConfigStore"
if (-not (Test-Path $HKCU_GameDVR)) { New-Item -Path $HKCU_GameDVR -Force | Out-Null }
Set-ItemProperty -Path $HKCU_GameDVR -Name "GameDVR_Enabled" -Value 0 -Type DWord
Set-ItemProperty -Path $HKCU_GameDVR -Name "GameDVR_FSEBehaviorMode" -Value 2 -Type DWord
Set-ItemProperty -Path $HKCU_GameDVR -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1 -Type DWord
Set-ItemProperty -Path $HKCU_GameDVR -Name "GameDVR_DXGIHonorFSEWindowsMode" -Value 1 -Type DWord

# 2. Disable Game DVR via Local Machine Policies
$HKLM_GameDVR = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR"
if (-not (Test-Path $HKLM_GameDVR)) { New-Item -Path $HKLM_GameDVR -Force | Out-Null }
Set-ItemProperty -Path $HKLM_GameDVR -Name "AllowGameDVR" -Value 0 -Type DWord

# 3. Disable Game Bar Features in Windows Settings
$HKCU_Gaming = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR"
if (-not (Test-Path $HKCU_Gaming)) { New-Item -Path $HKCU_Gaming -Force | Out-Null }
Set-ItemProperty -Path $HKCU_Gaming -Name "AppCaptureEnabled" -Value 0 -Type DWord
Set-ItemProperty -Path $HKCU_Gaming -Name "HistoricalCaptureEnabled" -Value 0 -Type DWord

# 4. Fix 'ms-gamingoverlay' popups when Xbox Game Bar is uninstalled
$HKCR_Overlay = "HKCR:\ms-gamingoverlay"
if (-not (Test-Path $HKCR_Overlay)) { New-Item -Path $HKCR_Overlay -Force | Out-Null }
Set-ItemProperty -Path $HKCR_Overlay -Name "URL Protocol" -Value "" -Type String
# Point shell open command to nul to suppress missing protocol dialogs
$HKCR_Shell = "HKCR:\ms-gamingoverlay\shell\open\command"
if (-not (Test-Path $HKCR_Shell)) { New-Item -Path $HKCR_Shell -Force | Out-Null }
Set-ItemProperty -Path $HKCR_Shell -Name "(Default)" -Value "cmd.exe /c exit" -Type String

Write-Host "    [✓] Xbox Game Bar and Game DVR successfully disabled." -ForegroundColor Green
