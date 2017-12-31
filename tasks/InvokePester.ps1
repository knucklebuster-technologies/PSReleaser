<#
    ExampleTask is the minimum you need to create a new task inside of
    PSReleasers CI / CR system.
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    
    # TaskName will be ExampleTask
    [string]$TaskName = $([IO.FileInfo]"$PSCommandPath").BaseName
    
    # This task is public
    [bool]$Public = $true
    
    # A detailed paragragh on what and how this task is to be used.
    [string]$Description = @"
    The minimum you need to create a new task inside of
    PSReleasers CI / CR system. It Will print 'Hello World From ExampleTask' to the console
    using Write-Host (puppie killerz)
"@

    # Config values used by Task - Many values can be used as inputs
    [string[]]$ConfigInputs = @('SourcePath')

    # Config values added by Task - Many values can be added as outputs
    [string[]]$ConfigOutputs = @()

    # InvokeTask runs the tasks operations and any returned values will be found
    # as properties on the Config object.
    function InvokeTask {
        Param (
            [ref]$project
        )
        try {
            $ErrorActionPreference = 'Stop'
            Push-Location $project.Value.Cfg.SourcePath
            Invoke-Pester
            $true
        }
        catch {
            $false
        }
        Pop-Location
    }

    Export-ModuleMember -Variable @(
        'TaskName', 
        'Internal', 
        'Description'
        'ConfigInputs'
        'ConfigOutputs'
     ) -Function 'InvokeTask'
} -AsCustomObject
