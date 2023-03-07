get-disk
[array]$diskUSB, $diskNUSB = (get-disk | Where-Object -FilterScript { $_.Bustype -Eq "USB" }).Number.Count, (get-disk | Where-Object -FilterScript { $_.Bustype -ne "USB" }).Number.Count
Write-Host "Unidades de USB: " -NoNewline
Write-Host $diskUSB
Write-Host "Unidades no USB: " -NoNewline
Write-Host $diskNUSB