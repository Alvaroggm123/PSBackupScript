# +------------------------------------------------------+
# +             Referencia a bibliotecas                 +
# +------------------------------------------------------+
. .\lib\Menu.ps1
# +------------------------------------------------------+
# +                Comienza ejecución                    +
# +------------------------------------------------------+

# +------------------------+
# +    Creación de Menú    +
# +------------------------+
[array]$opciones = "Realizar respaldo general", "Respaldar último respaldo", "Eliminar respaldo más viejo"
$menuMain = [classMenu]::new("Menú principal", $opciones)

# +------------------------+
# +  Opciones del Menú     +
# +------------------------+
switch ($menuMain.start(1)) {
    1 { 
        Write-Host "Opcion 1 ejecutada correctamente"
        Pause
    }
    2 { 
        Write-Host "Opcion 2 ejecutada correctamente"
        Pause
     }
    Default {}
}

# +------------------------------------------------------+
# +                Log de la ejecución                   +
# +------------------------------------------------------+
Start-Transcript -Append .\log\log_Program.txt
Clear-Host