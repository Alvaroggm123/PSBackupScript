. .\lib\Menu.ps1
# +------------------------------------------------------+
# +                Comienza ejecución                    +
# +------------------------------------------------------+

[array]$opciones = "Realizar respaldo general", "Respaldar último respaldo", "Eliminar respaldo más viejo"
$menuMain = [classMenu]::new("Menú principal", $opciones)
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

# +---------------------+
# + LOG de la ejecución +
# +---------------------+
Start-Transcript -Append .\log\log_Program.txt
Clear-Host