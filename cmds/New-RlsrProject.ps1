function New-RlsrProject {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage="The path to the directory to create the new project items")]
        [string]
        $Path,

        [Parameter(HelpMessage="The base name for the new projects items")]
        [string]
        $Name
    )

    end {
        try {
            $ErrorActionPreference = 'Stop'
            $Path = (Resolve-Path -Path $Path).Path
            if ([System.IO.Directory]::Exists($Path) -eq $false) {
                throw "The parameter Path is not a directory"
            }

            $cfgpath = "$Path\$Name.rlsr.cfg"
            $cfgexample = "$($RlsrInfo.EnginePath)\examples\example.rlsr.cfg"
            Copy-Item -Path $cfgexample -Destination $cfgpath

            $lckpath = "$Path\$Name.rlsr.lock"
            $lckexample = "$($RlsrInfo.EnginePath)\examples\example.rlsr.lock"
            Copy-Item -Path $lckexample -Destination $lckpath
        }
        catch {
            $RlsrInfo.EngineErrors += ConvertFrom-ErrorRecord -Record $_
            throw $_
        }
    }
}