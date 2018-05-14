
<#
.SYNOPSIS
    Returns an object used for project based data.
.DESCRIPTION
    Returns an object used for project based data.
.EXAMPLE
    PS C:\> New-RlsrProject
    Returns an object used to hold all project
    related data.
#>
function New-RlsrProject {
    [CmdletBinding()]
    param ()

    end {
        try {
            $ErrorActionPreference = 'Stop'
            . "$( $RlsrEngine.RootPath )\vars\RlsrProject.ps1"
        }
        catch {
            $RlsrEngine.Errors += ConvertFrom-ErrorRecord -Record $_
            throw $_
        }
    }
}