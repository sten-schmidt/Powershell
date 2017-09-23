#
# Call StoredProcedure with ExecuteReader
#

[string]$connectionString = "Server=LOCALHOST;Database=DevTest;Integrated Security=True"

$con = New-Object System.Data.SqlClient.SqlConnection -ArgumentList @($connectionString)
$con.Open()

#Table-Result
$cmd = $con.CreateCommand()
$cmd.CommandType=[System.Data.CommandType]::StoredProcedure
$cmd.CommandText = "spGetTestData01"

$reader = $cmd.ExecuteReader()
while ($reader.Read() -eq $true)
{
    Write-Host $reader['ID'] -> $reader['Name']
}

$reader.Close()
$con.Close()
 
 
