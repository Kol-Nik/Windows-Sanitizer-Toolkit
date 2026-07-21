# ==============================================================================
# Enable Storage Sense Script (Global System Policy)
# Configured to run EVERY WEEK (ideal for large drives like 1TB SSDs/HDDs)
# Requires Administrator Privileges.
# ==============================================================================

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Output "=== Configuring Storage Sense for Weekly Cleanup ==="

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\StorageSense"

# 1. Create registry key path if it does not exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# 2. Enable Storage Sense globally for all users
Set-ItemProperty -Path $RegPath -Name "AllowStorageSenseGlobal" -Value 1 -Type DWord

# 3. Enable automatic cleaning of temporary files
Set-ItemProperty -Path $RegPath -Name "AllowStorageSenseTemporaryFilesCleanup" -Value 1 -Type DWord

# 4. Set frequency cadence: Value 7 = Every week
# (Reference: 1 = Every day, 7 = Every week, 30 = Every month, 0 = During low disk space)
Set-ItemProperty -Path $RegPath -Name "ConfigStorageSenseGlobalCadence" -Value 7 -Type DWord

Write-Output "[+] Storage Sense successfully configured to clean EVERY WEEK for all users!"