# +--------------------+
# + Clase Menú         +
# +--------------------+
class classMenu {
    [string]$menuName
    [array]$menuOptions
    [int]$timer = 60

    # +---------------------------+
    # + Constructores de la clase +
    # +---------------------------+

    # Constructor para generar instancia de la clase solo con el nombre.
    classMenu([string]$menuName) {
        [array]$EndOption = "Exit"

        $this.menuName = $menuName
        $this.menuOptions = "No options", "available"
        $this.menuOptions += $EndOption
    }
    # Sobrecarga de constructor para inicializar con las opciones.
    classMenu([string]$menuName, [array]$menuOptions) {
        [array]$EndOption = "Exit"
        $this.menuName = $menuName
        $this.menuOptions = $menuOptions
        $this.menuOptions += $EndOption
    }

    # Sobrecarga de constructor para inicializar con las opciones y timer.
    classMenu([string]$menuName, [array]$menuOptions, [int]$timer) {
        [array]$EndOption = "Exit"
        $this.menuName = $menuName
        $this.menuOptions = $menuOptions
        $this.menuOptions += $EndOption
        $this.timer = $timer
    }
    
    hidden [int] Choose([int]$default) {
        # Impresión de "Opcion (<LaDeDefecto>): "
        Write-Host "Choose (" -NoNewline -ForegroundColor Cyan
        Write-Host "default" -NoNewline -ForegroundColor red
        Write-Host " = " -NoNewline -ForegroundColor Cyan
        Write-Host $default -NoNewline -ForegroundColor Green
        Write-Host "): " -NoNewline -ForegroundColor Cyan
    
        # Obtenemos respuesta del usuario
        $answ = $this.$default
        try {
            $answ = Read-Host
            return $answ
        }
        catch {
            Write-Host "Error with input, must type a number..."
            Start-Transcript -Append log_menu.txt
        }
    
        # Retornamos respuesta
        return $answ
    }
    
    hidden [int] funcMenu ([int]$default) {
        Clear-Host
        [int]$counter = 0
        Write-Host "- - - - - ", $this.menuName, "- - - - - " -ForegroundColor White
        foreach ($element in $this.menuOptions) {
            $counter++
            Write-Host "[", $counter, "] -  ", $element -Separator '' -ForegroundColor Blue
        }
        return $this.Choose($default)
    }
    
    [int] start (){
        do {
            [int]$choosenIndex = $this.funcMenu($this.menuOptions.Length)
            if ($choosenIndex -lt 1 ){
                return $this.menuOptions.Length
            }
        } while (
            
            $choosenIndex -gt $this.menuOptions.Length -or !$choosenIndex
        )
        return $choosenIndex
    }
    
    [int] start ([int]$default){
        do {
            [int]$choosenIndex = $this.funcMenu($default)
            if ($choosenIndex -lt 1 ){
                return $default
            }
        } while (
            
            $choosenIndex -gt $this.menuOptions.Length -or !$choosenIndex
        )
        return $choosenIndex
    }
}