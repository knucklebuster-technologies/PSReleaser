

function Get-Releaser {
    [CmdletBinding()]
    param (
    )
    
    end {
        [ReleaserConfig]$C = "$PWD\psreleaser.json" | 
        Get-Item | 
        Get-Content | 
        ConvertFrom-Json

        $C
    }
}