function ConvertTo-OperatingSystem {
    [CmdletBinding()]
    param(
        [string] $OperatingSystem,
        [string] $OperatingSystemVersion
    )
    if ($OperatingSystem -like 'Windows 10*') {
        $Systems = @{
            '10.0 (19042)' = "Windows 10 20H2"
            '10.0 (19041)' = "Windows 10 2004"
            '10.0 (18363)' = "Windows 10 1909"
            '10.0 (18362)' = "Windows 10 1903"
            '10.0 (17763)' = "Windows 10 1809"
            '10.0 (17134)' = "Windows 10 1803"
            '10.0 (16299)' = "Windows 10 1709"
            '10.0 (15063)' = "Windows 10 1703"
            '10.0 (14393)' = "Windows 10 1607"
            '10.0 (10586)' = "Windows 10 1511"
            '10.0 (10240)' = "Windows 10 1507"
        }
        $System = $Systems[$OperatingSystemVersion]
    }
    elseif ($OperatingSystem -notlike 'Windows 10*') {
        $System = $OperatingSystem
    }
    if ($System) { $System }
    else { 'Unknown' }
}

# change only use enabled computers
# $Computers = Get-ADComputer -Filter * -properties Name, OperatingSystem, OperatingSystemVersion, LastLogonDate, whenCreated
$Computers = Get-ADComputer -Filter 'enabled -eq "true"' -properties Name, OperatingSystem, OperatingSystemVersion, LastLogonDate, whenCreated
$ComputersDisabled = Get-ADComputer -Filter 'enabled -ne "true"' -properties Name, OperatingSystem, OperatingSystemVersion, LastLogonDate, whenCreated

$ComputerList = foreach ($_ in $Computers) {
    [PSCustomObject] @{
        Name                   = $_.Name
        OperatingSystem        = $_.OperatingSystem
        OperatingSystemVersion = $_.OperatingSystemVersion
        System                 = ConvertTo-OperatingSystem -OperatingSystem $_.OperatingSystem -OperatingSystemVersion $_.OperatingSystemVersion
        LastLogonDate          = $_.LastLogonDate
        WhenCreated            = $_.WhenCreated
    }
}
$ComputerListDisabled = foreach ($_ in $ComputersDisabled) {
    [PSCustomObject] @{
        Name                   = $_.Name
        OperatingSystem        = $_.OperatingSystem
        OperatingSystemVersion = $_.OperatingSystemVersion
        System                 = ConvertTo-OperatingSystem -OperatingSystem $_.OperatingSystem -OperatingSystemVersion $_.OperatingSystemVersion
        LastLogonDate          = $_.LastLogonDate
        WhenCreated            = $_.WhenCreated
    }
}
# list computers
$ComputerListDisabled | Sort-Object LastLogonDate | Format-Table -AutoSize
$ComputerList | Sort-Object LastLogonDate | Format-Table -AutoSize

# summary of enabled & disabled computers
"Disabled computers" | Out-Host
$ComputerListDisabled | Group-Object -Property System | Sort-Object Name | Format-Table -Property Name, Count
"Enabled computers" | Out-Host
$ComputerList | Group-Object -Property System | Sort-Object Name | Format-Table -Property Name, Count
