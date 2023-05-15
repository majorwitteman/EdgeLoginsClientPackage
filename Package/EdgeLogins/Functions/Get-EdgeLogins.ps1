function Get-EdgeLogins {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$LoginDataFile
    )
    $tempFilePath = New-TemporaryFile
    if (-not (Test-Path -Path $LoginDataFile)) { Write-Output "File $LoginDataFile does not exist"; return }
    Copy-Item -Path $LoginDataFile -Destination $tempFilePath

    Open-SQLiteConnection -DataSource $tempFilePath

    Invoke-SqlQuery -Query "SELECT * FROM logins" | Select-Object -Property origin_url,username_value,blacklisted_by_user

    Close-SqlConnection

    Remove-Item -Path $tempFilePath
}