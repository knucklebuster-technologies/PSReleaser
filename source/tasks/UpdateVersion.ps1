<#
    UpdateVersion (PRIVATE) is a task inside of PSReleasers CI / CR system that gets the last built version
    and increments it a a variety of ways and can write the value back to module mainfest or just
    back to the configuration
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    
    # TaskName is ArchiveModule
    $TaskName = $([IO.FileInfo]"$PSCommandPath").BaseName
    
    # Tasks is not for public use
    $Public = $false
    
    # A detailed paragragh on what and how this task is to be used.
    $Description = "UpdateVersion (PRIVATE) is used by the CI / CR system to
    create a new version number for this run. It is ran everytime by the system
    and therefore is private (so it is not called more than one per release. The
    version can be writtrn back to the moudles manifest or to just the config or
    just stored locally and used only at release"

    # InvokeTask runs the tasks operations and any returned values will be found
    # as properties on the Config object.
    function InvokeTask {
        $C = $__ReleaserInfo__.Config
        $modManifest = "$__ReleaserRoot__\$($C.ModuleName).psd1"
        if (Test-Path -Path $modManifest) {
            $minfo = Import-PowerShellDataFile -Path $modManifest
            [version]$mver = $minfo.
            $Major = $mver.Major
            $Minor = $mver.Minor
            $Build = $mver.Build
            $Revision = $mver.Revision + 1
            [version]$mver = "$Major.$Minor.$Build.$Revision"
        }
    }

    Export-ModuleMember -Variable 'TaskName', 'Internal', 'Description' -Function 'InvokeTask'
} -AsCustomObject
