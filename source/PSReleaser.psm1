
# Root of this module
$__ReleaserRoot__ = $PSScriptRoot
$__ReleaserInfo__ = Import-PowerShellDataFile -Path "$__ReleaserRoot__\library\ReleaserInfo.psd1"
$__ReleaserInfo__.Config = Import-PowerShellDataFile -Path "$__ReleaserRoot__\library\ReleaserConfig.psd1"

# Load Tasks
Get-ChildItem -Path "$__ReleaserRoot__\tasks" -Filter "*.ps1" | ForEach-Object {
    $RTasks = . $PSItem.FullName
    $__ReleaserInfo__.Tasks[$RTasks.TaskName] = $RTasks
}

# Export Dev Vars
if ($Args.Contains('DEV')) {
    Export-ModuleMember -Variable '__ReleaserInfo__', '__ReleaserRoot__'
}

# Load and Export Cmds
Get-ChildItem -Path "$__ReleaserRoot__\cmds\*ps1" | ForEach-Object {
    . $PSItem.FullName
    Export-ModuleMember -Function $PSItem.BaseName
}
