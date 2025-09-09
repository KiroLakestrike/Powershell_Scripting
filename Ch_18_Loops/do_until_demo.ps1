do{
$userInput = (Read-Host "Enter a number between 1 and 10") -as [int]

if ($userInput -eq $null) {
    Write-Host "Thats not a number! Please try again"
} elseif ($userInput -lt 1 -or $userInput -gt 10) {
    Write-Host "Thats not a valid number! Try again"
}

} until ($userInput -ge 1 -and $userInput -le 10)



Write-Host "Good job! Your number is $userInput"