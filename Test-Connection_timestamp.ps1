# ping with timestamp
$hostname = Read-Host "hostname"
Test-Connection -Repeat -TargetName $hostname | Select-Object @{n = 'TimeStamp'; e = { Get-Date } }, Source, Destination, Address, Latency, Status | Format-Table