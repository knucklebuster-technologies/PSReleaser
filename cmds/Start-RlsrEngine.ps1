

function Start-RlsrEngine {
    [CmdletBinding()]
    param (
        $Path = "$Pwd",
        $Name = '*'
    )

    end {
        $ErrorActionPreference = 'Stop'
        Write-Verbose -Message "Engine Values: Path=$Path, Name=$Name"
        $Path = Resolve-Path -Path $Path
        Write-Verbose -Message "Directory Path: $Path"
        $p = Get-RlsrProject
        $p.Timestamp = [DateTime]::NoW.ToString('yyyyMMddHHmmss')
        $p.Cfg = Get-RlsrConfig -Path $Path -Name $Name
        $p.RunName = $p.Cfg.ModuleName + '::' + $p.Timestamp
        $p.Manifest = Test-ModuleManifest -Path "$Path\$($p.Cfg.ModuleName).psd1"
        $p.LockInfo = Get-RlsrLock -Path $Path -CfgPath $p.Cfg.FullPath
        $p.Status = 'Running'
        $p.Running = $true

        Write-Verbose -Message "Engine Starting: RUN $($p.RunName) For Module $($p.Cfg.ModuleName) CI process started"
        $p.Cfg.TaskSequence | ForEach-Object {
            $taskname = "$PSItem"
            Write-Verbose -Message "Task Invocation: $taskname invoked"
            $ok = $RlsrInfo.Tasks[$taskname].InvokeTask(([ref]$p))
            $p.Running = $false

            if ($ok -eq $true) {
                $p.Status = 'Completed'
                Write-Verbose -Message "Task Success: $taskname successful"
            }
            else {
                $p.Status = 'Failed'
            }
        }
        $RlsrInfo.Projects += $p
    }
}