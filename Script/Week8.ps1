














    param(
        $MACAddress,
        [Parameter(Mandatory=$true)]$DatabasePath
    )
    if (-not (Test-Path $DatabasePath)) {
        throw "You smell"
    }

    #req. 3.3: if a MACAddress is specified, deal with it.
    if ($null -ne $MACAddress) {
        $MACAddress.SubString(0,8).Replace('-',':')
    }
    if ($null -ne $MACAddress) {
        $VendorID = $MACAddress
    }
# }