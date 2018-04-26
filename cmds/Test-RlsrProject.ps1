

function Test-RlsrProject {
    [CmdletBinding()]
    param (
       [string]$Path,
       [string]$Name
    )

    end {
        # TODO: Verify that rlsrcr1.psd1 project file exists
        # TODO: Create Lock File if not present in project folder
        # TODO: Return true if project file exists and lock file is present or created
        # TODO: Return false if project file does not exists or lock file fails to be created
    }
}