# Show computer description and optionally update it
#Requires -RunAsAdministrator

do {
    $Computer = Read-Host "Computer name"
    $OSValues = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $Computer
    "Current description:"
    $OSValues.Description | Out-Host

    $change = Read-Host "Change computer description? (y/n)"
    if ($change -eq 'y') {
        $NewDescription = Read-Host "New description"
        $OSValues.Description = $NewDescription
        $OSValues.put()
        Get-WmiObject -Class Win32_OperatingSystem -ComputerName $Computer | Select-Object description
    } 
    $loop = Read-Host "Check another computer? (y/n)"
} while ($loop -eq 'y')