

function Get-RlsrConfig {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage='Path to directory that contains Rlsr project config(s)')]
        [ValidateScript({
            if ([IO.directory]::Exists($PSItem)) {return $true}
            throw "$PSItem is not a vaild directory"
        })]
        [string]
        $Path = "$Pwd",
        
        [Parameter(HelpMessage='The base name of the Rlsr poject config')]
        [string]
        $Name = "releaser"
    )
    
    end {
        $cfgpath = Join-Path -Path $Path -ChildPath "$Name.psd1"
        if (Test-Path -Path $cfgpath) {
            Import-PowerShellDataFile -Path $cfgpath
            Write-Verbose -Message "The project cfg $cfgpath was imported"
        }
        else {
            Write-Error - @{
                'Message'  = "The project cfg $cfgpath does not exist" 
                'Catagory' = 'ObjectNotFound'
                'ErrorID'  = 'Get-RlsrConfig' 
            }
        }
    }
}