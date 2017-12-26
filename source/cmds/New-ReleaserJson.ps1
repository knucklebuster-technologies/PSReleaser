

function New-ReleaserJson {
    [CmdletBinding()]
    param (
        [ValidateScript({
            if ([IO.directory]::Exists($PSItem)) {return $true}
            throw "$PSItem is not a vaild directory"
        })]
        [string]$Path = "$Pwd",
        [ValidateNotNullOrEmpty()]
        [string]$Name = "psreleaser",
        [switch]$Force
    )
    
    end {
        Import-PowerShellDataFile -Path "$__ReleaserRoot__\Library\ReleaserConfig.psd1" |
        ConvertTo-Json |
        Out-File -FilePath "$Path\$Name.json" -Force:$Force -ErrorAction Stop
    }
}