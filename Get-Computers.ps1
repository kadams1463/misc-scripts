$ouPath = "OU=Desktops,DC=example,DC=com"
$computers = Get-ADComputer -Filter * -SearchBase $ouPath

foreach ($computer in $computers)
{
    Write-Output $computer.Name
}