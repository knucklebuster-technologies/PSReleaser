

function Start-ReleaserEngine {
    [CmdletBinding()]
    param (
        $Path = "$Pwd"
    )

    end {
        $Global:__ReleaserInfo__.Config = Get-ReleaserConfig -Path $Path
        $Global:__ReleaserInfo__.Config | ForEach-Object {
            $Global:__ReleaserInfo__.Tasks[$PSItem].InvokeTask(([ref]$Global:__ReleaserInfo__.Config))
        }
    }
}