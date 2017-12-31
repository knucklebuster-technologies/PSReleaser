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
    [string[]]$ConfigInputs = @(
        'ModuleManifest.ModuleVersion'
    )

    # Config values added by Task - Many values can be added as outputs
    [string[]]$ConfigOutputs = @('ModuleManifest.ModuleVersion')

    # InvokeTask runs the tasks operations and any returned values will be found
    # as properties on the Config object.
    function InvokeTask {
        Param (
            [ref]$project
        )
        try {
            $ErrorActionPreference = 'Stop'
            
            [version]$mver = $null
            $null = [version]::TryParse($project.Value.Manifest.ModuleVersion, ([ref]$mver))
            $Major, $Minor, $Build, $Revision = $mver.Major, $mver.Minor, $mver.Build, $mver.Revision
            
            switch ($project.Value.Cfg.ReleaseType) {
                'Major' {
                    $Major = $mver.Major + 1
                    $Minor = 0
                    $Build = 0
                    $Revision = 1
                }
                'Minor' {
                    $Minor = $mver.Minor + 1
                    $Build = 0
                    $Revision = 1
                }
                {($_ -eq "Build") -or ($_ -eq "Patch")} {
                    $Build = $mver.Build + 1
                    $Revision = $mver.Revision + 1
                }
                Default {
                    $Revision = $mver.Revision + 1
                }
            }
            
            $null = [version]::TryParse("$Major.$Minor.$Build.$Revision", ([ref]$mver))
            $project.Value.Manifest.ModuleVersion = $mver | 
            Add-Member -MemberType 'NoteProperty' -Name 'Patch' -Value $this.Build -Force -PassThru |
            Add-Member -MemberType 'NoteProperty' -Name 'Phase' -Value $project.Value.Cfg.ReleasePhase -Force -PassThru |
            Add-Member -MemberType 'ScriptMethod' -Name 'ToSemver' -Value {
                $bver = 'v' + $this.Major + '.' + $this.Minor + '.' + $this.Build
                if ([string]::IsNullOrEmpty($this.ReleasePhase)) {
                    return $bver
                }
                return $bver + '-' + $this.ReleasePhase
            } -Force -PassThru

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
