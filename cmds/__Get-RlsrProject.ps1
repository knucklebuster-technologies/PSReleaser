

function Get-RlsrProject {
    [CmdletBinding()]
    param ()
    
    end {
        try {
            $ErrorActionPreference = 'Stop'
            $prjpath = "$($RlsrInfo.RootPath)\models\RlsrProject.psd1"
            [PSCustomObject] $(Import-PowerShellDataFile -Path $prjpath) |
                Add-Member -MemberType ScriptMethod -Name Log -Value {
                Param (
                    [Parameter(Mandatory, HelpMessage = 'The log entries serverity level')]
                    [ValidateSet('INFO', 'WARN', 'ERROR', 'FATAL', 'DEBUG', 'VERBOSE')]
                    [string]
                    $Level,
                    
                    [Parameter(Mandatory, HelpMessage = 'Context is the name (Id) of the script, block, function, or variable generating the entry')]
                    [ValidateNotNullOrEmpty()]
                    [string]
                    $Context,

                    [Parameter(Mandatory, HelpMessage = 'Description of a specific tasks event')]
                    [ValidateNotNullOrEmpty()]
                    [string]
                    $Message
                )
                $LogEntry = New-RlsrLogEntry -Level $Level -RunName $this.RunName -Context $Context -Message $Message
                $this.LogEntries += $LogEntry
                $LogEntry.ToString() | Write-Host -ForegroundColor Blue
            } -Force -PassThru
            Write-Verbose -Message "The project obj $prjpath was imported"
        }
        catch {
            Write-Error @{
                'Message'  = "The project obj $prjpath does not exist" 
                'Catagory' = 'ObjectNotFound'
                'ErrorID'  = 'Get-RlsrProject' 
            }
        }
    }
}