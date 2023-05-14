<#
<#
Program Name : rps.ps1
Date: 5/12/2020
Author: Sunday Ekhasomi
Corse: CIT361
I, Sunday Ekhasomi, affirm that I wrote this script as original work completed by me.
#>


    $roundWinner = $null
    $playerWins = 0
    $computerWins = 0

    Write-Host "Welcome to Rock, Paper, Scissors game!"

    # Ask user how many games they want to play
    $numGames = Read-Host "How many games would you like to play?"

    for ($game = 1; $game -le $numGames; $game++) {
        Write-Host "Game $game"
    }
        while ($null -eq $roundWinner) {


            # Computer randomly selects its move
            $computerMove = Get-Random -InputObject "Rock", "Paper", "Scissors"


            # Prompt user to select their move
            $playerMove = Read-Host "Enter your move (r for Rock, p for Paper, s for Scissors)"


            # Convert player's move to full name for output purposes
            switch ($playerMove) {
                "r" { $playerMove = "Rock" }
                "p" { $playerMove = "Paper" }
                "s" { $playerMove = "Scissors" }
                default { Write-Host "Invalid move. Please try again." }
            }

            if ($playerMove -in "Rock", "Paper", "Scissors") {
                Write-Host "You chose $playerMove"
                Write-Host "Computer chose $computerMove"

                # Determine the winner of this round
                switch ($playerMove) {
                    "Rock" {
                        if ($computerMove -eq "Rock") {
                            Write-Host "It's a tie!"
                        }
                        elseif ($computerMove -eq "Paper") {
                            Write-Host "Computer wins this round!"
                            $computerWins++
                        }
                        elseif ($computerMove -eq "Scissors") {
                            Write-Host "You win this round!"
                            $playerWins++
                        }
                    }
                    "Paper" {
                        if ($computerMove -eq "Rock") {
                            Write-Host "You win this round!"
                            $playerWins++
                        }
                        elseif ($computerMove -eq "Paper") {
                            Write-Host "It's a tie!"
                        }
                        elseif ($computerMove -eq "Scissors") {
                            Write-Host "Computer wins this round!"
                            $computerWins++
                        }
                    }
                    "Scissors" {
                        if ($computerMove -eq "Rock") {
                            Write-Host "Computer wins this round!"
                            $computerWins++
                        }
                        elseif ($computerMove -eq "Paper") {
                            Write-Host "You win this round!"
                            $playerWins++
                        }
                        elseif ($computerMove -eq "Scissors") {
                            Write-Host "It's a tie!"
                        }
                    }
                }

                # Check if there's a winner
                if ($playerWins -eq 2) {
                    $roundWinner = "Player"
                }
                elseif ($computerWins -eq 2) {
                    $roundWinner = "Computer"
                }
            }
        }

        # Ask if user wants to play again
        $playAgain = Read-Host "Do you want to play again? (y/n)"

        if ($playAgain.ToLower() -eq "y") {
            
            # Reset game state
            $roundWinner = $null
            $playerWins = 0
            $computerWins = 0
        }
        else {
            # End game loop
           
        }