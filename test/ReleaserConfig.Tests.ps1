$parent = Split-Path -Path $PSScriptRoot -Parent
$out = "$parent\models\RlsrConfig.psd1"
$cfg = Import-PowerShellDataFile -Path $out
Describe "RlsrConfig" {
    It "does something useful" {
        $true | Should Be $false
    }
}
