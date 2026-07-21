# Restore Classic Windows 10 Context Menu in Windows 11
Write-Host "Restoring classic right-click context menu..." -ForegroundColor Yellow

New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force | Out-Null
Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(default)" -Value "" -Force | Out-Null

Write-Host "Classic context menu enabled! (Requires File Explorer restart to reflect)" -ForegroundColor Green
