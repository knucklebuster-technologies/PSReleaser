$moddir = Split-Path -Path $PSScriptRoot -Parent
$cmddir = Join-Path  -Path $moddir -ChildPath 'cmds'
. "$cmddir\Test-RlsrProject.ps1"

Describe "Test-RlsrProject" {
    It "Retuns false if not in project root" {
        pushd ..
        Test-RlsrProject -Path . -Name 'alpha-patch' | Should Be $false
        popd
    }
}
