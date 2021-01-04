# When using the -Include parameter, if you don't include an asterisk in the path the command returns no output.
# The Name parameter returns only the file or directory names from the specified path.
#Get-ChildItem -Path C:\Test\* -Include *.txt -Name


# Find all files of location - run script as admin to search every folder.

#$Path = Read-Host -Prompt 'Drive or folder'
#$Filter = Read-Host -Prompt 'Search'
#Get-ChildItem -Path $Path -Filter $Filter -Recurse -Force -ErrorAction SilentlyContinue

# The following command will find and list all files that are larger than 500MB in the entire C:\ drive.
#Get-ChildItem C:\ -recurse | where-object { $_.length -gt 524288000 } | Sort-Object length | Format-Table fullname, length -auto

Get-ChildItem C:\ -Recurse -Force -ErrorAction SilentlyContinue | Where-Object { $_.Length -gt 524288000 } | Sort-Object Length | Format-Table FullName, Length -AutoSize
