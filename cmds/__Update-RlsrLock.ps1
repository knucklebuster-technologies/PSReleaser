function Update-RlsrLock {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = 'Name of the property to set on the lock object and file')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Name,
        [Parameter(HelpMessage = 'Value of the property to set on the lock object and file')]
        [ValidateNotNull()]
        [object]
        $Value
    )

    end {
        try {
            $ErrorActionPreference = 'Stop'
            $RlsrInfo.Projects[-1].LockInfo | Add-Member -MemberType NoteProperty -Name $Name -Value $Value -Force
            $lckpath = $RlsrInfo.Projects[-1].Cfg.fullPath -replace ".rlsr.cfg", ".rlsr.lock"
            $RlsrInfo.Projects[-1].LockInfo | ConvertTo-Json | Set-Content -Path $lckpath -Force
            Write-Verbose -Message "Lock update successful"
        }
        catch {
            Write-Error - @{
                'Message'  = "Lock update failed"
                'Catagory' = 'ObjectNotFound'
                'ErrorID'  = 'Update-RlsrLock'
            }
        }
    }
}