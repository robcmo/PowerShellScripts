# List AD users by department.
Get-ADUser -Filter * -Properties department | Where-Object department -ne $null | Select-Object samaccountname, department | Sort-Object department