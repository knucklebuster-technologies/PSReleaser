
<#
.SYNOPSIS
    Returns an object created from json stored in a
    rlsr.lock file.
.DESCRIPTION
    Finds the lock file that matches the cfg file in use.
    Once the file path is generated an object is created
    and returned based on the json stored in rlsr.lock
    file.
.PARAMETER CfgPath
    The full path to the rlsr.cfg file used to start
    the current run.
.EXAMPLE
    PS C:\> Get-RlsrLock -CfgPath C:\Module\Source\Alpha-Path.rlsr.cfg
    This cmd will take the CfgPath change the .cfg to .lock
    and then retrun and object based on the json stored in the
    rlsr.lock file.
#>
function Get-RlsrLock {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = 'The path to the rlsr.cfg file being used by the current process')]
        [string]
        $CfgPath
    )

    end {
        try {
            $ErrorActionPreference = 'Stop'
            $lckpath = $CfgPath -replace ".rlsr.cfg", ".rlsr.lock"
            Get-Content -Path $lckpath -Force | ConvertFrom-Json
            Write-Verbose -Message "The lock file $lckpath was imported"
        }
        catch {
            $RlsrEngine.ErrorInfo += ConvertFrom-ErrorRecord -Record $_
            throw $_
        }
    }
}