$moddir = Split-Path -Path $PSScriptRoot -Parent
$cmddir = Join-Path  -Path $moddir -ChildPath 'cmds'
. "$cmddir\<FilePath>.ps1"

Describe "<CmdName>" {
    It "Does Something" {
        $false | Should Be $true
    }
}
