

function Get-RlsrConfig {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = 'Path to directory that contains Rlsr project config(s)')]
        [ValidateScript( {
                if ([IO.directory]::Exists($PSItem)) {return $true}
                throw "$PSItem is not a vaild directory"
            })]
        [string]
        $Path = "$Pwd",
        
        [Parameter(HelpMessage = 'The base name of the Rlsr poject config')]
        [string]
        $Name = "*"
    )
    
    end {
        try {
            Write-Verbose -Message "Path: $Path Name: $Name"
            $Path = Resolve-Path -Path $Path
            $FullPath = "$Path\$Name.rlsrcr1.psd1"
            Write-Verbose -Message "FullPath: $FullPath"
            $cfgpath = Get-ChildItem -Path $FullPath  | Select-Object -First 1
            $cfgobject = Import-PowerShellDataFile -Path $cfgpath
            $cfgobject['FullPath'] = $FullPath
            $cfgobject
            Write-Verbose -Message "The project cfg $cfgpath was imported"
        }
        catch {
            Write-Error - @{
                'Message'  = "The project cfg $cfgpath was not imported: $_" 
                'Catagory' = 'ObjectNotFound'
                'ErrorID'  = 'Get-RlsrConfig' 
            }
        }
    }
}