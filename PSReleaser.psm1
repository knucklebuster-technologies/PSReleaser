
# Root of this module
$ReleaserRoot = $PSScriptRoot


# Bring in the sources
# Cmd
. "$ReleaserRoot\Cmds\New-Releaser.ps1"
. "$ReleaserRoot\Cmds\Invoke-Releaser.ps1"

# Export public module members
Export-ModuleMember -Function 'New-Releaser', 'Invoke-Releaser'