@{
RootModule = 'PSSelfExtractor.psm1'
ModuleVersion = '0.0.1.0'
GUID = '3217ed63-2c9a-4af8-be30-f36cd44f263f'
Author = 'qawarrior (Paul H Cassidy)'
CompanyName = 'Warrior IT Services'
Copyright = '(c) 2018 Warrior IT Services. All rights reserved.'
Description = 'The PSSelfExtractor module provides cmds to generate Self Extracting Achives'
PowerShellVersion = '5.0'
RequiredAssemblies = @('.\bin\Ionic.Zip.dll')
FileList = @(
    '.\bin\Ionic.Zip.dll'
    '.\cmds\New-SelfExtractor.ps1'
    '.\cmds\New-SelfExtractorOption.ps1'
    '.\en-US\about_PSSelfExtractor.help.txt'
    '.\LICENSE'
    '.\PSSelfExtractor.psd1'
    '.\PSSelfExtractor.psm1'
    '.\README.md'
)
PrivateData = @{
    PSData = @{
        # Tags applied to this module. These help with module discovery in online galleries.
        # Tags = @()
        # A URL to the license for this module.
        # LicenseUri = ''
        # A URL to the main website for this project.
        # ProjectUri = ''
        # A URL to an icon representing this module.
        # IconUri = ''
        # ReleaseNotes of this module
        # ReleaseNotes = ''
    }
}
}

