# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Output "=== Removing Native Windows Bloatware ==="

# List of common app packages to safely remove
$BloatApps = @(
    "*Microsoft.BingNews*",
    "*Microsoft.BingWeather*",
    "*Microsoft.GamingApp*",
    "*Microsoft.GetHelp*",
    "*Microsoft.Getstarted*",
    "*Microsoft.MixedReality.Portal*",
    "*Microsoft.MicrosoftSolitaireCollection*",
    "*Microsoft.Office.OneNote*",
    "*Microsoft.People*",
    "*Microsoft.SkypeApp*",
    "*Microsoft.YourPhone*",
    "*Microsoft.ZuneVideo*",
    "*Microsoft.ZuneMusic*",
    "*Xbox*"
)

foreach ($App in $BloatApps) {
    # Remove from current user
    Get-AppxPackage -Name $App -ErrorAction SilentlyContinue | Remove-AppxPackage -ErrorAction SilentlyContinue
    # Remove from system provisioned list (stops them from reinstalling on new user profiles)
    Get-AppxProvisionedPackage -Online | Where-Object {$_.DisplayName -like $App} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    Write-Output "[+] Removed/Provisioned Out: $App"
}

Write-Output "=== Bloatware Purge Complete ==="