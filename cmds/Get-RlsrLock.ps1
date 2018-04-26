

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
            $RlsrInfo.EngineErrors += ConvertFrom-ErrorRecord -Record $_
            throw $_
        }
    }
}