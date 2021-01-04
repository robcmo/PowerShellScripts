# List installed Programs
# x64
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Sort-Object DisplayName | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, InstallSource | Out-GridView
# x86
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Sort-Object DisplayName | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, InstallSource | Out-GridView

# List optional Features
Get-WindowsOptionalFeature -Online | Sort-Object State, FeatureName | Out-GridView

# Enable-WindowsOptionalFeature -Online -FeatureName "Hearts" -All