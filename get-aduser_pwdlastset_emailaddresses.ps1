# List all AD users' email addresses that haven't changed password for 85 days or more.
Get-ADUser -Filter * -Properties CannotChangePassword, PasswordNeverExpires, PasswordLastSet | Sort-Object PasswordLastSet -Descending | `
    Where-Object { $_.Enabled -eq $true } | Where-Object { $_.CannotChangePassword -eq $false } | `
    Where-Object { $_.PasswordNeverExpires -eq $false } | Where-Object { $_.PasswordLastSet -lt (Get-Date).AddDays(-85) } |`
    Select-Object UserPrincipalName