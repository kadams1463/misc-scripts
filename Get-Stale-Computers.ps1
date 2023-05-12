# Prompt user for computer name filter
$filter = Read-Host "Enter computer name filter (e.g. 123)"

# Prompt user for OU path
$ouPath = Read-Host "Enter OU path (e.g. OU=Computers,DC=example,DC=com)"

# Retrieve computer objects matching filter and OU
$computers = Get-ADComputer -Filter "Name -like '*$filter*'" -SearchBase $ouPath -Properties LastLogonDate

# Create results array
$results = @()
foreach ($computer in $computers) {
    $result = [PSCustomObject]@{
        Name = $computer.Name
        LastLogonDate = $computer.LastLogonDate
    }
    $results += $result
}

# Generate output file path based on variables
$fileName = "computer-lastlogon-$filter-$(Get-Date -Format 'yyyyMMdd-HHmmss').csv"
$outputPath = "C:\src\$fileName"

# Export results to CSV
$results | Export-Csv -Path $outputPath -NoTypeInformation

# Prompt user to run script again
$runAgain = Read-Host "Script completed. Enter 'Y' to run again, or any other key to exit."
if ($runAgain -eq "Y") {
    &"powershell.exe" -File $MyInvocation.MyCommand.Path
}