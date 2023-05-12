<#
    .SYNOPSIS
    Edits computer descriptions in bulk.

    .DESCRIPTION
    This script updates computer descriptions in Active Directory using a CSV file as input.

    .AUTHOR
    Kevin Adams

    .DATE
    4/3/2023

    .EXAMPLE
    ".\BulkGetDescription.ps1"
#>

# Import the Active Directory module for PowerShell.
Import-Module ActiveDirectory

# Set the path of the CSV file.
$csvPath = "C:\src\List.csv"

# Test the path to make sure the path/file exists.
if (-not (Test-Path $csvPath)) {
    Write-Error "CSV file not found at '$csvPath'"
    exit 1
}

# Check that the CSV file isn't completely empty or doesn't exist.
$computers = Import-Csv $csvPath
if ($computers -eq $null) {
    Write-Error "Failed to import CSV file at '$csvPath'"
    exit 1
}

# For each record/row, get the computer description
foreach ($comp in $computers) {

    # Skip any records that have the computer name empty.
    if (-not $comp.ComputerName) {
        Write-Warning "Skipping record without ComputerName"
        continue
    }

    # Get the computer description.
    Get-ADComputer ($comp.ComputerName) -Property "ObjectGUID" | Select-Object -Property "Name","ObjectGUID"

}