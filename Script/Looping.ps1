<#
Program Name : loop-da-loop 
Date: 05/04/2023
Author: Sunday Ekhasomi
Corse: CIT361
I, Sunday Ekhasomi, affirm that I wrote this script as original work completed by me.
#> 

#Assign a string of your name to the $name variable
$name='Sunday Ekhasomi'

Clear-Host
Write-Host "Beginning output for $name" -ForegroundColor Green

#While loop that outputs the numbers 5-10  in the format of 'Number #'
'While 5-10';'=' * 80
#Your code Here
$i = 5
while ($i -le 10){
    Write-Host "number $i"
    $i++
}


#Do While loop that outputs the numbers from 100-150 counting by 10 in the format 'Number #'
'';'Do while 100-150 by 10s';'=' * 80
#Your code Here
do{
    Write-Host "Number $i"
    $i += 11
}
while ($i -lt 150)


#Do Until loop that outputs the numbers from 1000 to 1500 counting by 100 in the format 'Number #'
'';'Do until 1000-1500 by 100s';'=' * 80
#Your code Here

#For loop that outputs the numbers from -5 to -1-  in the format 'Number #'
'';'For -5 to -10';'=' * 80
#Your code Here

#Foreach loop that gets a list of files from the current directory and outputs the name and size in KB
'';'Foreach directory';'=' * 80
#Your code Here

#Any loop that outputs the numbers from 1 to 10 skipping every third number using continue in the format 'Number #'
'';'Continue 1 to 10 skipping every third number';'=' * 80
#Your code Here
$x = 0
do{
    $x++
    if($x % 3 -eq 0){
        continue
    }
    Write-Host "Number $x"
}while($x -lt 10)

Write-Host "This concludes the output for $name" -ForegroundColor Green