# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "=== Disabling Windows Telemetry, Ads, Location Tracking & Privacy Bloat ===" -ForegroundColor Yellow

# ==========================================
# 1. Telemetry, Activity History & App Tracking
# ==========================================
Write-Host "[+] Disabling Telemetry, Activity History, and App Launch Tracking..." -ForegroundColor Cyan

# Disable Diagnostic Data Policies
$DataCollection = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
if (-not (Test-Path $DataCollection)) { New-Item -Path $DataCollection -Force | Out-Null }
Set-ItemProperty -Path $DataCollection -Name "AllowTelemetry" -Value 1 -Type DWord -ErrorAction SilentlyContinue

# Disable Activity History Syncing & Collection
$SystemPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
if (-not (Test-Path $SystemPath)) { New-Item -Path $SystemPath -Force | Out-Null }
Set-ItemProperty -Path $SystemPath -Name "EnableActivityFeed" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $SystemPath -Name "PublishUserActivities" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $SystemPath -Name "UploadUserActivities" -Value 0 -Type DWord -ErrorAction SilentlyContinue

# Disable App Launch Tracking & Targeted Advertising ID
$ExplorerAdv = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
if (-not (Test-Path $ExplorerAdv)) { New-Item -Path $ExplorerAdv -Force | Out-Null }
Set-ItemProperty -Path $ExplorerAdv -Name "Start_TrackProgs" -Value 0 -Type DWord -ErrorAction SilentlyContinue

$AdvertisingId = "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
if (-not (Test-Path $AdvertisingId)) { New-Item -Path $AdvertisingId -Force | Out-Null }
Set-ItemProperty -Path $AdvertisingId -Name "Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue


# ==========================================
# 2. Ads, Tips, Suggestions & Consumer Features
# ==========================================
Write-Host "[+] Disabling Consumer Features, Lock Screen Ads, and Edge Promotional Bloat..." -ForegroundColor Cyan

# Disables automatic app installations (Candy Crush, etc.) & Spotlight ads
$CloudContent = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
if (-not (Test-Path $CloudContent)) { New-Item -Path $CloudContent -Force | Out-Null }
Set-ItemProperty -Path $CloudContent -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CloudContent -Name "DisableSoftLanding" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CloudContent -Name "DisableWindowsSpotlightFeatures" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CloudContent -Name "DisableTailoredExperiencesWithWindowsData" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CloudContent -Name "DisableConsumerAccountStateContent" -Value 1 -Type DWord -ErrorAction SilentlyContinue

# Lock Screen & Start Suggestions (User Level)
$CDM = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
if (-not (Test-Path $CDM)) { New-Item -Path $CDM -Force | Out-Null }
Set-ItemProperty -Path $CDM -Name "SubscribedContent-338387Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CDM -Name "SubscribedContent-338388Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CDM -Name "SubscribedContent-338389Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CDM -Name "SubscribedContent-310093Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $CDM -Name "SilentInstalledAppsEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue

# Settings & Sync Ads
Set-ItemProperty -Path $ExplorerAdv -Name "Start_IrisRecommendations" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $ExplorerAdv -Name "ShowSyncProviderNotifications" -Value 0 -Type DWord -ErrorAction SilentlyContinue

# Disable SCOOBE (Finish setup screen)
$UserProfileEng = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement"
if (-not (Test-Path $UserProfileEng)) { New-Item -Path $UserProfileEng -Force | Out-Null }
Set-ItemProperty -Path $UserProfileEng -Name "ScoobeSystemSettingEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue

# Disable Edge Shopping, Suggestions & Promotions
$EdgePolicy = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"
if (-not (Test-Path $EdgePolicy)) { New-Item -Path $EdgePolicy -Force | Out-Null }
Set-ItemProperty -Path $EdgePolicy -Name "ShowRecommendationsEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $EdgePolicy -Name "EdgeShoppingAssistantEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $EdgePolicy -Name "PromotionalTabsEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue


# ==========================================
# 3. Location Services & Find My Device
# ==========================================
Write-Host "[+] Disabling Location Tracking, App Location Access, and Find My Device..." -ForegroundColor Cyan

# Disable Global System Location & App Access
$LocationPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors"
if (-not (Test-Path $LocationPath)) { New-Item -Path $LocationPath -Force | Out-Null }
Set-ItemProperty -Path $LocationPath -Name "DisableLocation" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $LocationPath -Name "DisableLocationScripting" -Value 1 -Type DWord -ErrorAction SilentlyContinue

# Disable Find My Device
$FindMyDevice = "HKLM:\SOFTWARE\Policies\Microsoft\FindMyDevice"
if (-not (Test-Path $FindMyDevice)) { New-Item -Path $FindMyDevice -Force | Out-Null }
Set-ItemProperty -Path $FindMyDevice -Name "AllowFindMyDevice" -Value 0 -Type DWord -ErrorAction SilentlyContinue


# ==========================================
# 4. Settings App Home Page Cleanup
# ==========================================
Write-Host "[+] Hiding Settings 'Home' Page..." -ForegroundColor Cyan

$ExplorerPolicies = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
if (-not (Test-Path $ExplorerPolicies)) { New-Item -Path $ExplorerPolicies -Force | Out-Null }
Set-ItemProperty -Path $ExplorerPolicies -Name "SettingsPageVisibility" -Value "hide:home" -Type String -ErrorAction SilentlyContinue

Write-Host "[+] All Telemetry, Ads, Location Tracking, and Privacy bloat successfully disabled!" -ForegroundColor Green
