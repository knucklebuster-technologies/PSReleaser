

function New-ReleaserConfig {
    [CmdletBinding()]
    param (
        $Path = "$Pwd"
    )
    
    end {
        if ([IO.directory]::Exists($Path)) {
            $c = [ReleaserConfig]::New()
            $c.Name = $(Get-Item -Path $Path).Name
            $c | ConvertTo-Json | Out-File -FilePath "$Path\psreleaser.json" -Force
        }
        else {
            throw "The -Path parameter value $Path is not a vaild directory"
        }
    }
}