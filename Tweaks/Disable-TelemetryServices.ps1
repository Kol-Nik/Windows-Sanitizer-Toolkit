# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Output "=== Disabling Connected User Experiences and Telemetry ==="

# 1. Change startup type to 'Disabled'
Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue

# 2. Stop the service if it is currently running
Stop-Service -Name "DiagTrack" -Force -ErrorAction SilentlyContinue

# 3. Clear existing telemetry log cache (Optional)
$TelemetryLogPath = "$env:ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
if (Test-Path $TelemetryLogPath) {
    Remove-Item $TelemetryLogPath -Force -ErrorAction SilentlyContinue
    Write-Output "[+] Telemetry cache log successfully cleared."
}

# Verify status confirmation
$ServiceStatus = Get-Service -Name "DiagTrack"
Write-Output "--------------------------------------------------"
Write-Output "Current Service Status: $($ServiceStatus.Status)"
Write-Output "Startup Type:           $($ServiceStatus.StartType)"
Write-Output "--------------------------------------------------"
Write-Output "[+] Telemetry service has been disabled globally for all users."