Write-Host "https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed#version_table"

$netver = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\' | Get-ItemPropertyValue -Name Release
Write-Host $netver

if ($netver -eq 528040 -or $netver -eq 528049) { Write-Host ".NET Framework 4.8" }
if ($netver -eq 461808 -or $netver -eq 461814) { Write-Host ".NET Framework 4.7.2" }
if ($netver -eq 461308 -or $netver -eq 461310) { Write-Host ".NET Framework 4.7.1" }
if ($netver -eq 460798 -or $netver -eq 460805) { Write-Host ".NET Framework 4.7" }
