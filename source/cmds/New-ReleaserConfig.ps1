

function New-ReleaserConfig {
    [CmdletBinding()]
    param (
        [ValidateScript({
            $exists = [IO.directory]::Exists($PSItem)
            if ($exists) {
                $true
            }
            else {
                throw "$PSItem is not a vaild directory"
            }
        })]
        [string]$Path = "$Pwd",
        [ValidateNotNullOrEmpty()]
        [string]$Name = "releaser",
        [switch]$Force
    )
    
    end {
        Copy-Item @{
            Path = "$__ReleaserRoot__\Library\__ReleaserConfig.psd1" 
            Destination = "$Path\$Name.psd1"
            Force = $Force
        }
    }
}