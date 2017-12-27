

<#
.SYNOPSIS
    Returns Data Structures stored in psd1 files.
.DESCRIPTION
    Returns Data Structures stored in psd1 files.
    The cmd will return all structures defined for
    the module if called without a parameter. To
    get a specific structure use its named which is
    the base name of the psd1 file containing it.
.PARAMETER StructureName
    This value is used to get a single structure. If
    no value is supplied then all defined structures
    will be returned.
.EXAMPLE
    PS C:\> Get-ReleaserStructure
    Returns all structures defined for the module
.EXAMPLE
    PS C:\> Get-ReleaserStructure -StructureName ReleaserConfig
    Returns only the ReleaserConfig hashtable contained in 
    ReleaserConfig.psd1
.INPUTS
    [string] StructureName
.OUTPUTS
    [hashtable] Stored in psd1 data files
#>
function Get-ReleaserStructure {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage='Name of a specific structure to return')]
        [string]$StructureName
    )
    
    end {
        $path = "$__ReleaserRoot__\library"
        if ([string]::IsNullOrEmpty($StructureName)) {
            Get-ChildItem -Path $path | ForEach-Object {
                Import-PowerShellDataFile -Path $PSItem.FullName
            }
        }
        else {
            $path = "$path\$StructureName.psd1"
            if (-not (Test-Path $path)) {
                throw "$StructureName is not a valid structure name"
            }
            Import-PowerShellDataFile -Path $path
        }
    }
}