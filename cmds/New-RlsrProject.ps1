function New-RlsrProject {
    [CmdletBinding()]
    param (
        $Path,
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
            $cfgexample = "$($RlsrInfo.RootPath)\examples\example.rlsr.cfg"
            Copy-Item -Path $cfgexample -Destination $cfgpath

            $lckpath = "$Path\$Name.rlsr.lock"
            $lckexample = "$($RlsrInfo.RootPath)\examples\example.rlsr.lock"
            Copy-Item -Path $lckexample -Destination $lckpath
        }
        catch {
            Write-Error - @{
                'Message'  = "The project .cfg and .lock files were not created: $_"
                'Catagory' = 'ObjectNotFound'
                'ErrorID'  = 'New-RlsrFiles'
            }
        }
    }
}