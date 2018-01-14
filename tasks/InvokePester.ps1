<#
    ExampleTask is the minimum you need to create a new task inside of
    PSReleasers CI / CR system.
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    
    [string]$Name = $([IO.FileInfo]"$PSCommandPath").BaseName
    [bool]$Public = $true
    [string[]]$Inputs = @('Cfg.FullPath')
    [string[]]$Outputs = @()
    [string]$Description = 'Runs all Pester tests under the project directory'
    
    function InvokeTask {
        Param (
            [ref]$project
        )

        $project.Value.Log('INFO', 'TASK: ' + $this.Name, 'Starting Task')
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
