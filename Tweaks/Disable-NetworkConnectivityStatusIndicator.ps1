# Disable-NetworkConnectivityStatusIndicator.ps1
# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "[+] Disabling Windows Active Internet Probing (msftconnecttest)..." -ForegroundColor Cyan

# 1. Disable NCSI Active Probing in NLA service
$NcsiPath = "HKLM:\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet"
if (Test-Path $NcsiPath) {
    Set-ItemProperty -Path $NcsiPath -Name "EnableActiveProbing" -Value 0 -Type DWord
}

# 2. Enforce Group Policy rule for NCSI
$NcsiPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator"
if (-not (Test-Path $NcsiPolicyPath)) { New-Item -Path $NcsiPolicyPath -Force | Out-Null }
Set-ItemProperty -Path $NcsiPolicyPath -Name "NoActiveProbe" -Value 1 -Type DWord

Write-Host "    [✓] Windows active connection probing disabled." -ForegroundColor Green
