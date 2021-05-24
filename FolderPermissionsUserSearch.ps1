# Search for user permission to network share and subfolders.
#  by Rob Morrison

$FolderPath = Read-Host "Enter network path (example \\server\share\folder)"
$OutFile = Read-Host "Save path and filename (example C:\temp\permissions.txt)"
$User = Read-Host "Username to search for (first.last or flast)"

Out-File -FilePath $OutFile -InputObject "Folder report of $FolderPath that $User has access:`n"

# provided folder user directly added
if ($FolderPath | Get-Acl | Where-Object AccessToString -Like "*$User*" ) {
    $FolderPath | Out-File $OutFile -Append 
}
# provided folder user in group
$FolderPath | Get-Acl | Select-Object -ExpandProperty access | Select-Object IdentityReference | Where-Object IdentityReference -Like 'NETMPW\*' | `
    ForEach-Object {
    $object = $_.IdentityReference
    $sam = $object.Value.Substring($object.Value.IndexOf('\') + 1)
    Get-ADObject -Filter "Name -eq '$sam' -and ObjectClass -eq 'group'" | ForEach-Object {
        if (Get-ADGroupMember $_ | Where-Object SamAccountName -Like "*$User*" ) { 
            $FolderPath | Out-File $OutFile -Append 
        }
    }
}

# subfolders
Get-ChildItem $FolderPath -Directory -Recurse  | ForEach-Object {
    $subfolder = $_
    # subfolder folder user directly added
    if ($subfolder | Get-Acl | Where-Object AccessToString -Like "*$User*" ) {
        $subfolder | Out-File $OutFile -Append 
    }
    # provided folder user in group
    $subfolder | Get-Acl | Select-Object -ExpandProperty access | Select-Object IdentityReference | Where-Object IdentityReference -Like 'NETMPW\*' | `
        ForEach-Object {
        $object = $_.IdentityReference
        $sam = $object.Value.Substring($object.Value.IndexOf('\') + 1)
        Get-ADObject -Filter "Name -eq '$sam' -and ObjectClass -eq 'group'" | ForEach-Object {
            if (Get-ADGroupMember $_ | Where-Object SamAccountName -Like "*$User*" ) { 
                $subfolder.FullName | Out-File $OutFile -Append 
            }
        }
    }
}