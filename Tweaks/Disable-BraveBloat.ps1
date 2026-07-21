# Disable-BraveBloat.ps1
Write-Host "[+] Checking for Brave Browser installation..." -ForegroundColor Cyan

# Check default installation paths for Brave
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

if ($IsBraveInstalled) {
    Write-Host "    [✓] Brave Browser detected. Applying bloat-removal policies..." -ForegroundColor Yellow

    $BravePolicyPath = "HKLM:\SOFTWARE\Policies\BraveSoftware\Brave"

    if (-not (Test-Path $BravePolicyPath)) {
        New-Item -Path $BravePolicyPath -Force | Out-Null
    }

    # 1. Disable Brave AI (Leo)
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveAIChatEnabled" -Value 0 -Type DWord

    # 2. Disable Crypto Wallet
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveWalletDisabled" -Value 1 -Type DWord

    # 3. Disable Brave Rewards
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveRewardsDisabled" -Value 1 -Type DWord

    # 4. Disable Brave News
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveNewsDisabled" -Value 1 -Type DWord

    # 5. Disable Built-In VPN
    Set-ItemProperty -Path $BravePolicyPath -Name "BraveVPNDisabled" -Value 1 -Type DWord

    # 6. Disable IPFS Protocol
    Set-ItemProperty -Path $BravePolicyPath -Name "IPFSEnabled" -Value 0 -Type DWord

    Write-Host "    [✓] Brave bloat policies applied successfully!" -ForegroundColor Green
} else {
    Write-Host "    [-] Brave Browser is not installed. Skipping..." -ForegroundColor Gray
}
