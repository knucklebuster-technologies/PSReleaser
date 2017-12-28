

function Start-ReleaserEngine {
    [CmdletBinding()]
    param (
        $Path = "$Pwd"
    )

    end {
        $Global:cfg = Get-ReleaserConfig -Path $Path
        $cfg.TaskSequence | ForEach-Object {
            $null = $Global:__ReleaserInfo__.Tasks[$PSItem].InvokeTask(([ref]$cfg))
        }
    }
}