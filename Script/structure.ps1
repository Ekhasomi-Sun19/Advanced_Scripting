write-Host 'Congratulations, you are running the structures.ps1 script!'
$answer = Read-Host 'What is the answer?' 
if ($answer -eq 42)
{
    Write-Host "Correct, the answer is $answer"
}
elseif ($answer -eq "jesus"){
    Write-Host "Keep the faith"
}
else{
    Write-Host "$answer is not correct, the answer is 42." 
}
for ($i = 1; $i -le 10; $i++){
    Write-Host "`$i contains $1"
}