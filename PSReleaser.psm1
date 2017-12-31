
$RlsrInfo = Import-PowerShellDataFile "$PSScriptRoot\models\RlsrInfo.psd1"
$RlsrInfo.RootPath = $PSScriptRoot

# Load Tasks
Get-ChildItem -Path "$($RlsrInfo.RootPath)\tasks" | ForEach-Object {
    $RTasks = . $PSItem.FullName
    $RlsrInfo.Tasks[$RTasks.TaskName] = $RTasks
}

# Export Dev Vars
if ($Args.Contains('DEV')) {
    Export-ModuleMember -Variable 'RlsrInfo'
}

# Load and Export Cmds
Get-ChildItem -Path "$($RlsrInfo.RootPath)\cmds\*ps1" | ForEach-Object {
    . $PSItem.FullName
    Export-ModuleMember -Function $PSItem.BaseName
}
