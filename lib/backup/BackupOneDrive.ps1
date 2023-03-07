# Menu options for OneDrive backup
$onedrivePath = "$env:USERPROFILE\OneDrive"
$subfolders = Get-ChildItem $onedrivePath -Directory
$options = @{ "1" = "Backup entire OneDrive folder"; }
for ($i = 0; $i -lt $subfolders.Count; $i++) {
    $options["$($i+2)"] = "Backup $($subfolders[$i].Name) folder"
}
$defaultOption = "1"

# Create menu and get user choice
$menu = [Menu]::new($options, $defaultOption)
$menu.Show()
$choice = $menu.GetChoice(30)

# Get backup path and timestamp
$backupPath = Read-Host "Enter the full path of the backup destination"
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"

# Backup selected folder
if ($choice -eq "1") {
    $backupFileName = "OneDrive_$timestamp.zip"
    Compress-Archive -Path $onedrivePath -DestinationPath "$backupPath\$backupFileName"
    Write-Host "Backup created at $backupPath\$backupFileName"
} else {
    $selectedSubfolder = $subfolders[$choice-2]
    $backupFileName = "$($selectedSubfolder.Name)_$timestamp.zip"
    Compress-Archive -Path $selectedSubfolder.FullName -DestinationPath "$backupPath\$backupFileName"
    Write-Host "Backup of $($selectedSubfolder.Name) created at $backupPath\$backupFileName"
}
