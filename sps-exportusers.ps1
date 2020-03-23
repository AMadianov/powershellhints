#Add-PSSnapin microsoft.sharepoint.powershell
cls
$sites = Get-Content -Path '.\sites.txt' -Encoding UTF8
foreach ($site in $sites) {
    $site = Get-SPSite $site
    $webs = Get-SPSite $site | Get-SPWeb -Limit ALL
    $SiteGroups = @('GroupName, DisplayName, ADLogin, Email')
    $AllUsers = @{}
    foreach ($web in $webs) {
        $admins = $web.SiteAdministrators
        foreach ($group in $web.SiteGroups) {
            if ("" -ne $group.Roles) {
                $Name = $group.Name
                $Users = $group.Users
                foreach ($user in $Users) {
                    $usrN = $user.Name
                    $usrL = $user.LoginName.TrimStart("i:0#.w|")
                    $usrE = $user.Email
                    $AllUsers.add($usrL, $usrE)
                    if ($AllUsers.Count -eq 0) {
                        $AllUsers.Add($usrL, $usrE)
                    } else {
                            if ($AllUsers[$usrL]) {
                                write "this login is already there"
                            } else {
                                $AllUsers.Add($usrL, $usrE)
                            }
                    }
                    $SiteGroups += "$Name, $usrN, $usrL, $usrE"
                }
            }
        }
        if ("" -eq $web.Name) {
            $webname = $web.Title
        } else {
            $webname = $web.Name
        }
        $SiteGroups | ft
        $SiteGroups | Out-File -FilePath ".\$webname.csv" -Encoding utf8
    }
}