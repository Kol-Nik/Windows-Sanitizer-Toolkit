# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Output "=== Disabling Cortana and Web/Bing Search ==="

$SearchPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
if (-not (Test-Path $SearchPath)) { New-Item -Path $SearchPath -Force | Out-Null }

# Disables Cortana completely
Set-ItemProperty -Path $SearchPath -Name "AllowCortana" -Value 0 -Type DWord

# Stops web search results (Bing) in the local Start Menu search bar
Set-ItemProperty -Path $SearchPath -Name "DisableWebSearch" -Value 1 -Type DWord
Set-ItemProperty -Path $SearchPath -Name "ConnectedSearchUseWeb" -Value 0 -Type DWord

Write-Output "[+] Local search cleared of ads and Bing web results!"