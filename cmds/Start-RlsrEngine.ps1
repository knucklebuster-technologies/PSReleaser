

function Start-RlsrEngine {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage="The path to the directory containg the rlsr project files")]
        [string]
        $Path = "$Pwd"
    )

    end {
        $ErrorActionPreference = 'Stop'
        Write-Verbose -Message "Engine Values: Path=$Path"
        $Path = Resolve-Path -Path $Path
        Write-Verbose -Message "Directory Path: $Path"
        $p = New-RlsrProject
        $p.Cfg = Join-Path -Path $Path -ChildPath "psreleaser.cfg"
        $p.Lock = Join-Path -Path $Path -ChildPath 'psreleaser.lock'
        $p.Manifest = Get-ChildItem -Path $Path -Include "*psd1" -File | Select-Object -First 1
        $p.Timestamp = [DateTime]::NoW.ToString('yyyyMMddHHmmss')
        $p.RunName = "$(Split-Path -Path $p.Manifest -Leaf)".Replace('.psd1','') + '::' + $p.Timestamp
        $p.Status = 'Running'
        $p.Running = $true

        Write-Verbose -Message "Engine Starting: RUN $($p.RunName) For Module $($p.Cfg.ModuleName) CI process started"
        $(Import-RlsrCfgFile -Path $p.Cfg).TaskSequence | ForEach-Object {
            $taskname = "$PSItem"
            Write-Verbose -Message "Task Invocation: $taskname invoked"
            $ok = $RlsrEngine.Tasks[$taskname].InvokeTask(([ref]$p))
            $p.Running = $false

            if ($ok -eq $true) {
                $p.Status = 'Completed'
                Write-Verbose -Message "Task Success: $taskname successful"
            }
            else {
                $p.Status = 'Failed'
            }
        }
        $RlsrEngine.Projects += $p
    }
}