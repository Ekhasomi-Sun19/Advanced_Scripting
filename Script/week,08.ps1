function Get-MACVendor {
    param(
        $MACAddress,
        [Parameter(Mandatory=$true)]$DatabasePath
    )
    
    #requirement 3.2.2: throw and error if the database file can't be found
    if (-not (Test-Path $DatabasePath)) {
        throw "You smell!"
    }
    #slurp up the vendor database file:
    $vendors = Get-Content $DatabasePath
    #req. 3.3: if a MACAddress is specified, deal with it.
    if ($null -ne $MACAddress) {
        $VendorID = $MACAddress.SubString(0,8).Replace('-',':')
        $filterResult = $vendors | Where-Object {$eMAC,$eVC,$eVendor = $_.split(); $eMAC -eq $VendorID }
        $splitResult = $filterResult.split("`t")
        return $splitResult[2]
    }
    else {
        # req. 3.4: no MACAddress specified, so get vendor id of all existing adapters.
        $resultList = @()
        $adapterList = Get-NetAdapter
        foreach ($adapter in $adapterList) {
            $MACAddr = $adapter.MacAddress 
            $VendorID = $MACAddr.SubString(0,8).Replace('-',':')
            $filterResult = $vendors | Where-Object {$eMAC,$eVC,$eVendor = $_.split(); $eMAC -eq $VendorID }
            if ($null -ne $filterResult) {
                $splitResult = $filterResult.split("`t")
            }
            else {
                $splitResult = "-","notFound",""
            }
            $resultList += $splitResult[2]
        }
        return $resultList
    }
}
function Format-Songs {
    param(
        [Parameter(Mandatory=$true)]$DatabasePath,
        $Path  # $Path is the file to save the output to, if missing just return report to output stream.
    )
    if (-not (Test-Path $DatabasePath)) {
        throw "You must not be a capable Rush fan!"
    }
    if ($null -eq $Path) {
        $RushSongTable = Import-csv $DatabasePath -Delimiter "`t" 
        $AlbumCatalog = $RushSongTable | Group-Object Album
        foreach ($Album in $AlbumCatalog) {
            Write-Output "$($Album.Name) ($($Album.Group[0].Year))"
            foreach ($SongName in $Album.Group.Song) {
                Write-Output "    $SongName"
            }
        }
    }
    else {
        $output = ""
        $RushSongTable = Import-csv $DatabasePath -Delimiter "`t" 
        $AlbumCatalog = $RushSongTable | Group-Object Album
        foreach ($Album in $AlbumCatalog) {
            $output += "$($Album.Name) ($($Album.Group[0].Year))`r`n"
            foreach ($SongName in $Album.Group.Song) {
                $output += "    $SongName`r`n"
            }
        }
        try {
            Write-Output $output > $Path
        }
        catch {
            throw "Cannot write to $Path."
        }
    }
}