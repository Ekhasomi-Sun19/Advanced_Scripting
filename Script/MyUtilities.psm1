Function Get-UtilitiesProgressPreference{
    $UtilitiesProgress
}

function Set-UtilitiesProgressPreference{
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('SilentlyContinue','Continue')]
        $Preference
    )
    $Script:UtilitiesProgress=$Preference
    
}


Function Get-WebFile{
    param(
        [Parameter(Mandatory)]
        [string]$Uri,
        [Parameter(Mandatory)]
        [string]$OutFile
    )
    #save current preference
    $pref=$Global:ProgressPreference
    #use the module preference
    $Global:ProgressPreference=$UtilitiesProgress
    Invoke-WebRequest -Uri $Uri -OutFile $OutFile
    #Restore Preference
    $Global:ProgressPreference=$pref
}
Export-ModuleMember -Variable $UtilitiesProgress