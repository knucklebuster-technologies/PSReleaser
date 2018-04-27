$RlsrEngine = [PSCustomObject] @{
    RootPath  = ""
    Tasks     = @{}
    Projects  = @()
    ErrorInfo = @()
}
$RlsrEngine.RootPath = "$( Split-Path -Path $PSScriptRoot -Parent )"