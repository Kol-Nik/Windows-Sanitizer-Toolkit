# Disable Xbox Game DVR Background Screen Recording
Write-Host "Disabling Xbox Game DVR background recording..." -ForegroundColor Yellow

New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -PropertyType DWord -Value 0 -Force | Out-Null
New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Force | Out-Null
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -PropertyType DWord -Value 0 -Force | Out-Null

Write-Host "Xbox Game DVR disabled successfully!" -ForegroundColor Green
