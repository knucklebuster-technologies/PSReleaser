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
    [string[]]$ConfigInputs = @()

    # Config values added by Task - Many values can be added as outputs
    [string[]]$ConfigOutputs = @()

    # InvokeTask runs the tasks operations and any returned values will be found
    # as properties on the Config object.
    function InvokeTask {
        Param (
            [ref]$cfg
        )
        Push-Location -Path (Resolve-Path $cfg.Value.TestPath)
        try {
            $ErrorActionPreference = 'Stop'
            Invoke-Pester
            return $true
        }
        catch {
            return $false
        }
        finally {
            Pop-Location
        }
    }

    Export-ModuleMember -Variable @(
        'TaskName', 
        'Internal', 
        'Description'
        'ConfigInputs'
        'ConfigOutputs'
     ) -Function 'InvokeTask'
} -AsCustomObject
