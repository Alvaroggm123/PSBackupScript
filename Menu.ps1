# +--------------------+
# + Clase Menú         +
# +--------------------+
class classMenu {
    [string]$menuName
    [array]$menuOptions

    # +---------------------------+
    # + Constructores de la clase +
    # +---------------------------+

    # Constructor para generar instancia de la clase solo con el nombre.
    classMenu([string]$menuName) {
        $this.menuName = $menuName
        $this.menuOptions = "No options", "available"
    }
    # Sobrecarga de constructor para inicializar con las opciones.
    classMenu([string]$menuName, [array]$menuOptions) {
        $this.menuName = $menuName
        $this.menuOptions = $menuOptions
    }
    
    hidden [int] Choose([int]$default) {
        # Impresión de "Opcion (<LaDeDefecto>): "
        Write-Host "Choose (" -NoNewline -ForegroundColor Cyan
        Write-Host $default -NoNewline -ForegroundColor Red
        Write-Host "): " -NoNewline -ForegroundColor Cyan
    
        # Obtenemos respuesta del usuario
        $answ = $this.$default
        try {
            $answ = Read-Host
            return $answ
        }
        catch {
            Write-Host "Error with input, must type a number..."
            Start-Transcript -Append logMenu.txt
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
    
    hidden [int] funcMenu () {
        Clear-Host
        [int]$counter = 0
        Write-Host "- - - - - ", $this.menuName, "- - - - - " -ForegroundColor White
        foreach ($element in $this.menuOptions) {
            $counter++
            Write-Host "[", $counter, "] -  ", $element -Separator '' -ForegroundColor Blue
        }
        return $this.Choose(0)
    }
}

[array]$opciones = "Opcion 1", "Opcion 2", "Opcion 3"
$menuMain = [classMenu]::new("Main Menu", $opciones)
$respuesta = $menuMain.funcMenu()

Write-Host $respuesta
Pause


# +---------------------+
# + LOG de la ejecución +
# +---------------------+
Start-Transcript -Append logMenu.txt
Clear-Host