<#
    UpdateVersion (PRIVATE) is a task inside of PSReleasers CI / CR system that gets the last built version
    and increments it a a variety of ways and can write the value back to module mainfest or just
    back to the configuration
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    
    # TaskName is ArchiveModule
    [string]$TaskName = $([IO.FileInfo]"$PSCommandPath").BaseName
    
    # Tasks is not for public use
    [bool]$Public = $false
    
    # A detailed paragragh on what and how this task is to be used.
    [string]$Description = @"
    UpdateVersion (PRIVATE) is used by the CI / CR system to
    create a new version number for this run. It is ran everytime by the system
    and therefore is private (so it is not called more than one per release. The
    version can be writtrn back to the moudles manifest or to just the config or
    just stored locally and used only at release
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

        $modManifest = "$Global:__ReleaserRoot__\$($cfg.Value..ModuleName).psd1"
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

    Export-ModuleMember -Variable @(
        'TaskName', 
        'Internal', 
        'Description'
        'ConfigInputs'
        'ConfigOutputs'
     ) -Function 'InvokeTask'
} -AsCustomObject
