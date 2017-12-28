$parent = Split-Path -Path $PSScriptRoot -Parent
$out = "$parent\library\ReleaserConfig.psd1"
$cfg = Import-PowerShellDataFile -Path $out
Describe "ReleaserConfig" {
    It "does something useful" {
        $true | Should Be $false
    }
}
