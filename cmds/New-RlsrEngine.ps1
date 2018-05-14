function New-RlsrEngine {
    [CmdletBinding()]
    param ()

    end {
        . "$( Split-Path -Path $PSScriptRoot -Parent )\vars\RlsrEngine.ps1"
    }
}