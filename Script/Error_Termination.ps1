$dividend=Read-Host "Enter a dividend: "
$divisor=Read-Host "Enter a divisor: "
try{
    $quotient=$Dividend/$divisor
    Write-Host "The answer my friend is $quotient" -f green
}catch [System.DivideByZeroException]{
    Write-Host "You can't divide by 0." -f Red
}catch{
    Throw "something went wrong"
}finally{
    Write-Host "Thanks for doing math." -f Yellow
}