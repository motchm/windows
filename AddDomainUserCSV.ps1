Import-Module ActiveDirectory

$securepassword = ConvertTo-SecureString "CHANGEME" -AsPlainText -Force

$filepath = Read-Host -Prompt "Please enter the path to your CSV file"

$users = Import-Csv $filepath

ForEach ($user in $users) {

    $fname = $user.'First Name'
    $lname = $user.'Last Name'
    $jtitle = $user.'Job Title'
    $ophone = $user.'Office Phone'
    $email = $user.'Email Address'
    $desc = $user.Description
    $OUpath = $user.'Organizational Unit'

    New-ADUser -Name "$fname §lname" -GivenName $fname -Surname $lname -UserPrincipalName "$fname.$lname" -Path $OUpath -AccountPassword $securepassword -ChangePasswordAtLogon $true -OfficePhone $ophone -Description $desc -Enabled $true -EmailAddress $email

    echo "Accout has been created for $fname $lname in $OUpath"
}