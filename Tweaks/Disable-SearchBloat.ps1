# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "Disabling Cortana, Web Search, and File Explorer Sidebar Clutter..." -ForegroundColor Yellow

# 1. Disable Cortana & Bing Search Integration
$SearchPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
if (-not (Test-Path $SearchPath)) { New-Item -Path $SearchPath -Force | Out-Null }

Set-ItemProperty -Path $SearchPath -Name "AllowCortana" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $SearchPath -Name "CortanaConsent" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $SearchPath -Name "DisableWebSearch" -Value 1 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path $SearchPath -Name "ConnectedSearchUseWeb" -Value 0 -Type DWord -ErrorAction SilentlyContinue

# 2. Disable Search Box Suggestions
$ExplorerPolicies = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
if (-not (Test-Path $ExplorerPolicies)) { New-Item -Path $ExplorerPolicies -Force | Out-Null }
Set-ItemProperty -Path $ExplorerPolicies -Name "DisableSearchBoxSuggestions" -Value 1 -Type DWord -ErrorAction SilentlyContinue

# 3. Hide Gallery from File Explorer Navigation Pane
$GalleryCLSID = "HKCU:\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}"
if (-not (Test-Path $GalleryCLSID)) { New-Item -Path $GalleryCLSID -Force | Out-Null }
Set-ItemProperty -Path $GalleryCLSID -Name "System.IsPinnedToNameSpaceTree" -Value 0 -Type DWord -ErrorAction SilentlyContinue

# 4. Hide OneDrive from File Explorer Navigation Pane
$OneDriveCLSID = "HKCU:\Software\Classes\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}"
if (-not (Test-Path $OneDriveCLSID)) { New-Item -Path $OneDriveCLSID -Force | Out-Null }
Set-ItemProperty -Path $OneDriveCLSID -Name "System.IsPinnedToNameSpaceTree" -Value 0 -Type DWord -ErrorAction SilentlyContinue

Write-Host "Search bloat, Cortana, and File Explorer sidebar clutter removed!" -ForegroundColor Green
