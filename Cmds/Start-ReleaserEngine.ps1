

function Start-ReleaserEngine {
    [CmdletBinding()]
    param (
        $Path = "$Pwd"
    )

    end {
        $config = Get-ReleaserConfig -Path $Path
        $config.Tasks | ForEach-Object {
            $ReleaserTasks[$PSItem].Script.Invoke($config)
        }
    }
}