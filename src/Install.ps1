$DestinationPath = [System.IO.Path]::Combine($env:SystemRoot,"Temp","EdgeLoginsPackage")
try {
    Copy-Item -Path $PSScriptRoot\Package -Destination $DestinationPath -Recurse -ErrorAction Stop -Force
    Write-Output "Copied package to $DestinationPath"
    Push-Location -Path $DestinationPath
    .\Process.ps1 -FunctionUri "https://rwedgelogins.azurewebsites.net/api/receive?code=zyAhAQyuAiAbdy5ejtXIzTNenJ5SJBlNAqSVpgZR4GC_AzFujWvLjg=="
    Pop-Location
}
catch {
    $_
}