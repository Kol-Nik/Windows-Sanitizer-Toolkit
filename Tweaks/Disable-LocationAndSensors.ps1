# Disable-LocationAndSensors.ps1
# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "[+] Completely disabling Windows Location & Physical Sensors..." -ForegroundColor Cyan

# 1. Enforce Global Policy to kill Location Services & Sensors
$PolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors"
if (-not (Test-Path $PolicyPath)) { New-Item -Path $PolicyPath -Force | Out-Null }
Set-ItemProperty -Path $PolicyPath -Name "DisableLocation" -Value 1 -Type DWord
Set-ItemProperty -Path $PolicyPath -Name "DisableLocationScripting" -Value 1 -Type DWord
Set-ItemProperty -Path $PolicyPath -Name "DisableSensors" -Value 1 -Type DWord

# 2. Deny default app access to location (2 = Force Deny)
$AppPrivacyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"
if (-not (Test-Path $AppPrivacyPath)) { New-Item -Path $AppPrivacyPath -Force | Out-Null }
Set-ItemProperty -Path $AppPrivacyPath -Name "LetAppsAccessLocation" -Value 2 -Type DWord

# 3. Disable 'Find My Device' tracking backend
$FindMyDevicePath = "HKLM:\SOFTWARE\Policies\Microsoft\FindMyDevice"
if (-not (Test-Path $FindMyDevicePath)) { New-Item -Path $FindMyDevicePath -Force | Out-Null }
Set-ItemProperty -Path $FindMyDevicePath -Name "AllowFindMyDevice" -Value 0 -Type DWord

# 4. Stop and disable the Geolocation Service (lfsvc)
Get-Service -Name "lfsvc" -ErrorAction SilentlyContinue | Stop-Service -Force -ErrorAction SilentlyContinue
Set-Service -Name "lfsvc" -StartupType Disabled -ErrorAction SilentlyContinue

Write-Host "    [✓] Location tracking and physical sensors locked down." -ForegroundColor Green
