$moddir = Split-Path -Path $PSScriptRoot -Parent
$cmddir = Join-Path  -Path $moddir -ChildPath 'cmds'
. "$cmddir\__Get-RlsrProject.ps1"

Describe "Get-RlsrProject" {
    $cfgfile = "$moddir\alpha-patch.rlsrcr1.psd1"
    $script:rlsrprj = $null
    
    It "Cmd runs w\o error" {
        {
            $ErrorActionPreference = 'Stop'
            $script:rlsrprj = Get-RlsrProject
        } | Should Not Throw
    }

    It "PSCustomObject is returned" {
        $script:rlsrprj.GetType().Name | Should Be 'PSCustomObject'
    }
}
