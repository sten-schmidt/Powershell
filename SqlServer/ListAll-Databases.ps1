#
# List all Databases using SMO
#

Import-Module SQLPS

$instanceName = "LOCALHOST"
$server = New-Object Microsoft.SqlServer.Management.Smo.Server($instanceName)
[Microsoft.SqlServer.Management.Smo.DatabaseCollection]$dbList = $server.Databases

"Databases found: " + $dbList.Count

foreach ($db in $dbList) {
    Write-Host $db.Name 
}

