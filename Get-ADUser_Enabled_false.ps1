# get list of disabled AD users

# Show in table
# Get-ADUser -Filter * -Properties Enabled | Where-Object { $_.Enabled -ne 'True' } | Sort-Object samaccountname | Format-Table samaccountname, UserPrincipalName, Name, Enabled -AutoSize

# Export to CSV
Get-ADUser -Filter * -Properties Enabled | Where-Object { $_.Enabled -ne 'True' } | Sort-Object samaccountname | Select-Object samaccountname, UserPrincipalName, Name, Enabled | Export-Csv UsersDisabled.csv
Start-Process UsersDisabled.csv