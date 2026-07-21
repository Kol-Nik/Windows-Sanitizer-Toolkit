# Disable-OneDrive.ps1
Write-Host "[+] Disabling and Uninstalling Microsoft OneDrive..." -ForegroundColor Cyan

# 1. Stop active OneDrive processes
Get-Process -Name "OneDrive", "OneDriveStandaloneUpdater" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

# 2. Trigger native uninstaller
$OneDriveSystem32 = "$env:SystemRoot\System32\OneDriveSetup.exe"
$OneDriveSysWOW64 = "$env:SystemRoot\SysWOW64\OneDriveSetup.exe"

if (Test-Path $OneDriveSysWOW64) {
    Write-Host "    -> Running 64-bit uninstaller..." -ForegroundColor Gray
    Start-Process -FilePath $OneDriveSysWOW64 -ArgumentList "/uninstall" -Wait -WindowStyle Hidden
} elseif (Test-Path $OneDriveSystem32) {
    Write-Host "    -> Running 32-bit uninstaller..." -ForegroundColor Gray
    Start-Process -FilePath $OneDriveSystem32 -ArgumentList "/uninstall" -Wait -WindowStyle Hidden
}

# 3. Disable OneDrive via Group Policy Registry setting
$GroupPolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"
if (-not (Test-Path $GroupPolicyPath)) {
    New-Item -Path $GroupPolicyPath -Force | Out-Null
}
Set-ItemProperty -Path $GroupPolicyPath -Name "DisableFileSyncNGSC" -Value 1 -Type DWord

# 4. Remove OneDrive from File Explorer Navigation Pane
$ExplorerPaths = @(
    "HKCR:\CLSID\{018D5C66-453A-4307-9B53-224DE2ED1FE6}",
    "HKCR:\Wow6432Node\CLSID\{018D5C66-453A-4307-9B53-224DE2ED1FE6}"
)
foreach ($Path in $ExplorerPaths) {
    if (Test-Path $Path) {
        Set-ItemProperty -Path $Path -Name "System.IsPinnedToNameSpaceTree" -Value 0 -ErrorAction SilentlyContinue
    }
}

# 5. Clean up residual folders
$ResidualFolders = @(
    "$env:LocalAppData\Microsoft\OneDrive",
    "$env:ProgramData\Microsoft OneDrive"
)
foreach ($Folder in $ResidualFolders) {
    if (Test-Path $Folder) {
        Remove-Item -Path $Folder -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "    [✓] OneDrive successfully uninstalled and disabled." -ForegroundColor Green
