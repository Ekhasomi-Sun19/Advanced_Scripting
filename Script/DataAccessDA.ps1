$da=[System.Data.Odbc.OdbcDataAdapter]::new('select * from gem','DSN=gems')
$ds=[System.Data.DataSet]::new()
$da.fill($ds)
$ds.Tables[0]|ft
$ds.tables.count
$ds.tables[0].rows.count
$ds.tables[0]|select mineral,hardness|sort hardness
$ds.tables[0]|? hardness -ge 5|select mineral,hardness|sort hardness -Desc | measure

# ------------------------------------------------------------------------------------------

$csb=[System.Data.Odbc.OdbcConnectionStringBuilder]::new() 
$csb.Driver= 'Microsoft Access Driver (*.mdb, *.accdb)' 
$csb.add('dbq','C:\Users\Sunny\Desktop\psfiles\data\gems.mdb') 
$da=[System.Data.Odbc.OdbcDataAdapter]::new('select * from gem',$csb.ConnectionString) 
$ds=[System.Data.DataSet]::new($da) 
$da.fill($ds) 
$ds.Tables[0]|ft

# ---------------------------------------------------------------------------------------- 

$csb = [System.Data.Odbc.OdbcConnectionStringBuilder]::new()
$csb.Driver = 'Microsoft Access Driver (*.mdb, *.accdb)'
$csb.add('dbq','C:\Users\Sunny\Desktop\psfiles\data\gems.mdb')
$con = [System.Data.Odbc.OdbcConnection]::new($csb.ConnectionString)
$cmd = [System.Data.Odbc.OdbcCommand]::new(‘select * from gem’, $con)
$con.Open()
$reader = $cmd.ExecuteReader()
$reader = $cmd.ExecuteReader()
While ($reader.Read()) {
    Write-host $reader['Mineral'] $reader['hardness']
}
$reader.Close()
$con.Close()