# Disable Taskbar Widgets & News/Interests Feed
Write-Host "Disabling Taskbar Widgets and News feed..." -ForegroundColor Yellow

New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -PropertyType DWord -Value 0 -Force | Out-Null

New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -PropertyType DWord -Value 0 -Force | Out-Null

Write-Host "Widgets and News feed disabled successfully!" -ForegroundColor Green
