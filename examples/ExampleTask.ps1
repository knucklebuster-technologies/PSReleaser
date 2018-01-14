<#
    ExampleTask is the minimum you need to create a new task inside of
    PSReleasers CI / CR system.
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    # TaskName will be ExampleTask
    [string]$Name = $([IO.FileInfo]"$PSCommandPath").BaseName
    # This task is public
    [bool]$Public = $true
    # Value inputs used by Task
    [string[]]$Inputs = @()
    # Value outputs created by task
    [string[]]$Outputs = @()
    # describe the task and its operations
    [string]$Description = 'Describe the Task'
    # InvokeTask runs the tasks operations
    function InvokeTask {
        Param (
            [ref]$project
        )

        $project.Value.Log('INFO', 'TASK: ' + $this.Name, 'Starting Task')
        try {
            $ErrorActionPreference = 'Stop'
            Write-Verbose -Message 'Hello World From ExampleTask'
            $true
        }
        catch {
            $PSItem
        }
        $project.Value.Log('INFO', 'TASK: ' + $this.Name, 'Ending Task')

    }

    Export-ModuleMember -Variable @(
        'Name', 
        'Public', 
        'Description'
        'Inputs'
        'Outputs'
     ) -Function 'InvokeTask'
} -AsCustomObject
