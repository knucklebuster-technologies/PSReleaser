# Import Dependancies
Import-Module "$PSScriptRoot\modules\PSSemanticVersion" -Force -Scope Local

# Load and Export Vars
Get-ChildItem -Path "$PSScriptRoot\vars\*ps1" | ForEach-Object {
    . $PSItem.FullName
    Export-ModuleMember -Variable $PSItem.BaseName
}

# Load and Export Cmds
Get-ChildItem -Path "$PSScriptRoot\cmds\*ps1" | ForEach-Object {
    . $PSItem.FullName
    Export-ModuleMember -Function $PSItem.BaseName
}

# Set Var Properties
$RlsrInfo.RootPath = $PSScriptRoot

# Load Tasks
Get-ChildItem -Path "$PSScriptRoot\tasks" | ForEach-Object {
    $RTasks = . $PSItem.FullName
    $RlsrInfo.Tasks[$RTasks.TaskName] = $RTasks
}
