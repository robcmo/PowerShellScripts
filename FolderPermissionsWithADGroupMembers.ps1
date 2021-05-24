# Permissions of shared folders with AD group members
#  by Rob Morrison

$FolderPath = Read-Host "Enter network path (\\server\share\folder)"
$OutFile = Read-Host "Where to save report? (example C:\temp\permissions.txt)"

# show permissions for folders
Out-File -FilePath $OutFile -InputObject "Report of $FolderPath showing folder security and Active Directory group membership"
# provided folder
$FolderPath | Get-Acl | Format-List -Property PSPath, AccessToString | Out-File $OutFile -Append
$FolderPath | Get-Acl | Select-Object -ExpandProperty access | Select-Object IdentityReference | Where-Object IdentityReference -Like 'NETMPW\*' | `
    ForEach-Object {
    $object = $_.IdentityReference
    $sam = $object.Value.Substring($object.Value.IndexOf('\') + 1)
    Get-ADObject -Filter "Name -eq '$sam' -and ObjectClass -eq 'group'" | ForEach-Object {
        Out-File $OutFile -Append -InputObject $_.Name
        Get-ADGroupMember $_ | Select-Object SamAccountName | Format-Table -HideTableHeaders | Out-File $OutFile -Append
    }
}
# subfolders
Get-ChildItem $FolderPath -Directory -Recurse  | ForEach-Object {
    $_ | Get-Acl | Format-List -Property PSPath, AccessToString | Out-File $OutFile -Append

    $_ | Get-Acl | Select-Object -ExpandProperty access | Select-Object IdentityReference | Where-Object IdentityReference -Like 'NETMPW\*' | `
        ForEach-Object {
        $object = $_.IdentityReference
        $sam = $object.Value.Substring($object.Value.IndexOf('\') + 1)
        Get-ADObject -Filter "Name -eq '$sam' -and ObjectClass -eq 'group'" | ForEach-Object {
            Out-File $OutFile -Append -InputObject $_.Name
            Get-ADGroupMember $_ | Select-Object SamAccountName | Format-Table -HideTableHeaders | Out-File $OutFile -Append
        }
    }
}