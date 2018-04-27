$moddir = Split-Path -Path $PSScriptRoot -Parent
$cmddir = Join-Path  -Path $moddir -ChildPath 'cmds'
. "$cmddir\Get-RlsrConfig.ps1"

Describe "Get-RlsrConfig" {
    $prjfile = 'alpha-patch'
    $script:rlsrcfg = $null

    It "Cmd runs w\o error" {
        {
            $script:rlsrcfg = Get-RlsrConfig -Path $moddir -Name $prjfile -ErrorAction 'Stop'
        } | Should Not Throw
    }

    It "Hashtable is returned" {
        $script:rlsrcfg.GetType().Name | Should Be 'Hashtable'
    }

    It "ModuleName is a string" {
        $script:rlsrcfg.ModuleName.GetType().Name | Should Be 'String'
    }

    It "FullPath is a string" {
        $script:rlsrcfg.FullPath.GetType().Name | Should Be 'String'
    }

    It "TaskSequence is an object array" {
        $script:rlsrcfg.TaskSequence.GetType().Name | Should Be 'Object[]'
    }
}
