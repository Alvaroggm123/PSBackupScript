function pressKey () {
    Write-Host -NoNewLine 'Press any tecla to continue...';
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}