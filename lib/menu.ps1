# +------------------------------------------------------+
# +                     Clase Menú                       +
# +------------------------------------------------------+
# + Se trata de un script que permite generar instancias +
# + de la clase classMenu, estas permiten asociar arrays +
# + con las respectivas opciones a escoger, además,      +
# + cuenta con la posibilidad de enviar una respuesta    +
# + que funcióne como la opción "Por defecto".           +
# +------------------------------------------------------+
class classMenu {
    # +----------------------------------+
    # + Atributos de la clase            +
    # +----------------------------------+
    [string]$menuName
    [array]$menuOptions
    [int]$menuTimer = 60

    # +----------------------------------+
    # + Constructores de la clase        +
    # +----------------------------------+
    
    # +---------------------------+
    # + Constructor principal     +
    # +---------------------------+
    # + Este constructor solo     +
    # + requiere del nombre de la +
    # + instancia o "Título".     +
    # +---------------------------+
    classMenu([string]$menuName) {
        [array]$EndOption = "Exit"

        $this.menuName = $menuName
        $this.menuOptions = "No options", "available"
        $this.menuOptions += $EndOption
    }
    
    # +---------------------------+
    # + Constructor sobrecargado  +
    # +---------------------------+
    # + Este constructor requiere +
    # + del nombre de la instancia+
    # + y el conjunto de opciones +
    # + que tendrán.              +
    # +---------------------------+
    classMenu([string]$menuName, [array]$menuOptions) {
        [array]$EndOption = "Exit"
        $this.menuName = $menuName
        $this.menuOptions = $menuOptions
        $this.menuOptions += $EndOption
    }

    # +---------------------------+
    # + Constructor con tiempo    +
    # +---------------------------+
    # + Este constructor requiere +
    # + de todos los parametros   +
    # + incluyendo el tiempo      +
    # + límite para responder.    +
    # +---------------------------+
    classMenu([string]$menuName, [array]$menuOptions, [int]$menuTimer) {
        [array]$EndOption = "Exit"
        $this.menuName = $menuName
        $this.menuOptions = $menuOptions
        $this.menuOptions += $EndOption
        $this.timer = $menuTimer
    }
    
    # +----------------------------------+
    # + funciónes y métodos de la clase  +
    # +----------------------------------+
    
    # +---------------------------+
    # + función oculta "Choose"   +
    # +---------------------------+
    # + función encargada de      +
    # + enlistar las opciones     +
    # + disponibles.              +
    # +---------------------------+
    hidden [int] Choose([int]$default) {

        # +-----------------------+
        # + Impresíón de espera   +
        # + de respuesta.         +
        # +-----------------------+
        Write-Host "Choose (" -NoNewline -ForegroundColor Cyan
        Write-Host "default" -NoNewline -ForegroundColor red
        Write-Host " = " -NoNewline -ForegroundColor Cyan
        Write-Host $default -NoNewline -ForegroundColor Green
        Write-Host "): " -NoNewline -ForegroundColor Cyan

        # +-----------------------+
        # + Obtenemos respuesta   +
        # + del usuario.          +
        # +-----------------------+
        $answ = $this.$default
        try {
            $answ = Read-Host
            return $answ
        }
        catch {
            
            # +-------------------+
            # + En caso de encon- +
            # + rar un error, se  +
            # + generará un log.  +
            # +-------------------+
            Write-Host "Error with input, must type a number..."
            Start-Transcript -Append .\log\log_menu.txt
        }
    
        # +-----------------------+
        # + Retorno de respuesta. +
        # +-----------------------+
        return $answ
    }
    
    # +---------------------------+
    # + función oculta "funcMenu" +
    # +---------------------------+
    # + función encargada de      +
    # + imprimir el título del    +
    # + menú instanciado y las    +
    # + opciones asociadas.       +
    # +---------------------------+
    hidden [int] funcMenu ([int]$default) {
        Clear-Host
        [int]$counter = 0
        Write-Host "- - - - - ", $this.menuName, "- - - - - " -ForegroundColor White
        foreach ($element in $this.menuOptions) {
            $counter++
            Write-Host "["  -NoNewline

            # +-------------------+
            # + Coloreado de      +
            # + opción default.   +
            # +-------------------+
            if ($default -eq $counter) {
                Write-Host $counter -NoNewline -ForegroundColor Green
            }
            else {
                Write-Host $counter -NoNewline -ForegroundColor Yellow
            }
            
            Write-Host "] -  ", $element -Separator '' -ForegroundColor Blue
        }
        return $this.Choose($default)
    }
    
    # +---------------------------+
    # + función oculta "start"    +
    # +---------------------------+
    # + Esta función es la que se +
    # + encarga de regresar el    +
    # + valor/"opción" que el     +
    # + usuario escoja, esto      +
    # + considerando a la última  +
    # + opción como la opción de  +
    # + salida del programa.      +
    # + Se debe considerar que la +
    # + opción por defecto es la  +
    # + salida del programa.      +
    # +---------------------------+
    [int] start () {
        do {
            # +-------------------+
            # + Captura de Choose +
            # +-------------------+
            [int]$choosenIndex = $this.funcMenu($this.menuOptions.Length)
            
            # +-------------------+
            # + Se valida si el   +
            # + usuario está      +
            # + activo en la      +
            # + terminal.         +
            # +-------------------+
            if ($choosenIndex -lt 1 ) {
                return $this.menuOptions.Length
            }
        } while (
            # +-------------------+
            # + Validación de     +
            # + Salida del prog,  +
            # +-------------------+
            $choosenIndex -gt $this.menuOptions.Length -or !$choosenIndex
        )
        # +-----------------------+
        # + Retorno de opción     +
        # +-----------------------+
        return $choosenIndex
    }
    
    # +---------------------------+
    # + Sobrecarga de la función  +
    # + start                     +
    # +---------------------------+
    # + Esta función permite      +
    # + asociar una opción por    +
    # + defecto.                  +
    # +---------------------------+
    [int] start ([int]$default) {
        do {
            # +-------------------+
            # + Captura de Choose +
            # +-------------------+
            [int]$choosenIndex = $this.funcMenu($default)

            # +-------------------+
            # + Se valida si el   +
            # + usuario escogió   +
            # + la opción por     +
            # + defecto.          +
            # +-------------------+
            if ($choosenIndex -lt 1 ) {
                return $default
            }
        } while (
            # +-------------------+
            # + Validación de     +
            # + Salida del prog,  +
            # +-------------------+
            $choosenIndex -gt $this.menuOptions.Length -or !$choosenIndex
        )
        # +-----------------------+
        # + Retorno de opción     +
        # +-----------------------+
        return $choosenIndex
    }
}