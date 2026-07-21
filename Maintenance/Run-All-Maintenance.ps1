# Run-All-Maintenance.ps1
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

# Get all .bat files excluding launcher scripts
$MaintFiles = Get-ChildItem -Path $ScriptDir -Filter "*.bat" | Where-Object { $_.Name -ne "Run-All-Maintenance.bat" } | Sort-Object Name

if ($MaintFiles.Count -eq 0) {
    [System.Windows.Forms.MessageBox]::Show("No maintenance scripts (.bat) were found in $ScriptDir", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
    Exit
}

# Clean titles automatically from filenames (e.g., 1-Update-Apps -> Update Apps)
function Format-MaintName ($FileName) {
    $NameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
    # Remove leading numbers and dashes (e.g. "1-" or "01 - ")
    $CleanName = $NameWithoutExt -replace '^\d+[\s\-]*', ''
    # Insert space before capital letters if squished together
    return ($CleanName -creplace '(?<=[a-z])(?=[A-Z])', ' ')
}

# --- Build GUI ---
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Windows Maintenance Suite"
$Form.Size = New-Object System.Drawing.Size(580, 680)
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

# Top Info Label
$TopLabel = New-Object System.Windows.Forms.Label
$TopLabel.Text = "Select which maintenance tasks you would like to run:"
$TopLabel.Location = New-Object System.Drawing.Point(15, 12)
$TopLabel.Size = New-Object System.Drawing.Size(530, 20)
$Form.Controls.Add($TopLabel)

# Main TreeView
$TreeView = New-Object System.Windows.Forms.TreeView
$TreeView.Location = New-Object System.Drawing.Point(15, 38)
$TreeView.Size = New-Object System.Drawing.Size(535, 450)
$TreeView.CheckBoxes = $true

# Populate TreeView dynamically from directory files
$RootNode = $TreeView.Nodes.Add("All Maintenance Tasks")
$RootNode.Tag = "Root"

foreach ($File in $MaintFiles) {
    $FriendlyTitle = Format-MaintName -FileName $File.Name
    $Node = $RootNode.Nodes.Add("$($File.Name) - $FriendlyTitle")
    $Node.Tag = $File.FullName
    $Node.Checked = $false  # Default unchecked for safer selective running
}

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

# System Restore Point Checkbox
$RestorePointChk = New-Object System.Windows.Forms.CheckBox
$RestorePointChk.Text = "Create System Restore Point before running tasks"
$RestorePointChk.Location = New-Object System.Drawing.Point(15, 500)
$RestorePointChk.Size = New-Object System.Drawing.Size(535, 24)
$RestorePointChk.Checked = $true
$Form.Controls.Add($RestorePointChk)

# Select All Button
$SelectAllBtn = New-Object System.Windows.Forms.Button
$SelectAllBtn.Text = "Select All"
$SelectAllBtn.Location = New-Object System.Drawing.Point(15, 570)
$SelectAllBtn.Size = New-Object System.Drawing.Size(100, 32)
$SelectAllBtn.add_Click({
    $RootNode.Checked = $true
    foreach ($Node in $RootNode.Nodes) { $Node.Checked = $true }
})
$Form.Controls.Add($SelectAllBtn)

# Deselect All Button
$DeselectAllBtn = New-Object System.Windows.Forms.Button
$DeselectAllBtn.Text = "Deselect All"
$DeselectAllBtn.Location = New-Object System.Drawing.Point(125, 570)
$DeselectAllBtn.Size = New-Object System.Drawing.Size(100, 32)
$DeselectAllBtn.add_Click({
    $RootNode.Checked = $false
    foreach ($Node in $RootNode.Nodes) { $Node.Checked = $false }
})
$Form.Controls.Add($DeselectAllBtn)

# Run Button
$RunBtn = New-Object System.Windows.Forms.Button
$RunBtn.Text = "Run Selected Maintenance"
$RunBtn.Location = New-Object System.Drawing.Point(345, 570)
$RunBtn.Size = New-Object System.Drawing.Size(205, 32)
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
        Write-Host "        Executing Selected Maintenance Tasks        " -ForegroundColor Green
        Write-Host "===================================================" -ForegroundColor Green
        Write-Host ""

        # Handle System Restore Point creation if checked
        if ($RestorePointChk.Checked) {
            Write-Host "[+] Creating System Restore Point..." -ForegroundColor Cyan
            try {
                Enable-ComputerRestore -Drive "$env:SystemDrive" -ErrorAction SilentlyContinue
                Checkpoint-Computer -Description "Pre-Maintenance System Checkpoint" -RestorePointType "MODIFY_SETTINGS" -ErrorAction Stop
                Write-Host "    [✓] Restore Point created successfully." -ForegroundColor Green
            } catch {
                Write-Host "    (!) Could not create Restore Point: $_" -ForegroundColor Yellow
            }
            Write-Host ""
        }

        foreach ($ScriptPath in $SelectedScripts) {
            $ScriptName = [System.IO.Path]::GetFileName($ScriptPath)
            Write-Host "[+] Launching Task: $ScriptName..." -ForegroundColor Cyan
            
            try {
                # Launch batch file synchronously and wait for exit
                Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$ScriptPath`"" -Wait -NoNewWindow
            } catch {
                Write-Host "    (!) Error executing $ScriptName : $_" -ForegroundColor Red
            }
            Write-Host ""
        }

        Write-Host "===================================================" -ForegroundColor Green
        Write-Host "     All Selected Maintenance Tasks Completed!      " -ForegroundColor Green
        Write-Host "===================================================" -ForegroundColor Green
    } else {
        Write-Host "`n[!] No tasks were selected. Exiting without making changes." -ForegroundColor Yellow
    }
} else {
    Write-Host "`n[!] Operation cancelled." -ForegroundColor Gray
}

Write-Host "`nPress any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
