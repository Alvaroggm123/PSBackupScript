class Menu {
    [hashtable]$Options
    [string]$DefaultOption

    Menu([hashtable]$options, [string]$defaultOption) {
        $this.Options = $options
        $this.DefaultOption = $defaultOption
    }

    [void]Show() {
        Clear-Host
        $consoleWidth = [Console]::WindowWidth - 2
        Write-Host ("+" + " {0,-$($consoleWidth-2)} +" -f ("-" * ($consoleWidth - 2)))
        Write-Host ("|" + " [{0,-7}] | {1,-29}" -f " Option", "Description") -NoNewline
        [Console]::SetCursorPosition(([Console]::WindowWidth - 1), 1)
        Write-Host ("|")
        Write-Host ("+" + " {0,-$($consoleWidth-2)} +" -f ("-" * ($consoleWidth - 2)))
        foreach ($item in $this.Options.GetEnumerator()) {
            $optionText = "[ {0,5} ] | {1,-25}" -f $item.Key, $item.Value
            $optionWidth = $optionText.Length
            $paddingWidth = $consoleWidth - $optionWidth - 3
            Write-Host ("|" + " {0} {1,-$paddingWidth} |" -f $optionText, (" " * ($paddingWidth - 1)))
        }
        Write-Host ("+" + " {0,-$($consoleWidth-2)} +" -f ("-" * ($consoleWidth - 2)))
        $oldTop = [Console]::CursorTop
        Write-Host ("|" + " {0,-$($consoleWidth-2)} |" -f (" " * ($consoleWidth - 2)))
        Write-Host ("+" + " {0,-$($consoleWidth-2)} +" -f ("-" * ($consoleWidth - 2)))
        [Console]::SetCursorPosition(5, $oldTop)
        Write-Host ("[Press <ENTER> to choose an option] | Option: ") -NoNewline
        [Console]::SetCursorPosition([Console]::CursorLeft, $oldTop)
    }
        
    

    [string]GetChoice([int]$timeoutSeconds) {
        $oldLeft = [Console]::CursorLeft
        $oldTop = [Console]::CursorTop
        $timer = New-Object System.Diagnostics.Stopwatch
        $timer.Start()
        while ($timer.Elapsed.TotalSeconds -lt $timeoutSeconds) {
            $timeLeft = $timeoutSeconds - [math]::Round($timer.Elapsed.TotalSeconds)
            $timerString = "| Time left: {0:mm\:ss}" -f ([datetime]"00:00:00").AddSeconds($timeLeft)
            [Console]::SetCursorPosition(([Console]::WindowWidth - $timerString.Length - 3), 1)
            [Console]::Write($timerString)

            [Console]::SetCursorPosition($oldLeft, $oldTop)
            Start-Sleep -Milliseconds 50
    
            if ([Console]::KeyAvailable) {
                $key = [Console]::ReadKey("NoEcho,IncludeKeyDown")
                if ($key.Key -eq "Enter") {
                    $input = [Console]::ReadLine().Trim()
                    if ($this.Options.ContainsKey($input)) {
                        return $input
                    }
                }
            }
        }
    
        [Console]::SetCursorPosition(0, [Console]::CursorTop)
        [Console]::Write((" " * [Console]::WindowWidth).PadRight([Console]::WindowWidth))
        [Console]::SetCursorPosition(0, [Console]::CursorTop + 1)
    
        Write-Host "No option selected. Default option ($($this.Options[$this.DefaultOption])) selected."
        return $this.DefaultOption
    }    
}
