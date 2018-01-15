

function Set-RlsrLockInfo {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage='Path to directory that contains Rlsr project config(s)')]
        [ValidateScript({
            if ([IO.directory]::Exists($PSItem)) {return $true}
            throw "$PSItem is not a vaild directory"
        })]
        [string]
        $Path = "$PWD",
        [string]
        $CfgPath,
        $InputObject
    )
    
    end {
        try {
            $ErrorActionPreference = 'Stop'
            $lckpath = Join-Path -Path $Path -ChildPath "rlsrcr1.lock.json"
            Get-Content -Path $lckpath -Force | 
            ConvertFrom-Json | 
            Add-Member -MemberType NoteProperty -Name "$CfgPath" -Value $InputObject -Force -PassThru |
            ConvertTo-Json |
            Out-File -FilePath $lckpath -Force
            Write-Verbose -Message "The lock file $lckpath was updated"
        }
        catch {
            Write-Error @{
                'Message'  = "The project cfg $lckpath does not exist: $_" 
                'Catagory' = 'ObjectNotFound'
                'ErrorID'  = 'Get-RlsrConfig' 
            }
        }
    }
}