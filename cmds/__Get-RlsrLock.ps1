

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
            if (Test-Path -Path $lckpath) {
                Get-Content -Path $lckpath -Force | ConvertFrom-Json
            } else {
                '{}' | Out-File -FilePath $lckpath -Force
                New-Object -TypeName 'PSCustomObject'
            }
            Write-Verbose -Message "The lock file $lckpath was imported"
        }
        catch {
            Write-Error - @{
                'Message'  = "The project cfg $lckpath does not exist"
                'Catagory' = 'ObjectNotFound'
                'ErrorID'  = 'Get-RlsrConfig'
            }
        }
    }
}