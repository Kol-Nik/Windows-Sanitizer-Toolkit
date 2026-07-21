# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "=== Disabling Windows Consumer Features & Spotlight Bloat ===" -ForegroundColor Yellow

$CloudContent = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
if (-not (Test-Path $CloudContent)) { New-Item -Path $CloudContent -Force | Out-Null }

# Disables automatic background installation of suggested consumer apps/games
Set-ItemProperty -Path $CloudContent -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord -ErrorAction SilentlyContinue

# Disables Windows Spotlight experiences
Set-ItemProperty -Path $CloudContent -Name "DisableWindowsSpotlightFeatures" -Value 1 -Type DWord -ErrorAction SilentlyContinue

Write-Host "[+] Consumer features and Spotlight bloat disabled successfully!" -ForegroundColor Green
