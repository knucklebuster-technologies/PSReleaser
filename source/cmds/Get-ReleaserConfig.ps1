

function Get-ReleaserConfig {
    [CmdletBinding()]
    param (
        [ValidateScript({
            if ([IO.directory]::Exists($PSItem)) {return $true}
            throw "$PSItem is not a vaild directory"
        })]
        [string]$Path = "$Pwd",
        [string]$Name = "releaser"
    )
    
    end {
        Import-PowerShellDataFile -Path "$Path\$Name.psd1"
    }
}