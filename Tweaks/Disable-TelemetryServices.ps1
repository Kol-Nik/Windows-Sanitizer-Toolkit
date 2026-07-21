# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "=== Managing Telemetry Services and Delivery Optimization ===" -ForegroundColor Yellow

# 1. Disable and stop DiagTrack (Connected User Experiences and Telemetry) service
Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
Stop-Service -Name "DiagTrack" -Force -ErrorAction SilentlyContinue

# 2. Clear existing telemetry log cache
$TelemetryLogPath = "$env:ProgramData\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"
if (Test-Path $TelemetryLogPath) {
    Remove-Item $TelemetryLogPath -Force -ErrorAction SilentlyContinue
    Write-Host "[+] Telemetry cache log successfully cleared." -ForegroundColor Green
}

# 3. Disable Delivery Optimization P2P Uploads (Stops background bandwidth usage)
$DeliveryOptPath = "HKU:\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings"
if (-not (Test-Path $DeliveryOptPath)) { New-Item -Path $DeliveryOptPath -Force | Out-Null }
Set-ItemProperty -Path $DeliveryOptPath -Name "DownloadMode" -Value 0 -Type DWord -ErrorAction SilentlyContinue

# Verify DiagTrack status
$ServiceStatus = Get-Service -Name "DiagTrack"
Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "Current Telemetry Service Status: $($ServiceStatus.Status)" -ForegroundColor Cyan
Write-Host "Startup Type:                   $($ServiceStatus.StartType)" -ForegroundColor Cyan
Write-Host "--------------------------------------------------" -ForegroundColor Cyan
Write-Host "[+] Background telemetry service and P2P uploads stopped!" -ForegroundColor Green
