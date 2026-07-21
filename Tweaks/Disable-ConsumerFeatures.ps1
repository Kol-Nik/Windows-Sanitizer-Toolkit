# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
if (-not (Test-Path $RegPath)) { New-Item -Path $RegPath -Force | Out-Null }

# Disables automatic installation of suggested apps/games (like Candy Crush, TikTok stubs)
Set-ItemProperty -Path $RegPath -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord

# Disables "Windows Spotlight" ads on the lock screen and personalized tips
Set-ItemProperty -Path $RegPath -Name "DisableSoftLanding" -Value 1 -Type DWord

Write-Output "[+] Consumer bloatware features have been disabled globally."

# Disable Sponsored Apps, Lock Screen Ads, Settings Ads, and Prompts
Write-Host "Disabling Consumer Features, Suggestions, and Ads..." -ForegroundColor Yellow

$CDM = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
$Advanced = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# Ensure registry keys exist before setting values
if (-not (Test-Path $CDM)) { New-Item -Path $CDM -Force | Out-Null }
if (-not (Test-Path $Advanced)) { New-Item -Path $Advanced -Force | Out-Null }

# Lockscreen & Start Suggestions
Set-ItemProperty -Path $CDM -Name "SubscribedContent-338387Enabled" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CDM -Name "SubscribedContent-338388Enabled" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CDM -Name "SubscribedContent-338389Enabled" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CDM -Name "SubscribedContent-310093Enabled" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CDM -Name "SilentInstalledAppsEnabled" -Value 0 -ErrorAction SilentlyContinue

# Settings & Sync Ads
Set-ItemProperty -Path $Advanced -Name "Start_IrisRecommendations" -Value 0 -ErrorAction SilentlyContinue
Set-ItemProperty -Path $Advanced -Name "ShowSyncProviderNotifications" -Value 0 -ErrorAction SilentlyContinue

# Disable MS 365 Ads in Settings Home
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableConsumerAccountStateContent" -Value 1 -ErrorAction SilentlyContinue

# Disable SCOOBE (Finish setup screen)
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Value 0 -ErrorAction SilentlyContinue

Write-Host "Consumer Features and Ads disabled successfully!" -ForegroundColor Green
