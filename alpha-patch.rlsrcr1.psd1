
@{
    ModuleName    = 'PSReleaser'
    SourcePath    = '.'
    TestPath      = '.\tests'
    ReleasePath   = '..\releases'
    # Valid Values Major, Minor, Patch, None
    BuildType     = 'None'
    PreReleaseTag = 'alpha.1'
    TaskSequence  = @(
        'InvokePester'
        'UpdateVersion'
        'GitAddAll'
        'ArchiveModule'
    )
}
