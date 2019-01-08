$table = New-Object system.Data.DataTable 'TableA'
$newcol = New-Object system.Data.DataColumn ID,([long]); $table.columns.add($newcol)
$newcol = New-Object system.Data.DataColumn DirPath,([string]); $table.columns.add($newcol)
$newcol = New-Object system.Data.DataColumn FileCount,([long]); $table.columns.add($newcol)

[int]$id = 0

Get-ChildItem -Path 'C:\Temp' | Where-Object { $_.PSIsContainer } | ForEach-Object { 
    
    $id++
    $dir = $_.Name
    
    $row = $table.NewRow()
    $row.ID = $id
    $row.DirPath = $_.Name
    $row.FileCount = ( Get-ChildItem $_ | Where-Object { -not $_.PSIsContainer } | Measure-Object ).Count

    $table.Rows.Add($row)
   
}

    
[string]$connectionString = "Server=LOCALHOST;Database=DevTest;Integrated Security=True"

$con = New-Object System.Data.SqlClient.SqlConnection -ArgumentList @($connectionString)
$con.Open()

$cmd = $con.CreateCommand()
$cmd.CommandText = "dbo.spInsertToTableA"
$cmd.CommandType=[System.Data.CommandType]::StoredProcedure
$cmd.Parameters.Add("@tab", [System.Data.SqlDbType]::Structured).Value = $table
    
$cmd.ExecuteNonQuery() | Out-Null

$con.Close()
 
