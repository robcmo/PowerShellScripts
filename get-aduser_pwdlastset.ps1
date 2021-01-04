# List all AD users
Get-ADUser -Filter * -Properties CannotChangePassword, PasswordNeverExpires, PasswordLastSet | Sort-Object PasswordLastSet -Descending | `
    Select-Object Surname, GivenName, SamAccountName, Enabled, CannotChangePassword, PasswordNeverExpires, PasswordLastSet | `
    Where-Object { $_.Enabled -eq $true } | Where-Object { $_.CannotChangePassword -eq $false } | `
    Where-Object { $_.PasswordNeverExpires -eq $false } | Where-Object { $_.PasswordLastSet -lt (Get-Date).AddDays(-85) } |`
    Out-GridView
#Export-Csv c:\temp\ADUser-PasswordLastSet.csv


# Prompt for username
<#$user = Read-Host "username"
#get-aduser $user -properties lastlogontimestamp, pwdLastSet, PasswordLastSet | Select-Object samaccountname, lastlogontimestamp, pwdLastSet, PasswordLastSet
get-aduser $user -properties lastlogontimestamp, pwdLastSet | Select-Object samaccountname, `
@{Name = "LastLogonTimeStamp"; Expression = { ([datetime]::FromFileTime($_.LastLogonTimeStamp)) } }, `
@{Name = "pwdLastSet"; Expression = { ([datetime]::FromFileTime($_.pwdLastSet)) } } 
net user $user /domain
#>

<# All users in Dept OU
#$CSusers = Get-ADUser -filter * -SearchBase "ou=Customer_Services,ou=MPW USERS,dc=mpw,dc=dom"
$CommUsers = Get-ADUser -filter * -SearchBase "ou=Communications,ou=MPW USERS,dc=mpw,dc=dom"
$usrs = $CommUsers.samaccountname | Sort-Object

foreach ($usr in $usrs) {
    get-aduser $usr -properties lastlogontimestamp, pwdLastSet, PasswordLastSet | Select-Object samaccountname, Name, PasswordLastSet
}
#>