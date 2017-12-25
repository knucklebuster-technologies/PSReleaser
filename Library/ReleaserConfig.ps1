

class ReleaserConfig {
    [string]$Name = 'ModuleName'
    [string]$Destination = '.\released'
    [string]$ReleaseType = 'Revision'
    [string[]]$Tasks = 'UpdateVersion', 'ArchiveModule'
}
