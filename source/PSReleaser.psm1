
# Root of this module
$__ReleaserRoot__ = $PSScriptRoot
$__ReleaserInfo__ = Import-PowerShellDataFile -Path "$__ReleaserRoot__\Library\ReleaserInfo.psd1"
$IsDev = $Args.Contains('DEV')

# Bring in the sources
#Tasks
Get-ChildItem -Path "$__ReleaserRoot__\Tasks" | ForEach-Object {
    $tvals = . $PSItem.FullName
    $__ReleaserTask__ = Import-PowerShellDataFile -Path "$__ReleaserRoot__\Library\ReleaserTask.psd1"
    $__ReleaserTask__.Name = $PSItem.BaseName
    $__ReleaserTask__.Description = $tvals[0]
    $__ReleaserTask__.ScriptBlock = $tvals[1]
    $__ReleaserInfo__.Tasks[$PSItem.BaseName] = $__ReleaserTask__
}
if ($IsDev) {
    Export-ModuleMember -Variable '__ReleaserInfo__'
}

# Cmds
Get-ChildItem -Path "$__ReleaserRoot__\Cmds" | ForEach-Object {
    . $PSItem.FullName
    Export-ModuleMember -Function $PSItem.BaseName
}
