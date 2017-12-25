

function New-Releaser {
    [CmdletBinding()]
    param (
    )
    
    end {
        $c = [ReleaserConfig]::New()
        $c.Name = $(Get-Item -Path $PWD).Name
        $c | ConvertTo-Json | Out-File -FilePath "$PWD\psreleaser.json" -Force
    }
}