<# Program Name : Network.psm1
   Date: 29 June 2023
   Author: Sunday Ekhasomi
   Course: CIT361
   I, the aforementioned, affirm that I wrote this script as original work completed by me and help from the all class.
#>

Class MAC {
    $Address
    [string] MACVendorID() {
        return $this.Address.SubString(0,8)
    }
    static [string] MACVendorID ($Address) {
        return $Address.SubString(0,8)
    }
    $Vendor
    MAC($Address) {
        $this.Address = $Address.Replace('-',':')
    }
}
function Get-MACVendor {
    param(
        $MACAddress,
        [Parameter(Mandatory=$false)]$DatabasePath = ".\MACDatabase.txt"
    )
    if ($null -ne $DatabasePath) {
        #requirement 3.2.2: throw and error if the database file can't be found
        if (-not (Test-Path $DatabasePath)) {
            throw "You smell!"
    }
}
# else {
#     $DatabasePath = ".\MACDatabase.txt"
# }
    #slurp up the vendor database file:
    $vendors = Get-Content $DatabasePath
    #req. 3.3: if a MACAddress is specified, deal with it.
    if ($null -ne $MACAddress) {
        $VendorID = $MACAddress.SubString(0,8).Replace('-',':')
        $filterResult = $vendors | Where-Object {$eMAC,$eVC,$eVendor = $_.split(); $eMAC -eq $VendorID }
        $splitResult = $filterResult.split("`t")
        $m = [MAC]::new($MACAddress)
        $m.Vendor = $splitResult[2]
        return $m
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
            $m = [MAC]::new($MACAddr)
            $m.Vendor = $splitResult[2]
            return += $m
        }
        return $resultList
    }
}
function Get-IPNetwork {
    param(
        $IPAddress,
        $SubnetMask
    )
    $ip = ([IPAddress]$IPAddress).Address
    $sm = ([IPAddress]$SubnetMask).Address
    return $ip -band $sm
}
function Test-IPNetwork {
    param(
        $IP1,
        $IP2,
        $SubnetMask
    )
    if (
        (Get-IPNetwork -IPAddress $IP1 -SubnetMask $SubnetMask) -eq
        (Get-IPNetwork -IPAddress $IP2 -SubnetMask $SubnetMask)
    ) {
        return $true
    }
    else {
        return $false
    }
}


