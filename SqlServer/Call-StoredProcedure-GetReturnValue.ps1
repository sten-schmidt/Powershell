#
# Call StoredProcedure with Parameter and get Return-Value
#

[string]$connectionString = "Server=LOCALHOST;Database=DevTest;Integrated Security=True"

$con = New-Object System.Data.SqlClient.SqlConnection -ArgumentList @($connectionString)
$con.Open()

$cmd = $con.CreateCommand()
$cmd.CommandType=[System.Data.CommandType]::StoredProcedure
$cmd.CommandText = "spGetReturnParameter"
$cmd.Parameters.Add("@ID", [System.Data.SqlDbType]::Int).Value = [INT]42

$cmd.Parameters.Add("@ReturnValue", [System.Data.SqlDbType]::Int) | Out-Null
$cmd.Parameters["@ReturnValue"].Direction = [System.Data.ParameterDirection]::ReturnValue

$cmd.ExecuteNonQuery()  | Out-Null

[INT]$result = [INT]$cmd.Parameters["@ReturnValue"].Value
                
Write-Host "ReturnValue from SP: $result"

$con.Close()
