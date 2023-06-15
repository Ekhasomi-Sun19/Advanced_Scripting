
class Metal{
    [string]$Symbol
    [string]$Name
    [int]$MeltingPoint
    [double]$SpecificGravity
}
$m1=[Metal]::New()
$m1.Symbol = 'Au'
$m1.Name = 'Gold'
$m1.MeltingPoint = 1945
$m1.SpecificGravity = 19.3
$m1
$m2 = New-Object Metal
$m2
$m3 = [Metal] @{Symbol='Au'; Name='Gold'}
$m3
$Metals=import-csv Metals.csv|ForEach-Object {[Metal]$_}
$Metals[0].GetType()