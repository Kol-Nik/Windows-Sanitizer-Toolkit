# Disable-TypingAndInkingData.ps1
# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "[+] Disabling Typing & Inking Data Collection (Key/Pen Logging)..." -ForegroundColor Cyan

# 1. Disable Inking & Typing Personalization
$InputPath = "HKCU:\SOFTWARE\Microsoft\InputPersonalization"
if (-not (Test-Path $InputPath)) { New-Item -Path $InputPath -Force | Out-Null }
Set-ItemProperty -Path $InputPath -Name "RestrictImplicitInkCollection" -Value 1 -Type DWord
Set-ItemProperty -Path $InputPath -Name "RestrictImplicitTextCollection" -Value 1 -Type DWord

# 2. Disable Contact Harvesting for spellcheck/autocorrect
$TrainedDataPath = "HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore"
if (-not (Test-Path $TrainedDataPath)) { New-Item -Path $TrainedDataPath -Force | Out-Null }
Set-ItemProperty -Path $TrainedDataPath -Name "HarvestContacts" -Value 0 -Type DWord

# 3. Disable Customer Experience Improvement Program (CEIP) scheduled tasks
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" -ErrorAction SilentlyContinue
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" -ErrorAction SilentlyContinue

Write-Host "    [✓] Inking and typing tracking disabled." -ForegroundColor Green
