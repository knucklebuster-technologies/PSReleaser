

function Get-RlsrLockInfo {
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
            $lckpath = $CfgPath -replace ".rlsrcr1.json", ".lock.json"
            $lckinfo = Get-Content -Path $lckpath -Force | ConvertFrom-Json
            $lckinfo | Add-Member -MemberType NoteProperty -Name 'cfgPath' -Value $CfgPath -Force
            $lckinfo
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