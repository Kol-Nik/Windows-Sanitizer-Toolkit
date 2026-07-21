# Disable-BraveBloat.ps1

# 1. Admin Privilege Check
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Write-Host "[+] Checking for Brave Browser installation..." -ForegroundColor Cyan

# 2. Check default installation paths
$BravePaths = @(
    "${env:ProgramFiles}\BraveSoftware\Brave-Browser\Application\brave.exe",
    "${env:ProgramFiles(x86)}\BraveSoftware\Brave-Browser\Application\brave.exe",
    "${env:LocalAppData}\BraveSoftware\Brave-Browser\Application\brave.exe"
)

$IsBraveInstalled = $false
foreach ($Path in $BravePaths) {
    if (Test-Path $Path) {
        $IsBraveInstalled = $true
        break
    }
}

# 3. Apply all policy tweaks if installed
if ($IsBraveInstalled) {
    Write-Host "    [✓] Brave Browser detected. Applying bloat-removal policies..." -ForegroundColor Yellow

    $BravePolicyPath = "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave"
    if (-not (Test-Path $BravePolicyPath)) { 
        New-Item -Path $BravePolicyPath -Force | Out-Null 
    }

    # Policies: Disable VPN, Wallet, AI Chat (Leo), Rewards, Talk, News, & IPFS
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveVPNDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveWalletDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveAIChatEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveRewardsDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveTalkDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveNewsDisabled" -Value 1 -Type DWord -ErrorAction SilentlyContinue
    Set-ItemProperty -Path $BravePolicyPath -Name "IPFSEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue

    Write-Host "    [✓] Brave bloat policies applied successfully!" -ForegroundColor Green
} else {
    Write-Host "    [-] Brave Browser is not installed. Skipping..." -ForegroundColor Gray
}
