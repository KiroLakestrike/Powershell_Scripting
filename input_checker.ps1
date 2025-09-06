# like Operator Example
$userInput = Read-Host "Please Enter a Date in this Format: YYYY-MM-DD"

# Check if the user entered a string (which should always be true due to Read-Host always returning a string)
# As with other languages and programming rules, it is always important to check your inputs for valid types, no matter where they come from
if ($userInput -as [string]) {
    # Check if the date format is correct using regex.
    # ITs also possible to use the -like operator with "???-??-??"
    if($userInput -match '^\d{4}-\d{2}-\d{2}$') {
        Write-Host "Correct Format, nicely done"
    } else {
        Write-Host "Sadly you didnt provide a correct date"
    }
} else {
    Write-Host "Sorry you didnt enter a correct input"
}