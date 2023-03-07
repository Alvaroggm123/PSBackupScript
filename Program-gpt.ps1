# Import the Menu class from Menu.ps1
. ".\lib\menu-gpt.ps1"

[hashtable]$options = [ordered]@{
    "1" = "Create a backup of a custom folder"
    "2" = "Backup OneDrive Documents"
    "3" = "Remove oldest backup"
    "4" = "Exit"
}
$defaultOption = "4"
$menu = [Menu]::new($options, $defaultOption)

do {
    if ($menu) {
        $menu.Show()
        $choice = $menu.GetChoice(10)
    }
    # Execute the selected option
    switch ($choice) {
        "1" {
            # Create a backup of a custom folder
            $command = ".\lib\backup\BackupCustomFolder.ps1"
            Invoke-Expression $command
        }
        "2" {
            # Backup OneDrive Documents
            $command = ".\lib\backup\BackupOneDrive.ps1"
            Invoke-Expression $command
        }
        "3" {
            # Remove oldest backup
            $command = ".\RemoveOldestBackup.ps1"
            Invoke-Expression $command
        }
        "4" {
            # Exit
            Write-Host "Exiting..."
            return
        }
        default {
            Write-Error "Invalid option: $choice"
        }
    }
} while ($choice -ne "4")