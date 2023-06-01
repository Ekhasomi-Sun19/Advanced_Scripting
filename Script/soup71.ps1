function Get-Soup {

    <#
        .SYNOPSIS
        Get-Soup provides soup orders, but for polite clients only!
        .DESCRIPTION
        Get-Soup is a sophisticated simulation of a famous character
        of the television series "Seinfied"
        .EXAMPLE
        Get-Soup
        
        This results in a stern denial of service for impolitness

        .EXAMPLE
        Get-Soup -Please -Quantity 2 -Soup "Cheddar Broccoli" -Size Bowl

        This results is friendly delivery of a politely ordered soup request: 
        2 Bowls of Cheddar Broccoli soup for you.
    #>
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