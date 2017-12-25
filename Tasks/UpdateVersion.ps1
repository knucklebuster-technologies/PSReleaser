[scriptblock]{
    Param (
        [ReleaserConfig]$Config
    )
    $dfile = "$Pwd\$($Config.Name).psd1"
    if (Test-Path $dfile) {
        $minfo = Import-PowerShellDataFile -Path $dfile
        [version]$mver = $minfo.ModuleVersion
        $Major = $mver.Major
        $Minor = $mver.Minor
        $Build = $mver.Build
        $Revision = $mver.Revision + 1
        $minfo.ModuleVersion = "$Major.$Minor.$Build.$Revision"
        return [version]$($minfo.ModuleVersion)
    }
    return $null
}