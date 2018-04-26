

function Get-RlsrLock {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = 'Path to directory that contains Rlsr project config(s)')]
        [ValidateScript( {
                if ([IO.directory]::Exists($PSItem)) {return $true}
                throw "$PSItem is not a vaild directory"
            })]
        [string]
        $Path = "$PWD",
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
            Write-Error - @{
                'Message'  = "The lock file $lckpath was not imported"
                'Catagory' = 'ObjectNotFound'
                'ErrorID'  = 'Get-RlsrLock'
            }
        }
    }
}