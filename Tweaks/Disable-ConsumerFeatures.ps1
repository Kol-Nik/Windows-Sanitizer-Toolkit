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