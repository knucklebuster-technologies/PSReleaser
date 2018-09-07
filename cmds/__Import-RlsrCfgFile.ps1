
<#
.SYNOPSIS
    Returns an object based on json stored in a file with the
    rlsr.cfg extension.
.DESCRIPTION
    Uses the Path and Name parameters to build a path to a json
    cfg file. Returns an object based on this file with a rlsr.cfg
    extension.
.PARAMETER Path
    The path to a directory containing the project source.
    Must also contain at least one set of rlsr.cfg, rlsr.lock files.
.PARAMETER Name
    The base file name shared by the rlser.cfg, rlsr.lock file.
    Do not specify the file extension.
.EXAMPLE
    PS C:\> Import-RlsrCfgFile -Path 'C:\Modules\Source' -Name 'Alpha-Patch'
    This looks for the json cfg file C:\Modules\Source\Alpha-Patch.rlsr.cfg.
    If the file is found it returns a object from the files json.
#>
function Import-RlsrCfgFile {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = 'The path to the psreleaser.cfg file')]
        [string]
        $Path
    )

    end {
        try {
            $ErrorActionPreference = 'Stop'
            Write-Verbose -Message "Path: $Path"
            $cfgpath = Resolve-Path -Path $Path
            $cfgobject = Get-Content -Path $cfgpath | ConvertFrom-Json
            $cfgobject | Add-Member -MemberType NoteProperty -Name 'fullPath' -Value $cfgpath -Force
            $cfgobject
            Write-Verbose -Message "The project cfg $cfgpath was imported"
        }
        catch {
            $RlsrEngine.Errors += ConvertFrom-ErrorRecord -Record $_
            throw $_
        }
    }
}