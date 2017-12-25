

function Get-ReleaserConfig {
    [CmdletBinding()]
    param (
        $Path = "$Pwd"
    )
    
    end {
        "$Path\psreleaser.json" | Get-Item | Get-Content | ConvertFrom-Json
    }
}