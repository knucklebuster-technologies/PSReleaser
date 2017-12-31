

function New-LogEntry {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, HelpMessage='Describes the event being logged')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message,

        [Parameter(Mandatory, HelpMessage='RunName is the project name and UID to trace logging')]
        [ValidateNotNullOrEmpty()]
        [string]
        $RunName,

        [Parameter(Mandatory, HelpMessage='Context named block that generated the LogEntry')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Context,

        [Parameter(Mandatory, HelpMessage='Controls what types of entries are logged')]
        [ValidateSet('INFO', 'WARN', 'ERROR', 'FATAL', 'DEBUG', 'VERBOSE')]
        $Level = 'INFO'
    )
    
    begin {
    }
    
    process {
    }
    
    end {
    }
}