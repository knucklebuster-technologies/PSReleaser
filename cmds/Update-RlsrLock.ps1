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
            $RlsrEngine.Projects[-1].Lock | Add-Member -MemberType NoteProperty -Name $Name -Value $Value -Force
            $lckpath = $RlsrEngine.Projects[-1].Cfg.fullPath -replace ".rlsr.cfg", ".rlsr.lock"
            $RlsrEngine.Projects[-1].Lock | ConvertTo-Json | Set-Content -Path $lckpath -Force
            Write-Verbose -Message "Lock update successful"
        }
        catch {
            $RlsrEngine.Errors += ConvertFrom-ErrorRecord -Record $_
            throw $_
        }
    }
}