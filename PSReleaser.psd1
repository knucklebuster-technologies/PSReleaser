@{
    RootModule = '.\PSReleaser.psm1'
    ModuleVersion = '0.0.1.0'
    GUID = '4216c493-b82f-4b10-a0ec-c9be94dbc979'
    Author = 'Paul H Cassidy (qawarrior)'
    CompanyName = 'Unknown'
    Copyright = '(c) 2017 Paul H Cassidy (qawarrior). All rights reserved.'
    PowerShellVersion = '3'
    FileList = @()
    PrivateData = @{
        PSData = @{
            Tags = @()
            LicenseUri = 'https://github.com/qawarrior/PSReleaser/blob/master/LICENSE'
            ProjectUri = 'https://github.com/qawarrior/PSReleaser'
            IconUri = 'https://pluralsight.imgix.net/paths/path-icons/powershell-a289bc74b2.png'
            ReleaseNotes = ''
        }
    }
    HelpInfoURI = 'https://psreleaser.github.io/help'
    DefaultCommandPrefix = 'RLSR'
    Description = @'
        Constant Release Tool to package and distribute powershell modules. 
        Includes tasks for git, github, pester, zip archives, etc
'@
}

