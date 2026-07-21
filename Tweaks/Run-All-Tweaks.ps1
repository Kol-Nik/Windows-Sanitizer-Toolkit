# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Requesting Administrator Privileges..."
    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Script Scanner & Metadata Mapper ---
$ScriptDir = $PSScriptRoot
if (-not $ScriptDir) { $ScriptDir = Get-Location }

# Get all .ps1 files excluding this runner script itself
$TweakFiles = Get-ChildItem -Path $ScriptDir -Filter "*.ps1" | Where-Object { $_.Name -ne "Run-All-Tweaks.ps1" }

if ($TweakFiles.Count -eq 0) {
    [System.Windows.Forms.MessageBox]::Show("No tweak scripts (.ps1) were found in $ScriptDir", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    Exit
}

# Map clean titles and descriptions automatically
function Format-TweakName ($FileName) {
    $NameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
    # Inserts space before capital letters (e.g. DisablePrivacyAndAds -> Disable Privacy And Ads)
    return ($NameWithoutExt -creplace '(?<=[a-z])(?=[A-Z])', ' ')
}

# --- Build GUI ---
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Windows Debloat & Tweaks Engine"
$Form.Size = New-Object System.Drawing.Size(580, 640)
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

# Top Info Label
$TopLabel = New-Object System.Windows.Forms.Label
$TopLabel.Text = "Select which tweak modules you would like to execute:"
$TopLabel.Location = New-Object System.Drawing.Point(15, 12)
$TopLabel.Size = New-Object System.Drawing.Size(530, 20)
$Form.Controls.Add($TopLabel)

# Main TreeView
$TreeView = New-Object System.Windows.Forms.TreeView
$TreeView.Location = New-Object System.Drawing.Point(15, 38)
$TreeView.Size = New-Object System.Drawing.Size(535, 480)
$TreeView.CheckBoxes = $true

# Populate TreeView dynamically from directory files
$RootNode = $TreeView.Nodes.Add("All System Tweaks")
$RootNode.Tag = "Root"

foreach ($File in $TweakFiles) {
    $FriendlyTitle = Format-TweakName -FileName $File.Name
    $Node = $RootNode.Nodes.Add($FriendlyTitle)
    $Node.Tag = $File.FullName
    $Node.Checked = $true  # Default to selected
}

$RootNode.Checked = $true
$RootNode.Expand()
$Form.Controls.Add($TreeView)

# Check/Uncheck logic sync
$TreeView.add_AfterCheck({
    param($sender, $e)
    if ($e.Node.Tag -eq "Root") {
        foreach ($ChildNode in $e.Node.Nodes) {
            $ChildNode.Checked = $e.Node.Checked
        }
    }
})

# Select All Button
$SelectAllBtn = New-Object System.Windows.Forms.Button
$SelectAllBtn.Text = "Select All"
$SelectAllBtn.Location = New-Object System.Drawing.Point(15, 530)
$SelectAllBtn.Size = New-Object System.Drawing.Size(100, 32)
$SelectAllBtn.add_Click({
    $RootNode.Checked = $true
    foreach ($Node in $RootNode.Nodes) { $Node.Checked = $true }
})
$Form.Controls.Add($SelectAllBtn)

# Deselect All Button
$DeselectAllBtn = New-Object System.Windows.Forms.Button
$DeselectAllBtn.Text = "Deselect All"
$DeselectAllBtn.Location = New-Object System.Drawing.Point(125, 530)
$DeselectAllBtn.Size = New-Object System.Drawing.Size(100, 32)
$DeselectAllBtn.add_Click({
    $RootNode.Checked = $false
    foreach ($Node in $RootNode.Nodes) { $Node.Checked = $false }
})
$Form.Controls.Add($DeselectAllBtn)

# Run Tweaks Button
$RunBtn = New-Object System.Windows.Forms.Button
$RunBtn.Text = "Run Selected Tweaks"
$RunBtn.Location = New-Object System.Drawing.Point(365, 530)
$RunBtn.Size = New-Object System.Drawing.Size(185, 32)
$RunBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$Form.Controls.Add($RunBtn)

# Show Window
$Result = $Form.ShowDialog()

# --- Execution Engine ---
if ($Result -eq [System.Windows.Forms.DialogResult]::OK) {
    $SelectedScripts = @()

    foreach ($Node in $RootNode.Nodes) {
        if ($Node.Checked) {
            $SelectedScripts += $Node.Tag
        }
    }

    if ($SelectedScripts.Count -gt 0) {
        Clear-Host
        Write-Host "===================================================" -ForegroundColor Green
        Write-Host "       Executing Selected Tweaks & Debloat          " -ForegroundColor Green
        Write-Host "===================================================" -ForegroundColor Green
        Write-Host ""

        foreach ($ScriptPath in $SelectedScripts) {
            $ScriptName = [System.IO.Path]::GetFileName($ScriptPath)
            Write-Host "[+] Running: $ScriptName..." -ForegroundColor Cyan
            
            try {
                & $ScriptPath
            } catch {
                Write-Host "    (!) Error executing $ScriptName : $_" -ForegroundColor Red
            }
            Write-Host ""
        }

        Write-Host "===================================================" -ForegroundColor Green
        Write-Host "   All Selected System Tweaks Applied Successfully! " -ForegroundColor Green
        Write-Host "===================================================" -ForegroundColor Green
    } else {
        Write-Host "`n[!] No tweaks were selected. Exiting without making changes." -ForegroundColor Yellow
    }
} else {
    Write-Host "`n[!] Operation cancelled." -ForegroundColor Gray
}

Write-Host "`nPress any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
