class BackupMenu {
    [hashtable]$Options
    [string]$DefaultOption

    BackupMenu([hashtable]$options, [string]$defaultOption) {
        $this.Options = $options
        $this.DefaultOption = $defaultOption
    }

    [void]Show() {
        Write-Host "Select a backup option:"
        foreach ($key in $this.Options.Keys) {
            Write-Host "$key. $($this.Options[$key])"
        }
    }

    [string]GetChoice([int]$timeoutSeconds) {
        $choice = $null
        $timer = New-Object System.Diagnostics.Stopwatch
        $timer.Start()
        while (-not $choice -and $timer.Elapsed.TotalSeconds -lt $timeoutSeconds) {
            $choice = Read-Host "Enter your choice (press Enter to select the default option $($this.Options[$this.DefaultOption]))"
        }

        if (-not $choice) {
            $choice = $this.DefaultOption
            Write-Host "No option selected. Default option ($($this.Options[$this.DefaultOption])) selected."
        }

        return $choice
    }
}

# Create the backup menu object
$backupOptions = @{
    "1" = "Create a backup of a custom folder"
    "2" = "Backup of a OneDrive Documents folder"
    "3" = "Remove oldest backup"
    "4" = "Exit"
}
$backupDefaultOption = "1"
$backupMenu = [BackupMenu]::new($backupOptions, $backupDefaultOption)

# Show the backup menu and get the user's choice
$backupMenu.Show()
$backupChoice = $backupMenu.GetChoice(10)

# Execute the selected backup option
switch ($backupChoice) {
    "1" {
        # Execute option 1 - create a backup of a custom folder
        Write-Host "You selected Option 1 - Create a backup of a custom folder"
        # Add your code here to implement the backup functionality for a custom folder
    }
    "2" {
        # Execute option 2 - backup of a OneDrive Documents folder
        Write-Host "You selected Option 2 - Backup of a OneDrive Documents folder"
        # Add your code here to implement the backup functionality for OneDrive Documents folder
    }
    "3" {
        # Execute option 3 - remove oldest backup
        Write-Host "You selected Option 3 - Remove oldest backup"
        # Add your code here to implement the functionality to remove oldest backup
    }
    "4" {
        # Exit the script
        Write-Host "You selected Option 4 - Exit"
        return
    }
    default {
        Write-Error "Invalid option: $backupChoice"
    }
}