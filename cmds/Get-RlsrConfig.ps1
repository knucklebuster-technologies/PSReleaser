

function Get-RlsrConfig {
    [CmdletBinding()]
    param (
        [Parameter(HelpMessage = 'The path to directory that contains the projects rlsr.cfg file(s)')]
        [string]
        $Path = "$Pwd",

        [Parameter(HelpMessage = 'The base name of the projects rlsr.cfg file')]
        [string]
        $Name = "*"
    )

    end {
        try {
            Write-Verbose -Message "Path: $Path Name: $Name"
            $Path = Resolve-Path -Path $Path
            $FullPath = "$Path\$Name.rlsr.cfg"
            Write-Verbose -Message "FullPath: $FullPath"
            $cfgpath = Get-ChildItem -Path $FullPath  | Select-Object -First 1
            $cfgobject = Get-Content -Path $cfgpath | ConvertFrom-Json
            $cfgobject | Add-Member -MemberType NoteProperty -Name 'fullPath' -Value $cfgpath -Force
            $cfgobject
            Write-Verbose -Message "The project cfg $cfgpath was imported"
        }
        catch {
            $RlsrInfo.EngineErrors += ConvertFrom-ErrorRecord -Record $_
            throw $_
        }
    }
}