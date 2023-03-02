# +------------------------------------------------------+
# +             Referencia a bibliotecas                 +
# +------------------------------------------------------+
. .\lib\menu.ps1
. .\lib\interactions.ps1
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
[int]$option
while ($option -ne $menuMain.menuOptions.Length) {
    $option = $menuMain.start(1)
    switch ($option) {
        1 { 
            Write-Host "Opcion 1 ejecutada correctamente"
            pressKey
        }
        2 { 
            Write-Host "Opcion 2 ejecutada correctamente"
            pressKey
        }
        3 { 
            Write-Host "Opcion 3 ejecutada correctamente"
            pressKey
        }
        Default {
            Write-Host "Fin de la ejecución..."
            Pause
        }
    }
}

# +------------------------------------------------------+
# +                Log de la ejecución                   +
# +------------------------------------------------------+
Start-Transcript -Append .\log\log_Program.txt
Clear-Host