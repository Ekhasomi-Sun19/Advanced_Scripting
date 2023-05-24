<# Program Name : color.ps1
Date: 05/23/2023 
Author: Sunday Ekhasomi 
Course: CIT361 
I, Sunday Ekhasomi, affirm that I wrote this script as original work completed by me. 
#>

#Get all the possible ConsoleColor values
$SystemColors = [System.Enum]::GetValues([System.ConsoleColor])
# $ValidColors = @()
$WrongGuesses = @()

#This loop iterates over each color in the $SystemColors array and adds a hashtable 
#to the $ValidColors array for each color. 
foreach ($color in $SystemColors) {
    $ValidColors += @{
        Name = $color.ToString()
        Value = $color
    }
}

#create a function that returns a random color selected from the $ValidColors array
function Get-RandomColor {
    return $ValidColors | Get-Random
}

#Create a function that displays the list of valid colors stored in the $ValidColors array. It 
#iterates over each color, formats and outputs the color name with its corresponding color 
#value, and sets the foreground color of the output to match the color value.
function show-ValidColors {
    Write-Host "Valid colors:"
    foreach ($color in $ValidColors) {
        Write-Host ("{0}{1}{2}" -f ($color.Value | Out-String -NoNewline), $color.Name, 
        ([System.ConsoleColor]::Black | Out-String -NoNewline)) -ForegroundColor $color.Value
        Write-Host
    }
}
#this function displays the list of wrong guesses made by the user during the game if there 
#are any, otherwise it shows a message indicating that no wrong guesses have been made yet. It 
#provides feedback to the user about their incorrect attempts in the game.
function Show-WrongGuesses {
    if ($WrongGuesses.Count -gt 0) {
        Write-Host "Wrong guesses: $($WrongGuesses -join ', ')"
    } else {
        Write-Host "No wrong guesses yet."
    }
}

#This function displays the list of wrong guesses stored in the $WrongGuesses array, or 
#a message indicating that there are no wrong guesses yet if the array is empty.
function Get-Hint {
    $hint = ""
    $selectedColor = $SelectedColor.Name.ToLower()
    
    if ($selectedColor -like "dark*") {
        $hint = "Dark" + $SelectedColor.Substring(4, 1)
    } else {
        $hint = $SelectedColor.Substring(0, 1)
    }
    
    return $hint.ToUpper()
}

#This part of the code initiates the game by randomly selecting a color as the $SelectedColor 
#and capturing the start time
function Play-Game {
    $SelectedColor = Get-RandomColor
    $StartTime = Get-Date

    Write-Host "Ready to Play?"
    Show-ValidColors
    Write-Host "Enter 'quit' at any time to exit the game."

    $Guesses = 0
    $GuessedCorrectly = $false

    #This code runs a loop until the correct color is guessed. It prompts the user to enter 
    #their guess, checks if the guess is "quit" to exit the game, validates if the guess is 
    #a valid color from the $ValidColors array, and displays an error message along with the 
    #valid color options if an invalid color is entered.

    while (!$GuessedCorrectly) {
        $guess = Read-Host "Please guess what the favorite color is"

        if ($guess -eq "quit") {
            return
        }

        $guess = $guess

        if ($guess -notin ($ValidColors.Name)) {
            Write-Host "Invalid color. Please enter a valid color."
            Show-ValidColors
            continue
        }

        $Guesses++ # increments the value of the $Guesses variable by 1.
        
        #create an if statement to  checks if the user's guess matches the name of the 
        #selected color, and if so, it sets the $GuessedCorrectly variable to true, captures 
        #the end time, and calculates the time taken to make the correct guess.
        if ($guess -eq $SelectedColor.Name) {
            $GuessedCorrectly = $true
            $EndTime = Get-Date
            $TimeTaken = $EndTime - $StartTime

            Write-Host "Correct, $SelectedColor is my favorite color!" -ForegroundColor $SelectedColor.Value
            Write-Host "You took $Guesses guesses to guess correctly."
            Write-Host "Time taken: $($TimeTaken.TotalSeconds) seconds."
        } else {
            Write-Host "Wrong guess. Try again."
            $WrongGuesses += $guess
            Show-WrongGuesses
            Write-Host "Hint: $(Get-Hint)"
        }
    }
}

#create a play again loop to  prompts the user to decide whether to play again 
#or not, and continues playing as long as the user responds with "yes" to continue. 
#After the loop ends, it displays a "Thanks for playing!" message.

do {
    Play-Game
    $playAgainInput = Read-Host "Do you want to play again? (yes/no)"
    $playAgain = $playAgainInput.ToLower() -ne 'n'
} while ($playAgain)

Write-Host "Thanks for playing!"