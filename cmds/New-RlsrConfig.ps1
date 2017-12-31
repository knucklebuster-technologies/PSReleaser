

function New-RlsrConfig {
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
        try {
            $p = "$($RlsrInfo.RootPath)\models\RlsrConfig.psd1"
            $d = Join-Path -Path $Path -ChildPath "$Name.psd1"
            Copy-Item @{
                Path = $p
                Destination = $d
                Force = $Force
            }
            Write-Verbose -Message "Project cfg $d was created"
        }
        catch {
            Write-Verbose @{
                'Message'  = "Project cfg $d was not created"
                'Category' = "WriteError"
            }
        }
    }
}