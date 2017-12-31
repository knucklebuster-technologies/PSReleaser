

function Start-RlsrEngine {
    [CmdletBinding()]
    param (
        $Path = "$Pwd",
        $Name = 'releaser'
    )

    end {
        Write-Verbose -Message "Engine Values: Path=$Path, Name=$Name"
        $p = Get-RlsrProject
        $p.Timestamp = [DateTime]::NoW.ToString('yyyyMMddHHmmss')
        $p.Cfg = Get-RlsrConfig -Path $Path -Name $Name
        $p.RunName = $p.Cfg.ModuleName + '::' + $p.Timestamp
        $p.Manifest = Test-ModuleManifest -Path "$($p.Cfg.SourcePath)\$($p.Cfg.ModuleName).psd1"
        $p.Status = 'Running'
        $p.Running = $true
        
        Write-Verbose -Message "Engine Starting: RUN $($p.RunName) For Module $($p.Cfg.ModuleName) CI process started"
        $p.Cfg.TaskSequence | ForEach-Object {
            $taskname = "$PSItem"
            Write-Verbose -Message "Task Invocation: $taskname invoked"
            if ($RlsrInfo.Tasks[$taskname].InvokeTask(([ref]$p))) {
                Write-Verbose -Message "Task Success: $taskname successful"
            }
            else {
                $null = $p.Log.Where({$PSItem -Like 'ERROR|*'})
            }
            
        }

        $p.Status = 'Completed'
        $p.Running = $false
        $RlsrInfo.Projects += $p
    }
}