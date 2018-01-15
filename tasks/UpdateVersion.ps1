<#
    UpdateVersion is a task inside of PSReleasers CI / CR system that gets the last built version
    and increments it a a variety of ways and can write the value back to module mainfest or just
    back to the configuration
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    [string]$Name = $([IO.FileInfo]"$PSCommandPath").BaseName
    [bool]$Public = $true
    [string[]]$Inputs = @('Cfg.Manifest.Version', 'Cfg.ReleaseType', 'Cfg.ReleasePhase')
    [string[]]$Outputs = @('Cfg.Manifest.Version', 'LockInfo.Version')
    [string]$Description = 'Used by the system to create a unique version for this run / release'
    function InvokeTask {
        Param (
            [ref]$project
        )

        $project.Value.Log('INFO', 'TASK: ' + $this.Name, 'Starting Task')
        try {
            $ErrorActionPreference = 'Stop'
            
            # Get the current module version
            $mver = [version]::Parse("$($project.Value.Manifest.Version)")
            $semver = New-SemanticVersion -Major $mver.Major -Minor $mver.Minor -Patch $mver.Build -BuildRevision $mver.Revision -PrereleaseTag $project.Value.Cfg.PrereleaseTag
            $project.Value.Log('INFO', 'TASK: ' + $this.Name, "Starting Version from Manifest $semver")

            # Increment the parts of the version
            switch ($project.Value.Cfg.BuildType) {
                'Major' {
                    $semver.Major = $semver.Major + 1
                    $semver.Minor = 0
                    $semver.Patch = 0
                    $semver.BuildRevision = 1
                }
                'Minor' {
                    $semver.Minor = $semver.Minor + 1
                    $semver.Patch = 0
                    $semver.BuildRevision = $semver.BuildRevision + 1
                }
                {($_ -eq "Build") -or ($_ -eq "Patch")} {
                    $semver.Patch = $semver.Path + 1
                    $semver.BuildRevision = $semver.BuildRevision + 1
                }
                Default {
                    $semver.BuildRevision = $semver.BuildRevision + 1
                }
            }
            
            # Update the module manifest
            $project.Value.Manifest | 
            Add-Member -MemberType NoteProperty -Name 'Version' -Value ($semver.ToMSVersion()) -Force
            $project.Value.LockInfo |
            Add-Member -MemberType NoteProperty -Name 'Version' -Value "$semver" -Force
            $project.Value.Log('INFO', 'TASK: ' + $this.Name, "Updated Version to Manifest: $semver")
            $true
        }
        catch {
            $false
        }
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
