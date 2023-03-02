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
    
    [int] start (){
        do {
            [int]$choosenIndex = $this.funcMenu(0)
        } while (
            
            $choosenIndex -lt 1 -or $choosenIndex -gt $this.menuOptions.Length -or !$choosenIndex
        )
        return $choosenIndex
    }
    
    [int] start ([int]$default){
        do {
            [int]$choosenIndex = $this.funcMenu($default)
        } while (
            
            $choosenIndex -lt 1 -or $choosenIndex -gt $this.menuOptions.Length -or !$choosenIndex
        )
        return $choosenIndex
    }
}

[array]$opciones = "Realizar respaldo general", "Respaldar último respaldo", "Eliminar respaldo más viejo"
$menuMain = [classMenu]::new("Main Menu", $opciones)
$respuesta = $menuMain.start(1)

switch ($respuesta) {
    1 { 
        Write-Host "Opcion 1 ejecutada correctamente"
     }
    2 { 
        Write-Host "Opcion 2 ejecutada correctamente"
     }
    Default {}
}

Pause


# +---------------------+
# + LOG de la ejecución +
# +---------------------+
Start-Transcript -Append logMenu.txt
Clear-Host