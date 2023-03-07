class Menu {
    [hashtable]$Options
    [string]$DefaultOption

    Menu([hashtable]$options, [string]$defaultOption) {
        $this.Options = $options
        $this.DefaultOption = $defaultOption
    }

    [void]Show() {
        Write-Host "Select an option:"
        foreach ($key in $this.Options.Keys) {
            Write-Host "$key. $($this.Options[$key])"
        }
    }

    [string]GetChoice([int]$timeoutSeconds) {
        $choice = $null
        $timer = New-Object System.Diagnostics.Stopwatch
        $timer.Start()
        while (-not $choice -and $timer.Elapsed.TotalSeconds -lt $timeoutSeconds) {
            if ([Console]::KeyAvailable) {
                $key = [Console]::ReadKey("NoEcho,IncludeKeyDown")
                $choice = $key.Character
            }
            $timeLeft = $timeoutSeconds - [math]::Round($timer.Elapsed.TotalSeconds)
            $timerString = "Time left: {0:mm\:ss}" -f ([datetime]"00:00:00").AddSeconds($timeLeft)
            $timerPadding = " " * ([Console]::WindowWidth - $timerString.Length)
            [Console]::SetCursorPosition(0, 0)
            [Console]::Write($timerPadding + $timerString)
            Start-Sleep -Milliseconds 50
        }

        [Console]::SetCursorPosition(0, 0)
        [Console]::Write((" " * [Console]::WindowWidth).PadRight([Console]::WindowWidth))
        [Console]::SetCursorPosition(0, 1)

        if (-not $choice) {
            $choice = $this.DefaultOption
            Write-Host "No option selected. Default option ($($this.Options[$this.DefaultOption])) selected."
        }

        return $choice
    }

}
