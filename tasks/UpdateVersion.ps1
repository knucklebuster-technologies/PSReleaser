New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    [string]$Name = $([IO.FileInfo]"$PSCommandPath").BaseName
    [bool]$Public = $true
    [string[]]$Inputs = @('LockInfo.Version', 'Cfg.BuildType', 'Cfg.PreReleaseTag')
    [string[]]$Outputs = @('LockInfo.Version')
    [string]$Description = 'Create a unique version for the project release'
    function InvokeTask {
        Param (
            [ref]$project
        )

        $project.Value.Log('INFO', 'TASK: ' + $this.Name, 'Starting Task')
        try {
            $ErrorActionPreference = 'Stop'
            
            $semver = $(New-SemanticVersion).Parse($project.Value.LockInfo.Version)
            $project.Value.Log('INFO', 'TASK: ' + $this.Name, "Starting Version from LockFile $semver")

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
                'Patch' {
                    $semver.Patch = $semver.Patch + 1
                    $semver.BuildRevision = $semver.BuildRevision + 1
                }
                'None' {
                    # Turns Off All Version Updates
                }
                Default {
                    $semver.BuildRevision = $semver.BuildRevision + 1
                }
            }
            # Update the Tag to make sure we grab any change
            $semver.PreReleaseTag = $project.Value.Cfg.PreReleaseTag

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
