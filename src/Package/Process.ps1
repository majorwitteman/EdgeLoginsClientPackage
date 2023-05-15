param (
    [Parameter(Mandatory)]
    [string]
    $FunctionUri
)

Import-Module $PSScriptRoot\EdgeLogins
Import-Module $PSScriptRoot\SimplySql

Send-EdgeLogins -FunctionUri $FunctionUri