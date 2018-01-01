

function New-RlsrLogEntry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage = 'Time Log Entry was created')]
        [string]
        $Timestamp = [DateTime]::NoW.ToString('yyyyMMddHHmmss'),

        [Parameter(Mandatory, HelpMessage = 'Controls what types of entries are logged')]
        [ValidateSet('INFO', 'WARN', 'ERROR', 'FATAL', 'DEBUG', 'VERBOSE')]
        [string]
        $Level,

        [Parameter(Mandatory, HelpMessage = 'Context named block that generated the LogEntry')]
        [ValidateNotNullOrEmpty()]
        [string]
        $RunName,

        [Parameter(Mandatory, HelpMessage = 'Context named block that generated the LogEntry')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Context,

        [Parameter(Mandatory, HelpMessage = 'Controls what types of entries are logged')]
        [ValidateNotNullOrEmpty()]
        $Message
    )
    
    end {
        Write-Output @{
            'Timestamp'   = $Timestamp
            'Level'       = $Level
            'RunName'     = $RunName
            'Context'     = $Context
            'Message'     = $Message
            'LogEntry'    = [string]::Join(' || ', $Timestamp, $Level, $RunName, $Context, $Message)
        }
    }
}