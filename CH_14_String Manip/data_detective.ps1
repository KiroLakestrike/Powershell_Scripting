# Conversion Operator Example
$userInput = Read-Host "Enter a number"

# Try to convert the user input into an integer. decimal numbers would also be converted, and rounded up or down to be a integer
if ($userInput -as [int]) {
    Write-Host "Good job! You entered: $($userInput -as [int])"
} else {
    Write-Host "Sorry, try again, you didnt enter a valid number"
}

# Match Operator example (Regex)
$userInput = Read-Host "Enter a number"

# ^\d+$ means: 
# ^ = Anfang der Zeichenkette
# \d = Eine Dezimalziffer [0-9]
# + = Eins oder mehr der vorherigen (mindestens eine Ziffer)
# $ = Ende der Zeichenkette
if ($userInput -match '^\d+$') {
    Write-Host "Good job! You entered: $($userInput -as [int])"
} else {
    Write-Host "Sorry, try again, you didnt enter a valid number"
}

# Nutze den -as operator wenn wir typen konvertieren müssen. Nutze regex, wenn wir spezifische Muster prüfen müssen

# is Operator Example
$userInput = 43

# check if the user input actually is an integer with -is - Read host ALWAYS returns a string. 
if($userInput -is [int]) {
    Write-Host "Good job! You entered: $($userInput -as [int])"
} else {
    Write-Host "Sorry, try again, you didnt enter a valid number"
}


# like Operator Example
$userInput = Read-Host "Enter the name of a report file, in this format: report_YYYY_MM_DD.xlsx"

# -like can be used to check if something is like the given rule, Working with wildcards, basically saying: "as long as the input looks like Report_IDONTCAREWHATSHERE.xlsx let it trough"
if($userInput -like "report_'.xlsx") {
    Write-Host "Valid file name"
} else {
    Write-Host "Invalid file name"
}


# NotLike Operator Example
$userInput = Read-Host "Enter the name of a file"

# -like can be used to check if something is like the given rule, Working with wildcards, basically saying: "as long as the input looks like Report_IDONTCAREWHATSHERE.xlsx let it trough"
if($userInput -notlike "*.txt") {
    Write-Host "You didnt enter a textfile"
} else {
    Write-Host "You entered a valid textfile"
}
