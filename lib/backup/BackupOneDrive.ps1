# Create a backup of a custom folder
$sourceFolder = Read-Host "Enter the full path of the folder to backup"
$backupDestination = Read-Host "Enter the full path of the backup destination"

if (-not (Test-Path $sourceFolder)) {
    Write-Error "Folder $sourceFolder does not exist."
    return
}

if (-not (Test-Path $backupDestination)) {
    Write-Error "Backup destination $backupDestination does not exist."
    return
}

$timestampString = Get-Date -Format "yyyyMMdd_HHmmss"
$backupFolderName = "$($sourceFolder.Split("\")[-1])_$timestampString"
$backupFolderPath = Join-Path -Path $backupDestination -ChildPath $backupFolderName

Write-Host "Copying $sourceFolder to $backupFolderPath..."
Copy-Item $sourceFolder -Destination $backupFolderPath -Recurse -Verbose

Write-Host "Backup created at $backupFolderPath"
