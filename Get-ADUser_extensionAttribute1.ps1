# Get all users with Manager and extensionAttribute1.
# Lists users that Manager's username does not match extensionAttribute1
# Optionally changes one field to match other or clears both.
# by Rob Morrison

# Clear-Variable User, Manager
$User = $null
$Manager = $null

$Change = Read-Host "Compare user's manager to extensionAttribute1 field:`n1. Get list of users`n2. Make changes`n (1 or 2)"
$UserArray = Get-ADUser -Filter * -Properties manager, extensionAttribute1 | Select-Object SamAccountName, Name, Enabled, Manager, extensionAttribute1

$HeadString = "Name, Username, Enabled, Manager, extensionAttribute1"
#$HeadString | Out-Host
$HeadString | Out-File -FilePath .\users.csv

# Parse user list
foreach ($User in $UserArray) {
    # List
    if ($null -ne $User.manager) {
        $Manager = Get-ADUser $User.manager 
        if ($User.extensionAttribute1 -ne $Manager.SamAccountName) {
            #"$($User.Name), $($User.SamAccountName), $($User.Enabled), $($Manager.SamAccountName), $($User.extensionAttribute1)" | Out-Host
            "$($User.Name), $($User.SamAccountName), $($User.Enabled), $($Manager.SamAccountName), $($User.extensionAttribute1)" | Out-File -FilePath .\users.csv -Append    
        }
    }
    else {
        $Manager = $null
        if ($null -ne $User.extensionAttribute1) {
            #"$($User.Name), $($User.SamAccountName), $($User.Enabled), $($Manager.SamAccountName), $($User.extensionAttribute1)" | Out-Host
            "$($User.Name), $($User.SamAccountName), $($User.Enabled), $($Manager.SamAccountName), $($User.extensionAttribute1)" | Out-File -FilePath .\users.csv -Append      
        }
    }
    
    # Update
    if ($Change -eq '2' -and ($User.extensionAttribute1 -ne $Manager.SamAccountName)) {
        $User
        $Enabled = if ($User.Enabled -eq $true) { "enabled" } else { "disabled" }
        $UpdateUser = Read-Host "For $Enabled user $($User.Name),`n1. set extensionAttribute1 to $($Manager.SamAccountName)`n2. set manager to $($User.extensionAttribute1)`n3. Skip`n0. clear both fields`n"    
        if ($UpdateUser -eq '1') {
            Set-ADUser -Identity $User.SamAccountName -Replace @{ extensionAttribute1 = $Manager.SamAccountName }
        }
        elseif ($UpdateUser -eq '2') {
            Set-ADUser -Identity $User.SamAccountName -Manager $User.extensionAttribute1
        }
        elseif ($UpdateUser -eq '0') {
            Set-ADUser -Identity $User.SamAccountName -Manager $null
            Set-ADUser -Identity $User.SamAccountName -Replace @{ extensionAttribute1 = $null }
        }
    }
}
if ($Change -eq '1') { Start-Process .\users.csv }
