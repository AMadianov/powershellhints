$AllUsers = @{
    'corp\mad1' = 'mad1@corp.local'
    'corp\mad2' = 'mad2@corp.local'
    'corp\mad3' = 'mad3@corp.local'
    'corp\mad4' = 'mad4@corp.local'
    'corp\mad5' = 'mad5@corp.local'
}
if ($AllUsers.Count -eq 0) {
    write "True"
} else {
    $usrL = Read-Host 'What is loginname?'
    $usrE = Read-Host 'What is E-mail?'
    if ($AllUsers[$usrL]) {
        write "this is user"
    } else {
        $AllUsers.Add($usrL, $usrE)
    }
}