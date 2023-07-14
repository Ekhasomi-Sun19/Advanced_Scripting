Write-Host ""
Write-Host "1. How many bytes are in the file you downloaded?"
Write-Host "*************************************************"
# Specify the path to the folder
$folder = "C:\Users\Sunny\Downloads\psfiles"

# Get all items within the folder (including subfolders and files)
$items = Get-ChildItem -Path $folder -Recurse

# Calculate the total size in bytes
$totalSizeInBytes = ($items | Measure-Object -Property Length -Sum).Sum

# Display the total size
Write-Host "Total size: $totalSizeInBytes bytes"
Write-Host ""


Write-Host "2. What is the MD5 hash of the file?"
Write-Host "*************************************************"
Write-Host ""

$MD5Hash = Get-FileHash -Path .\psfiles\data\gems.xml -Algorithm MD5 | Select-Object -ExpandProperty Hash
$MD5Hash 


Write-Host ""
Write-Host "3. How many gems are there"
Write-Host "*************************************************"

$csvPath = "C:\Users\Sunny\Downloads\Final\psfiles\data\gems.csv"
Import-Csv -path $csvPath 


Write-Host ""
Write-Host "4. what is the average hardness of all the gems"
Write-Host "*************************************************"

$filePath = "C:\Users\Sunny\Downloads\Final\psfiles\data\gems.csv"
# Check if the file exists

if (Test-Path $filePath) {
    # Import the CSV file

    $gems = Import-Csv -Path $filePath
    # Calculate the average hardness
    $averageHardness = ($gems | Measure-Object -Property Hardness -Average).Average

    Write-Host "Average hardness of gems: $averageHardness"

} else {

    Write-Host "File not found at $filePath"

}


Write-Host ""
Write-Host "5. How many words are in the document"
Write-Host "*************************************************"

# Specify the path to the text file
$textFile = "psfiles\files\DOI.txt"

# Read the contents of the text file
$fileContent = Get-Content -Path $textFile -Raw

# Split the text into words and count the number of words
$wordCount = ($fileContent -split '\s+' | Measure-Object).Count

# Display the number of words
Write-Host "Number of words: $wordCount"


Write-Host ""
Write-Host "6. How many unique words are in the document?"
Write-Host "*************************************************"

# Specify the path to the text file
$textFile = "psfiles\files\DOI.txt"

# Read the contents of the text file
$fileContent = Get-Content -Path $textFile -Raw

# Split the text into words, select only the unique words, and count them
$uniqueWordCount = ($fileContent -split '\s+' | Select-Object -Unique | Measure-Object).Count

# Display the number of unique words
Write-Host "Number of unique words: $uniqueWordCount"


Write-Host ""
Write-Host "7. How many unique words are in the document?"
Write-Host "*************************************************"


# Specify the path to the text file
$textFile = "psfiles\files\DOI.txt"

# Read the contents of the text file
$fileContent = Get-Content -Path $textFile -Raw

# Split the text into words, select only the unique words, and sort them alphabetically
$uniqueWords = $fileContent -split '\s+' | Select-Object -Unique | Sort-Object

# Extract the directory path from the text file path 
$directoryPath = Split-Path -Path $textFile -Parent

# Construct the output file path
$outputFilePath = Join-Path -Path $directoryPath -ChildPath "words.txt"

# Export the unique words to the output file
$uniqueWords | Out-File -FilePath $outputFilePath

# Display a success message
Write-Host "Unique words sorted and exported to '$outputFilePath'."
Write-Host "File created inside the psfile FOLDER"



