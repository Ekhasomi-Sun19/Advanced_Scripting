<# 
Program Name : network.ps1 
Date: 05/27/2023 
Author(s): Sunday Ekhasomi
Course: CIT361 
I, Sunday Ekhasomi, affirm that I wrote this script as original work completed by me. 
#>

# Function to calculate network ID
# Function to calculate network ID
#Description: Given an IP address and a Subnet mask return the network ID
#Name: Get-IPNetwork
function Get-IPNetwork {
    param (
        [IPAddress]$IPAddress, #–IPAddress: IP address to test, this can either be passed as a string or a [ipaddress] object.
        [ipaddress]$SubnetMask #–SubnetMask: Passed as either a string or [IPAddress] object
    )

#Functionality: The network address is calculated by performing a bitwise and of the ipaddress and subnetmask 
#(use the address property of the object
    $networkID = $IPAddress.Address -band $SubnetMask.Address
    $networkIDObject = [ipaddress]$networkID

    return $networkIDObject
    
}

#Description: Determines if two IP addresses are on the same network.
function Test-IPNetwork {
    param(
        [IPAddress]$IPAddress1,
        [IPAddress]$IPAddress2,
        [IPAddress]$SubnetMask
    )

#-IP1, -IP2: IP addresses to test as either string or [IPAddress] –SubnetMask: Subnet mask to use in 
#tests as either string or [IPAddress] Functionality. Get the NetworkID of each IP address, use the 
#same Subnet mask for each IP address (Use your Get-IPNetwork function). Compare the NetworkIDs

    $networkID1 = Get-IPNetwork -IPAddress $IPAddress1 -SubnetMask $SubnetMask
    $networkID2 = Get-IPNetwork -IPAddress $IPAddress2 -SubnetMask $SubnetMask

    return $networkID1 -eq $networkID2
}

# $ipAddress1 = [IPAddress]"192.168.1.10"
# $ipAddress2 = [IPAddress]"192.168.1.20"
# $subnetMask = [IPAddress]"255.255.255.0"
#After defining the functions, write code that asks the user to input two IP addresses and a subnet mask.
$ipAddress1 = Read-Host -Prompt "Enter the first IP address"
$ipAddress2 = Read-Host -Prompt "Enter the second IP address"
$subnetMask = Read-Host -Prompt "Enter the subnet mask"

$networkID1 = Get-IPNetwork -IPAddress $ipAddress1 -SubnetMask $subnetMask
$networkID2 = Get-IPNetwork -IPAddress $ipAddress2 -SubnetMask $subnetMask

#Output the IP addresses with their corresponding network addresses
Write-Output "Network ID 1: $networkID1"
Write-Output "Network ID 2: $networkID2"

$sameNetwork = Test-IPNetwork -IPAddress1 $ipAddress1 -IPAddress2 $ipAddress2 -SubnetMask $subnetMask

#Output a statement telling the user if the two IP addresses are on the same network.
Write-Output "Are they on the same network? $sameNetwork"
