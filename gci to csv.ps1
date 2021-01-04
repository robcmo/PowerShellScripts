# Run this PowerShell command to export the directory list to a CSV file for Excel.
# Get-ChildItem | Export-Csv dir.csv
# by Rob Morrison

# 1. Go to location in Windows File Explorer
# 2. Hold Shift, right-click and select "Open PowerShell window here"
# 3. Copy and paste following line.

Get-ChildItem -Recurse | Select-Object Directory, Name, Length, LastWriteTime | Export-Csv((Get-Location | Split-Path -Leaf) + ".csv")
