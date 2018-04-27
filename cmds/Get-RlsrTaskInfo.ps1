
<#
.SYNOPSIS
    Display information about PSReleaser tasks
.DESCRIPTION
    Enumerates all PSReleaser tasks and displays a list of
    task proerties. The properties displayed are the Name
    of the task, Description of the task, and Inputs used
    by the task.
.EXAMPLE
    PS C:\> Get-RlsrTaskInfo
    Displays a list of task names, descriptions, and inputs
#>
function Get-RlsrTaskInfo {
    [CmdletBinding()]
    param ()

    end {
        $RlsrEngine.Tasks.GetEnumerator() | ForEach-Object {
            $PSItem.Value |
            Select-Object -Property Name, Description, @{name='Inputs';expression= {[string]::Join(', ', $_.Inputs)}} |
            Format-List
        }
    }
}