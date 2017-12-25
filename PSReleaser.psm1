
# Root of this module
$ReleaserRoot = $PSScriptRoot


# Bring in the sources
#Library
. "$ReleaserRoot\Library\GitAction.ps1"
. "$ReleaserRoot\Library\ReleaserConfig.ps1"

# Cmd
. "$ReleaserRoot\Cmds\New-Releaser.ps1"
. "$ReleaserRoot\Cmds\Invoke-Releaser.ps1"

# Export public module members
Export-ModuleMember -Function 'New-Releaser', 'Invoke-Releaser'