$moddir = Split-Path -Path $PSScriptRoot -Parent
$cmddir = Join-Path  -Path $moddir -ChildPath 'cmds'
. "$cmddir\Get-RlsrLock.ps1"

Describe "Get-RlsrLock" {
    $cfgfile = "$moddir\alpha-patch.rlsr.cfg"
    $script:rlsrlck = $null

    It "Cmd runs w\o error" {
        {
            $script:rlsrlck = Get-RlsrLock -CfgPath $cfgfile -ErrorAction 'Stop'
        } | Should Not Throw
    }

    It "PSCustomObject is returned" {
        $script:rlsrlck.GetType().Name | Should Be 'PSCustomObject'
    }
}
