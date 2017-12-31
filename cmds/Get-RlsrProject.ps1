

function Get-RlsrProject {
    [CmdletBinding()]
    param ()
    
    end {
        $prjpath = "$($RlsrInfo.RootPath)\models\RlsrProject.psd1"
        if (Test-Path -Path $prjpath) {
            Import-PowerShellDataFile -Path $prjpath
            Write-Verbose -Message "The project obj $prjpath was imported"
        }
        else {
            Write-Error @{
                'Message'  = "The project obj $prjpath does not exist" 
                'Catagory' = 'ObjectNotFound' 
            }
        }
    }
}