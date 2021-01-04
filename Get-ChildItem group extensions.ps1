# Count number of files and total size by file type.

Get-Childitem -Recurse | Group-Object -property extension |
Select-Object Name, Count, @{Name = "Size"; Expression = { ($_.group | Measure-Object -Property length -sum).sum } }
