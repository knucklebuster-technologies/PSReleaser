<#
    ArchiveModule is a task inside of PSReleasers CI / CR system that assembles the module.
    After assembly it is compressed into a zip archive
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    
    # TaskName is ArchiveModule
    $TaskName = $([IO.FileInfo]"$PSCommandPath").BaseName
    
    # Tasks is for public use
    $Public = $true
    
    # A detailed paragragh on what and how this task is to be used.
    $Description = "ArchiveModule task perform the action of assembling the module
    into a specified location and then is compressed into a zipped archive"

    # InvokeTask runs the tasks operations and any returned values will be found
    # as properties on the Config object.
    function InvokeTask {
        $ErrorActionPreference = 'Stop'
        # modules name
        $mn = $__ReleaserInfo__.Config.ModuleName
        # module version
        $mv = 'v' + $__ReleaserInfo__.Config.ModuleVersion
        # module version for folder name
        $mvf = "$mv".Replace(".", "_")

        # releaser source and destination paths
        $src = Join-Path -Path $PWD -ChildPath $__ReleaserInfo__.Config.SourcePath
        $dest = Join-Path -Path $PWD -ChildPath $__ReleaserInfo__.Config.ReleasePath
        
        # Module destination
        $mdest = "$dest\$mvf\$mn"

        # assemble the module
        Copy-Item -Path $src -Destination $mdest -Recurse -Force

        # zip archive dest
        $zdest = "$dest\$mvf\$mn" + '_' + "$mv" + '.zip'

        # archive module
        Compress-Archive -Path $mdest -DestinationPath $zdest
    }

    Export-ModuleMember -Variable 'TaskName', 'Internal', 'Description' -Function 'InvokeTask'
} -AsCustomObject
