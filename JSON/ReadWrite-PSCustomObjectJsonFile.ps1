#
# Read/Write a PSCustomObject from/to JSON file
#

#example object
$obj = New-Object PSCustomObject
$obj | Add-Member -type NoteProperty -name Name1 -Value 'John'
$obj | Add-Member -type NoteProperty -name Name2 -Value 'Doe2'

#write object to file
$filePath = $PSScriptRoot + "\ReadWrite-PSCustomObjectJsonFile_output.json"
$obj | ConvertTo-Json | Set-Content -Path $filePath

#read object from file
$obj2 = Get-Content -Path $filePath | ConvertFrom-Json

#use object
Write-Host "Name1 = " $obj2.Name1
Write-Host "Name2 = " $obj2.Name2
