<#
    ExampleTask is the minimum you need to create a new task inside of
    PSReleasers CI / CR system.
#>
New-Module -Name $([IO.FileInfo]"$PSCommandPath").BaseName -ScriptBlock {
    
    # TaskName will be ExampleTask
    $TaskName = $([IO.FileInfo]"$PSCommandPath").BaseName
    
    # This task is public
    $Public = $true
    
    # A detailed paragragh on what and how this task is to be used.
    $Description = "The minimum you need to create a new task inside of
    PSReleasers CI / CR system. It Will print 'Hello World From ExampleTask' to the console
    using Write-Host (puppie killerz)"

    # InvokeTask runs the tasks operations and any returned values will be found
    # as properties on the Config object.
    function InvokeTask {
        Write-Host 'Hello World From ExampleTask' -BackgroundColor White -ForegroundColor Black
    }

    Export-ModuleMember -Variable 'TaskName', 'Internal', 'Description' -Function 'InvokeTask'
} -AsCustomObject
