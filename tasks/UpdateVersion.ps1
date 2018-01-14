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
            $project.Value.Log('INFO', 'TASK: ' + $this.Name, "Starting Version from Manifest $mver")

            # Get the parts of the version
            $Major, $Minor, $Build, $Revision = $mver.Major, $mver.Minor, $mver.Build, $mver.Revision
            
            # Increment the parts of the version
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
            
            # Put together part of the version
            $mver = [version] "$Major.$Minor.$Build.$Revision"

            # Update the module manifest
            $project.Value.Manifest | 
            Add-Member -MemberType NoteProperty -Name 'Version' -Value $mver -Force
            $project.Value.LockInfo |
            Add-Member -MemberType NoteProperty -Name 'Version' -Value "$mver" -Force
            $project.Value.Log('INFO', 'TASK: ' + $this.Name, "Updated Version to Manifest: $mver")
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
