<#
    ExampleTask is the minimum you need to create a new task inside of
    PSReleasers CI / CR system.
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    
    [string]$Name = $([IO.FileInfo]"$PSCommandPath").BaseName
    [bool]$Public = $true
    [string[]]$Inputs = @('Cfg.FullPath')
    [string[]]$Outputs = @()
    [string]$Description = 'Stage all changes for commit'
    function InvokeTask {
        Param (
            [ref]$project
        )

        $project.Value.Log('INFO', 'TASK: ' + $this.Name, 'Starting Task')
        $ErrorActionPreference = 'Stop'
        Push-Location -Path (Split-Path $project.Value.Cfg.FullPath -Parent)
        Invoke-Expression -Command 'git add --all'
        if($LASTEXITCODE -eq 0) {
            $true
        }
        else {
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
