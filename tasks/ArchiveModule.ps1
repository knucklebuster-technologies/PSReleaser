<#
    ArchiveModule is a task inside of RlserCR system that assembles the module.
    After assembly it is compressed into a zip archive
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    [string]$TaskName = $([IO.FileInfo]"$PSCommandPath").BaseName
    [bool]$Public = $true
    [string]$Description = @"
    ArchiveModule task perform the action of assembling the module
    into a specified location and then is compressed into a zipped archive
"@

    [string[]]$ConfigInputs = @(
        'ModuleName',
        'ModuleManifest.ModuleVersion',
        'SourcePath', 
        'ReleasePath'
    )

    [string[]]$ConfigOutputs = @(   
    )

    function InvokeTask {
        [CmdletBinding()]
        Param (
            [Parameter(Mandatory, HelpMessage='Reference variable pointing to an instance of the RlsrProject model being run.')]
            [ref]
            $project
        )

        try {
            $ErrorActionPreference = 'Stop'
            # modules name
            $mn = $project.Value.Cfg.ModuleName
            Write-Verbose -Message "ArchiveModule Name: $mn"

            # module version
            $mv = $project.Value.Manifest.ModuleVersion.ToSemver()
            Write-Verbose -Message "ArchiveModule Tag: $mv"

            # module version for folder name
            $mvf = "$mv".Replace(".", "_")

            # releaser source path
            $src = Join-Path -Path $PWD -ChildPath $project.Value.Cfg.SourcePath
            
            
            # Module destination path
            $dest = Join-Path -Path $PWD -ChildPath $project.Value.Cfg.ReleasePath
            $mdest = "$dest\$mvf\$mn"
            

            # copy the module
            Copy-Item -Path $src -Destination $mdest -Recurse -Force
            Write-Verbose -Message "ArchiveModule Released: $mdest"

            # zip archive dest
            $zdest = "$dest\$mvf\$mn" + '.' + "$mv" + '.zip'

            # archive module
            Compress-Archive -Path $mdest -DestinationPath $zdest -Force
            Write-Verbose -Message "ArchiveModule Zipped: $zdest"
            $true
        }
        catch {
            $false
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
