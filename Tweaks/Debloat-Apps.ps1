# Requires Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run PowerShell as Administrator!"
    Break
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- Master App Roster (Categorized) ---
$AppCategories = [ordered]@{
    "Games & Third-Party Bloat" = @(
        @{ Name = "Amazon"; Package = "*Amazon.com.Amazon*" }
        @{ Name = "Asphalt 8"; Package = "*Asphalt8Airborne*" }
        @{ Name = "Bubble Witch 3"; Package = "*king.com.BubbleWitch3Saga*" }
        @{ Name = "Caesars Slots"; Package = "*CaesarsSlotsFreeCasino*" }
        @{ Name = "Candy Crush Saga"; Package = "*king.com.CandyCrushSaga*" }
        @{ Name = "Candy Crush Soda"; Package = "*king.com.CandyCrushSodaSaga*" }
        @{ Name = "Cooking Fever"; Package = "*COOKINGFEVER*" }
        @{ Name = "Disney Magic Kingdoms"; Package = "*DisneyMagicKingdoms*" }
        @{ Name = "Disney+"; Package = "*Disney.37853FC22B2CE*" }
        @{ Name = "Duolingo"; Package = "*Duolingo-LearnLanguagesforFree*" }
        @{ Name = "Facebook"; Package = "*FACEBOOK.FACEBOOK*" }
        @{ Name = "FarmVille 2"; Package = "*FarmVille2CountryEscape*" }
        @{ Name = "Flipboard"; Package = "*Flipboard*" }
        @{ Name = "Hidden City"; Package = "*HiddenCity*" }
        @{ Name = "Hulu"; Package = "*HULULLC.HULUPLUS*" }
        @{ Name = "iHeartRadio"; Package = "*iHeartRadio*" }
        @{ Name = "Instagram"; Package = "*Facebook.Instagram*" }
        @{ Name = "March of Empires"; Package = "*MarchofEmpires*" }
        @{ Name = "Netflix"; Package = "*4DF9E0F8.Netflix*" }
        @{ Name = "NYT Crossword"; Package = "*NYTCrossword*" }
        @{ Name = "Pandora"; Package = "*PandoraMediaInc*" }
        @{ Name = "Phototastic Collage"; Package = "*PhototasticCollage*" }
        @{ Name = "PicsArt"; Package = "*PicsArt-PhotoStudio*" }
        @{ Name = "Polarr Photo Editor"; Package = "*PolarrPhotoEditorAcademicEdition*" }
        @{ Name = "Prime Video"; Package = "*AmazonVideo.PrimeVideo*" }
        @{ Name = "Royal Revolt"; Package = "*flaregamesGmbH.RoyalRevolt*" }
        @{ Name = "Sling TV"; Package = "*SlingTV*" }
        @{ Name = "Spotify"; Package = "*SpotifyAB.SpotifyMusic*" }
        @{ Name = "TikTok"; Package = "*BytedancePte.Ltd.TikTok*" }
        @{ Name = "TuneIn Radio"; Package = "*TuneInRadio*" }
        @{ Name = "WinZip"; Package = "*WinZipUniversal*" }
    )
    "Legacy & Bing Services" = @(
        @{ Name = "Bing Finance"; Package = "*Microsoft.BingFinance*" }
        @{ Name = "Bing Food & Drink"; Package = "*Microsoft.BingFoodAndDrink*" }
        @{ Name = "Bing Health & Fitness"; Package = "*Microsoft.BingHealthAndFitness*" }
        @{ Name = "Bing News"; Package = "*Microsoft.BingNews*" }
        @{ Name = "Bing Search"; Package = "*Microsoft.BingSearch*" }
        @{ Name = "Bing Sports"; Package = "*Microsoft.BingSports*" }
        @{ Name = "Bing Translator"; Package = "*Microsoft.BingTranslator*" }
        @{ Name = "Bing Travel"; Package = "*Microsoft.BingTravel*" }
        @{ Name = "Bing Weather"; Package = "*Microsoft.BingWeather*" }
        @{ Name = "Cortana"; Package = "*Microsoft.549981C3F5F10*" }
        @{ Name = "Mail & Calendar"; Package = "*Microsoft.windowscommunicationsapps*" }
        @{ Name = "Messaging"; Package = "*Microsoft.Messaging*" }
        @{ Name = "Microsoft News"; Package = "*Microsoft.News*" }
        @{ Name = "People"; Package = "*Microsoft.People*" }
    )
    "OEM Pre-installs (HP, Dell, Lenovo, LG)" = @(
        @{ Name = "Actipro Software"; Package = "*ActiproSoftwareLLC*" }
        @{ Name = "CyberLink Media Suite"; Package = "*CyberLinkMediaSuiteEssentials*" }
        @{ Name = "Dell Digital Delivery"; Package = "*DellInc.DellDigitalDelivery*" }
        @{ Name = "Dell Mobile Connect"; Package = "*DellInc.DellMobileConnect*" }
        @{ Name = "Dell SupportAssist"; Package = "*DellInc.DellSupportAssistforPCs*" }
        @{ Name = "Eclipse Manager"; Package = "*EclipseManager*" }
        @{ Name = "HP AI Experience Center"; Package = "*AD2F1837.HPAIExperienceCenter*" }
        @{ Name = "HP Connected Music"; Package = "*AD2F1837.HPConnectedMusic*" }
        @{ Name = "HP Connected Photo"; Package = "*AD2F1837.HPConnectedPhotopoweredbySnapfish*" }
        @{ Name = "HP Desktop Support"; Package = "*AD2F1837.HPDesktopSupportUtilities*" }
        @{ Name = "HP Easy Clean"; Package = "*AD2F1837.HPEasyClean*" }
        @{ Name = "HP File Viewer"; Package = "*AD2F1837.HPFileViewer*" }
        @{ Name = "HP JumpStarts"; Package = "*AD2F1837.HPJumpStarts*" }
        @{ Name = "HP PC Hardware Diagnostics"; Package = "*AD2F1837.HPPCHardwareDiagnosticsWindows*" }
        @{ Name = "HP Power Manager"; Package = "*AD2F1837.HPPowerManager*" }
        @{ Name = "HP Printer Control"; Package = "*AD2F1837.HPPrinterControl*" }
        @{ Name = "HP Privacy Settings"; Package = "*AD2F1837.HPPrivacySettings*" }
        @{ Name = "HP QuickDrop"; Package = "*AD2F1837.HPQuickDrop*" }
        @{ Name = "HP QuickTouch"; Package = "*AD2F1837.HPQuickTouch*" }
        @{ Name = "HP Registration"; Package = "*AD2F1837.HPRegistration*" }
        @{ Name = "HP Support Assistant"; Package = "*AD2F1837.HPSupportAssistant*" }
        @{ Name = "HP Sure Shield AI"; Package = "*AD2F1837.HPSureShieldAI*" }
        @{ Name = "HP System Information"; Package = "*AD2F1837.HPSystemInformation*" }
        @{ Name = "HP Welcome"; Package = "*AD2F1837.HPWelcome*" }
        @{ Name = "HP WorkWell"; Package = "*AD2F1837.HPWorkWell*" }
        @{ Name = "myHP"; Package = "*AD2F1837.myHP*" }
        @{ Name = "Lenovo Vantage"; Package = "*E046963F.LenovoCompanion*" }
        @{ Name = "Lenovo Vantage Service"; Package = "*LenovoCompanyLimited.LenovoVantageService*" }
        @{ Name = "LG Monitor App"; Package = "*LGElectronics.LGMonitorApp*" }
    )
    "3D & Creative Utilities" = @(
        @{ Name = "3D Builder"; Package = "*Microsoft.3DBuilder*" }
        @{ Name = "3D Viewer"; Package = "*Microsoft.Microsoft3DViewer*" }
        @{ Name = "ACG Media Player"; Package = "*ACGMediaPlayer*" }
        @{ Name = "Adobe Photoshop Express"; Package = "*AdobeSystemsIncorporated.AdobePhotoshopExpress*" }
        @{ Name = "Autodesk SketchBook"; Package = "*AutodeskSketchBook*" }
        @{ Name = "Clipchamp"; Package = "*Clipchamp.Clipchamp*" }
        @{ Name = "Drawboard PDF"; Package = "*DrawboardPDF*" }
        @{ Name = "Live Wallpaper"; Package = "*Sidia.LiveWallpaper*" }
        @{ Name = "Paint 3D"; Package = "*Microsoft.MSPaint*" }
        @{ Name = "Print 3D"; Package = "*Microsoft.Print3D*" }
    )
    "Productivity & Office Apps" = @(
        @{ Name = "Microsoft 365 Companions"; Package = "*Microsoft.M365Companions*" }
        @{ Name = "Microsoft Journal"; Package = "*Microsoft.MicrosoftJournal*" }
        @{ Name = "Office Hub"; Package = "*Microsoft.MicrosoftOfficeHub*" }
        @{ Name = "One Calendar"; Package = "*OneCalendar*" }
        @{ Name = "One Connect"; Package = "*Microsoft.OneConnect*" }
        @{ Name = "OneDrive"; Package = "*Microsoft.OneDrive*" }
        @{ Name = "OneNote"; Package = "*Microsoft.Office.OneNote*" }
        @{ Name = "Outlook for Windows"; Package = "*Microsoft.OutlookForWindows*" }
        @{ Name = "Power Automate"; Package = "*Microsoft.PowerAutomateDesktop*" }
        @{ Name = "Power BI"; Package = "*Microsoft.MicrosoftPowerBIForWindows*" }
        @{ Name = "Sway"; Package = "*Microsoft.Office.Sway*" }
        @{ Name = "To Do"; Package = "*Microsoft.Todos*" }
        @{ Name = "Whiteboard"; Package = "*Microsoft.Whiteboard*" }
    )
    "AI & Communication Tools" = @(
        @{ Name = "Copilot+ AI Hub"; Package = "*Microsoft.Windows.AIHub*" }
        @{ Name = "Microsoft Copilot"; Package = "*XP9CXNGPPJ97XX*" }
        @{ Name = "Family Safety"; Package = "*MicrosoftCorporationII.MicrosoftFamily*" }
        @{ Name = "Feedback Hub"; Package = "*Microsoft.WindowsFeedbackHub*" }
        @{ Name = "LinkedIn"; Package = "*LinkedInforWindows*" }
        @{ Name = "Microsoft Teams (New)"; Package = "*MSTeams*" }
        @{ Name = "Microsoft Teams (Old)"; Package = "*MicrosoftTeams*" }
        @{ Name = "Skype (UWP)"; Package = "*Microsoft.SkypeApp*" }
    )
    "Mixed Reality & Xbox" = @(
        @{ Name = "Mixed Reality Portal"; Package = "*Microsoft.MixedReality.Portal*" }
        @{ Name = "Xbox Console Companion"; Package = "*Microsoft.XboxApp*" }
        @{ Name = "Xbox Game Overlay"; Package = "*Microsoft.XboxGameOverlay*" }
    )
}

# --- Build GUI ---
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "Windows App Debloater - Custom App Selection"
$Form.Size = New-Object System.Drawing.Size(560, 680)
$Form.StartPosition = "CenterScreen"
$Form.FormBorderStyle = "FixedDialog"
$Form.MaximizeBox = $false

# Top Info Label
$TopLabel = New-Object System.Windows.Forms.Label
$TopLabel.Text = "Expand categories and check individual apps to remove:"
$TopLabel.Location = New-Object System.Drawing.Point(15, 10)
$TopLabel.Size = New-Object System.Drawing.Size(500, 20)
$Form.Controls.Add($TopLabel)

# Main TreeView with Checkboxes
$TreeView = New-Object System.Windows.Forms.TreeView
$TreeView.Location = New-Object System.Drawing.Point(15, 35)
$TreeView.Size = New-Object System.Drawing.Size(515, 540)
$TreeView.CheckBoxes = $true

# Populate TreeView
foreach ($CategoryName in $AppCategories.Keys) {
    $CategoryNode = $TreeView.Nodes.Add($CategoryName)
    $CategoryNode.Tag = "Category"
    
    foreach ($App in $AppCategories[$CategoryName]) {
        $AppNode = $CategoryNode.Nodes.Add($App.Name)
        $AppNode.Tag = $App.Package
    }
}

$TreeView.ExpandAll()
$Form.Controls.Add($TreeView)

# Automatically check/uncheck child nodes when parent node is toggled
$TreeView.add_AfterCheck({
    param($sender, $e)
    if ($e.Node.Tag -eq "Category") {
        foreach ($ChildNode in $e.Node.Nodes) {
            $ChildNode.Checked = $e.Node.Checked
        }
    }
})

# Uninstall Button
$UninstallBtn = New-Object System.Windows.Forms.Button
$UninstallBtn.Text = "Uninstall Selected Apps"
$UninstallBtn.Location = New-Object System.Drawing.Point(345, 590)
$UninstallBtn.Size = New-Object System.Drawing.Size(185, 35)
$UninstallBtn.DialogResult = [System.Windows.Forms.DialogResult]::OK
$Form.Controls.Add($UninstallBtn)

# Show Form
$Result = $Form.ShowDialog()

# --- Process Selected Packages ---
if ($Result -eq [System.Windows.Forms.DialogResult]::OK) {
    $SelectedPackages = @()

    foreach ($CategoryNode in $TreeView.Nodes) {
        foreach ($AppNode in $CategoryNode.Nodes) {
            if ($AppNode.Checked) {
                $SelectedPackages += $AppNode.Tag
            }
        }
    }

    if ($SelectedPackages.Count -gt 0) {
        Write-Host "`nStarting uninstallation of $($SelectedPackages.Count) selected app(s)..." -ForegroundColor Yellow

        foreach ($PackagePattern in $SelectedPackages) {
            # 1. Deprovision system package (Prevents reinstallation for future accounts)
            $Provisioned = Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like $PackagePattern -or $_.PackageName -like $PackagePattern }
            if ($Provisioned) {
                foreach ($ProvPkg in $Provisioned) {
                    try {
                        Remove-AppxProvisionedPackage -Online -PackageName $ProvPkg.PackageName -ErrorAction Stop | Out-Null
                    } catch {
                        # Silently swallow provision removal failures if locked
                    }
                }
            }

            # 2. Uninstall installed AppX package
            $Packages = Get-AppxPackage -AllUsers -Name $PackagePattern -ErrorAction SilentlyContinue
            if ($Packages) {
                foreach ($Pkg in $Packages) {
                    Write-Host " [x] Removing $($Pkg.Name)..." -ForegroundColor Red
                    try {
                        # Attempt standard current-user removal first
                        Remove-AppxPackage -Package $Pkg.PackageFullName -ErrorAction Stop
                    } catch {
                        # Fallback attempt across all users
                        try {
                            Remove-AppxPackage -Package $Pkg.PackageFullName -AllUsers -ErrorAction Stop
                        } catch {
                            Write-Host "     (!) Skipping $($Pkg.Name) (Package locked by Windows system profile)" -ForegroundColor DarkGray
                        }
                    }
                }
            }
        }
        Write-Host "`n[✓] Selected apps removal completed!" -ForegroundColor Green
    } else {
        Write-Host "`n[!] No apps were checked. Nothing removed." -ForegroundColor Yellow
    }
} else {
    Write-Host "`n[!] Operation cancelled by user." -ForegroundColor Gray
}
