# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "=== Checking for Brave Browser Installation ===" -ForegroundColor Yellow

# 1. Define common Brave installation paths
$BravePaths = @(
    "$env:ProgramFiles\BraveSoftware\Brave-Browser\Application\brave.exe",
    "${env:ProgramFiles(x86)}\BraveSoftware\Brave-Browser\Application\brave.exe",
    "$env:LOCALAPPDATA\BraveSoftware\Brave-Browser\Application\brave.exe"
)

# 2. Check if any path exists
$IsBraveInstalled = $false
foreach ($Path in $BravePaths) {
    if (Test-Path $Path) {
        $IsBraveInstalled = $true
        break
    }
}

# 3. Apply policies conditionally
if ($IsBraveInstalled) {
    Write-Host "[+] Brave Browser detected! Applying debloat and policy tweaks..." -ForegroundColor Green
    
    $BravePolicyPath = "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave"
    if (-not (Test-Path $BravePolicyPath)) { New-Item -Path $BravePolicyPath -Force | Out-Null }

    # Disable Brave Built-in Bloat (VPN, Wallet, AI Chat, Rewards, Talk, News)
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveVPNDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveWalletDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveAIChatEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveRewardsDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveTalkDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveNewsDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue

    Write-Host "[+] Brave Browser successfully debloated!" -ForegroundColor Green
} else {
    Write-Host "[-] Brave Browser is not installed on this system. No registry changes were made." -ForegroundColor Gray
}
