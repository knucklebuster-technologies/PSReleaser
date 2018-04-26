

function New-RlsrLogEntry {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = 'Time Log Entry was created')]
        [string]
        $Timestamp = [DateTime]::NoW.ToString('s'),

        [Parameter(Mandatory, HelpMessage = 'The log entries serverity level')]
        [ValidateSet('INFO', 'WARN', 'ERROR', 'FATAL', 'DEBUG', 'VERBOSE')]
        [string]
        $Level,

        [Parameter(Mandatory, HelpMessage = 'Unique Task Run Name Id. derived from TaskName and the time the task started running')]
        [ValidateNotNullOrEmpty()]
        [string]
        $RunName,

        [Parameter(Mandatory, HelpMessage = 'Context is the name (Id) of the script, block, function, or variable generating the entry')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Context,

        [Parameter(Mandatory, HelpMessage = 'Description of a specific tasks event')]
        [ValidateNotNullOrEmpty()]
        [string]
        $Message
    )

    end {
        try {
            $ErrorActionPreference = 'Stop'
            [PSCustomObject] @{
                Timestamp = $Timestamp
                Level     = $Level
                RunName   = $RunName
                Context   = $Context
                Message   = $Message
            } |
            Add-Member -MemberType ScriptMethod -Name ToString -Value {
                [string]::Join(
                    '||',
                    $this.Timestamp,
                    $this.Level,
                    $this.RunName,
                    $this.Context,
                    $this.Message
                )
            } -Force -PassThru
        }
        catch {
            $RlsrInfo.EngineErrors += ConvertFrom-ErrorRecord -Record $_
            throw $_
        }
    }
}