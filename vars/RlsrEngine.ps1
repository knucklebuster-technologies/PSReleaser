

$RlsrEngine = [PSCustomObject] @{
    RootPath  = ""
    Tasks     = @{}
    Projects  = @()
    Errors = @()
}
$RlsrEngine.RootPath = "$( Split-Path -Path $PSScriptRoot -Parent )"