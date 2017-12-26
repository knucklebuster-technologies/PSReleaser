

function Start-ReleaserEngine {
    [CmdletBinding()]
    param (
        $Path = "$Pwd"
    )

    end {
        $config = Get-ReleaserConfig -Path $Path
        $config.Tasks | ForEach-Object {
            $ReleaserInfo.Tasks[$PSItem].Script.Invoke($config)
        }
    }
}