
# Root of this module
$Global:__ReleaserRoot__ = $PSScriptRoot
$Global:__ReleaserInfo__ = Import-PowerShellDataFile "$__ReleaserRoot__\library\ReleaserInfo.psd1"
$Global:__ReleaserInfo__.Config = Import-PowerShellDataFile "$__ReleaserRoot__\library\ReleaserConfig.psd1"

# Load Tasks
Get-ChildItem -Path "$Global:__ReleaserRoot__\tasks" -Filter "*.ps1" | ForEach-Object {
    $RTasks = . $PSItem.FullName
    $Global:__ReleaserInfo__.Tasks[$RTasks.TaskName] = $RTasks
}

# Export Dev Vars
if ($Args.Contains('DEV')) {
    Export-ModuleMember -Variable '__ReleaserInfo__', '__ReleaserRoot__'
}

# Load and Export Cmds
Get-ChildItem -Path "$Global:__ReleaserRoot__\cmds\*ps1" | ForEach-Object {
    . $PSItem.FullName
    Export-ModuleMember -Function $PSItem.BaseName
}
