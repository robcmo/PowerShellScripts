# Display locked out users and prompt which account to unlock.
# Search-ADAccount -LockedOut | Select-Object samaccountname, distinguishedname, lastlogondate | Sort-Object samaccountname

$DCs | ForEach-Object { $_; Search-ADAccount -LockedOut | Select-Object SamAccountName, Name, Enabled, LastLogonDate, PasswordExpired, LockedOut | Sort-Object LastLogonDate | Format-Table | Out-Host }

$user = Read-Host "Type username to unlock (q to quit)"
if ($user -ne 'q' ) {
    $DCs | ForEach-Object { $_; Unlock-ADAccount -Identity $user -Verbose } 
}
