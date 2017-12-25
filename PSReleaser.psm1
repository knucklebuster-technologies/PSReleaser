
# Root of this module
$ReleaserRoot = $PSScriptRoot

$IsDev = $Args.Contains('DEV')

# Bring in the sources
#Library
. "$ReleaserRoot\Library\ReleaserConfig.ps1"
. "$ReleaserRoot\Library\ReleaserTask.ps1"

#Tasks
$ReleaserTasks = @{}
Get-ChildItem -Path "$ReleaserRoot\Tasks" | ForEach-Object {
    $tvals = . $_.FullName
    $tsk = [ReleaserTask]::New()
    $tsk.Name = $_.BaseName
    $tsk.Description = $tvals[0]
    $tsk.Script = $tvals[1]
    $ReleaserTasks[$_.BaseName] = $tsk
}
if ($IsDev) {
    Export-ModuleMember -Variable 'ReleaserTasks'
}

# Cmds
Get-ChildItem -Path "$ReleaserRoot\Cmds" | ForEach-Object {
    . $_.FullName
    Export-ModuleMember -Function $_.BaseName
}
