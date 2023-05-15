function Get-EdgeLoginPaths {
    [cmdletbinding()]
    param ()
    $users = Get-ChildItem -Path "C:\Users" -Directory
    foreach ($user in $users) {
        $edgeBasePath = "$($user.FullName)\AppData\Local\Microsoft\Edge\User Data"
        if (Test-Path -Path $edgeBasePath -ErrorAction SilentlyContinue) {
            $loginDataPaths = Get-ChildItem -Path $edgeBasePath -Filter "Login Data" -Recurse -File | Where-Object -Property FullName -NotMatch "Snapshots"
            foreach ($dataPath in $loginDataPaths) {
                [pscustomobject]@{
                    UserName = $user.Name
                    EdgeLoginDataPath = $dataPath
                    ProfileName = (Split-Path (Split-Path -Path $dataPath -Parent) -Leaf)
                }
            }
        }
    }
}