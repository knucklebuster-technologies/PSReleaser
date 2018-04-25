

function Get-RlsrProject {
    [CmdletBinding()]
    param ()

    end {
        try {
            $ErrorActionPreference = 'Stop'
            [PSCustomObject] @{
                Timestamp  = '20173112013555'
                RunName    = 'null::20173112011045'
                Status     = 'New'
                Running    = 'False'
                Cfg        = New-Object 'PSCustomObject'
                Manifest   = @{}
                LockInfo   = New-Object 'PSCustomObject'
                Completed  = @()
                LogEntries = @()
            } |
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
                switch ($Level) {
                    'INFO'    { $LogEntry.ToString() | Write-Host }
                    'WARN'    { $LogEntry.ToString() | Write-Host -ForegroundColor Yellow }
                    'ERROR'   { $LogEntry.ToString() | Write-Host -ForegroundColor Red }
                    'DEBUG'   { $LogEntry.ToString() | Write-Host -ForegroundColor Green }
                    'VERBOSE' { $LogEntry.ToString() | Write-Host -ForegroundColor Blue }
                    Default   { $LogEntry.ToString() | Write-Host -ForegroundColor Magenta }
                }
            } -Force -PassThru
            Write-Verbose -Message "The project obj was created"
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