$functionKey = "<functionKey>" #secret in DevOps

$DestinationPath = [System.IO.Path]::Combine($env:SystemRoot,"Temp","EdgeLoginsPackage")
try {
    Copy-Item -Path $PSScriptRoot\Package -Destination $DestinationPath -Recurse -ErrorAction Stop -Force
    Write-Output "Copied package to $DestinationPath"
    Push-Location -Path $DestinationPath
    .\Process.ps1 -FunctionUri "https://rwedgelogins.azurewebsites.net/api/receive?code=$functionKey"
    Pop-Location
}
catch {
    $_
}