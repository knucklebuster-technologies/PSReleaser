
# Root of this module
$ReleaserRoot = $PSScriptRoot

$IsDev = $Args.Contains('DEV')

# Bring in the sources
#Library
. "$ReleaserRoot\Library\ReleaserConfig.ps1"

#Tasks
$ReleaserTasks = @{}
Get-ChildItem -Path "$ReleaserRoot\Tasks" | ForEach-Object {
    $ReleaserTasks[$_.BaseName] = $(. $_.FullName)
}
if ($IsDev) {
    Export-ModuleMember -Variable 'ReleaserTasks'
}

# Cmds
Get-ChildItem -Path "$ReleaserRoot\Cmds" | ForEach-Object {
    . $_.FullName
    Export-ModuleMember -Function $_.BaseName
}
