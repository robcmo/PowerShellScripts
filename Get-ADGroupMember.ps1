# List all groups or users in an organizational unit
# https://gallery.technet.microsoft.com/scriptcenter/List-all-groups-or-users-784f2f4e 

#This script will list all groups in an organizational unit
#Please remove # mark from the below 2 lines to get the information about the Groups in an OU

#Get-ADGroup -filter * -SearchBase "ou=Ou you want to search,dc=you domain,dc=com"
#Get-ADGroup -filter * -SearchBase "ou=sub ou,ou=root ou,dc=domain,dc=dom" | Select-Object samaccountname, name
#Get-ADGroup -filter * -SearchBase "ou=Title Groups,ou=MPW SECURITY ACCESS,dc=mpw,dc=dom" | Select-Object samaccountname, name

#This script will list all Users in an organizational unit
#Please remove # mark from the below 2 lines to get the information about the users in an OU

#Get-ADUser -filter * -SearchBase "ou=Ou you want to search,dc=you domain,dc=com"

#This script will list members of group
$ADGroup = Read-Host -Prompt "AD Group Name"
$Recursive = Read-Host -Prompt "Expand sub groups? [y/N]"

if ($Recursive -like 'y') {
    Get-ADGroupMember $ADGroup -Recursive | Select-Object name | Sort-Object name
}
else {
    Get-ADGroupMember $ADGroup | Select-Object name | Sort-Object name
}