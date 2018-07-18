New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    [string]$Name = $([IO.FileInfo]"$PSCommandPath").BaseName
    [bool]$Public = $true
    [string[]]$Inputs = @('Lock.Version', 'Cfg.BuildType', 'Cfg.PreReleaseTag')
    [string[]]$Outputs = @('Lock.Version')
    [string]$Description = 'Create a unique version for the project release'
    function InvokeTask {
        Param (
            [ref]$project
        )

        $project.Value.Log('INFO', 'TASK: ' + $this.Name, 'Starting Task')
        try {
            $ErrorActionPreference = 'Stop'
            $PRoot = Split-Path -Path $project.Value.Cfg.FullPath -Parent
            $PSD1 = $project.Value.Cfg.ModuleName + '.psd1'
            $ModPath = Join-Path -Path $PRoot -ChildPath $PSD1

            $semver = New-SemanticVersion
            $semver.FromVersionJson($PRoot) | Out-Null
            $project.Value.Log('INFO', 'TASK: ' + $this.Name, "Starting Version $semver")

            # Increment the parts of the version
            switch ($project.Value.Cfg.BuildType) {
                'Major' {
                    $semver.Major = $semver.Major + 1
                    $semver.Minor = 0
                    $semver.Patch = 0
                    $semver.Build = 1
                }
                'Minor' {
                    $semver.Minor = $semver.Minor + 1
                    $semver.Patch = 0
                    $semver.Build = $semver.Build + 1
                }
                'Patch' {
                    $semver.Patch = $semver.Patch + 1
                    $semver.Build = $semver.Build + 1
                }
                'None' {
                    # Turns Off All Version Updates
                }
                Default {
                    $semver.Build = $semver.Build + 1
                }
            }
            # Update the Tag to make sure we grab any change
            $semver.Tag = $project.Value.Cfg.Tag

            $semver.ToVersionJson($PRoot) | Out-Null
            Update-ModuleManifest -Path $ModPath -ModuleVersion $semver.ToSystemVersion()
            $project.Value.Log('INFO', 'TASK: ' + $this.Name, "Updated Version $semver")
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
