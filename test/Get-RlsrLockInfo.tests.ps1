$moddir = Split-Path -Path $PSScriptRoot -Parent
$cmddir = Join-Path  -Path $moddir -ChildPath 'cmds'
. "$cmddir\__Get-RlsrLockInfo.ps1"

Describe "Get-RlsrLockInfo" {
    $cfgfile = "$moddir\alpha-patch.rlsrcr1.psd1"
    $script:rlsrlck = $null
    
    It "Cmd runs w\o error" {
        {
            $script:rlsrlck = Get-RlsrLockInfo -Path $moddir -CfgPath $cfgfile -ErrorAction 'Stop'
        } | Should Not Throw
    }

    It "PSCustomObject is returned" {
        $script:rlsrlck.GetType().Name | Should Be 'PSCustomObject'
    }
}
