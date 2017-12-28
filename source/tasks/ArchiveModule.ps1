<#
    ArchiveModule is a task inside of PSReleasers CI / CR system that assembles the module.
    After assembly it is compressed into a zip archive
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    
    # TaskName is ArchiveModule
    [string]$TaskName = $([IO.FileInfo]"$PSCommandPath").BaseName
    
    # Tasks is for public use
    [bool]$Public = $true
    
    # A detailed paragragh on what and how this task is to be used.
    [string]$Description = @"
    ArchiveModule task perform the action of assembling the module
    into a specified location and then is compressed into a zipped archive
"@

    # Config values used by Task - Many values can be used as inputs
    [string[]]$ConfigInputs = @(
        'ModuleName',
        'ReleaseVersion',
        'SourcePath', 
        'ReleasePath'
    )

    # Config values added by Task - Many values can be added as outputs
    [string[]]$ConfigOutputs = @()

    # InvokeTask runs the tasks operations and any returned values will be found
    # as properties on the Config object.
    function InvokeTask {
        Param (
            [ref]$cfg
        )
        try {
            $ErrorActionPreference = 'Stop'
            # modules name
            $mn = $cfg.Value['ModuleName']
            # module version
            $mv = 'v' + "$($cfg.Value['ReleaseVersion'])"
            # module version for folder name
            $mvf = "$mv".Replace(".", "_")

            # releaser source and destination paths
            $src = Join-Path -Path $PWD -ChildPath $cfg.Value['SourcePath']
            $dest = Join-Path -Path $PWD -ChildPath $cfg.Value['ReleasePath']
            
            # Module destination
            $mdest = "$dest\$mvf\$mn"

            # assemble the module
            Copy-Item -Path $src -Destination $mdest -Recurse -Force

            # zip archive dest
            $zdest = "$dest\$mvf\$mn" + '_' + "$mv" + '.zip'

            # archive module
            Compress-Archive -Path $mdest -DestinationPath $zdest

            $cfg.Value['ArchiveModule'] = 'ran'

            return $true
        }
        catch {
            return $false
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
