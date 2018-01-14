
[ordered]@{
     # Name of the Module being released
    ModuleName     = 'ModuleName'
    
    # Module directory path. The directory
    # should have at least one psd1 file 
    # and it's basename matches the value
    # stored in the ModuleName Key 
    SourcePath     = '.\source'
    
    # Top level directory path used to organize 
    # and isolate each project, version, phase set
    # Example Directory: '.\release\PSReleaser\v0.0.1-alpha"
    # Example Artifact: PSReleaser.v0.0.1-alpha (UNCOMPRESSED MODULE)"
    # Example Artifact: PSReleaser.v0.0.1-alpha.zip (COMPRESSED MODULE)
    # Example Artifact: PSReleaser.v0.0.1-alpha.Tasks.log (TASK EVENTs LOG)
    # Example Artifact: PSReleaser.v0.0.1-alpha.Tests.xml (TEST RESULTS NUNIT XML)       
    ReleasePath    = '.\release'
    
    # Top level directory used to organize and isolate test scripts that run
    # against each and every project, version, phase set
    TestPath       = '.\source\test'

    # This value controls how the Module's version is increamented
    # The valid values for this setting and what action it performs:
    # MAJOR - (major) the first int on the left is increased by one 
    ### and (revision) the last int on the right is set to zero
    # MINOR - (minor) the second int on the left is increased by one
    ### and (revision) the last int on the right is set zero
    # PATCH, BUILD - (patch) the third int on the left is increased by one
    ### and (revision) the last int on the right is increased by one
    # REVISION, [STRING]::EMPTY, 'ANY STRING - (revision) the last int on the right is 
    ### increased by one only. This is the default action.
    ReleaseType    = ''
    
    # This is a string added to the Semver. Example 0.0.0-alpha.
    # Value can be any short Id or can empty
    ReleasePhase = 'alpha'
    
    # Collection of tasks that are invoked in the order listed.
    # Each task is used as steps in the Rlsr process.
    TaskSequence   = @(
        'UpdateVersion'
    )
}
