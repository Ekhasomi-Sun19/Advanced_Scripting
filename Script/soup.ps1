function Get-Soup {
    [Alias('Soup')]
    param(
        [Parameter(Mandatory=$true)] $soup,
        [Parameter(Mandatory=$true)] [ValidateSet('Cup', 'Bowl', 'Pot')]$size,
        [ValidateRange(1,5)] $Quantity = 1, 
        [switch]$Please
    )
    if ($please) {
        "$Quantity $size$(if($quantity -gt 1){'s'}) of $soup soup for you."
    }
    else {
        "No $soup soup for you!"
    }
}