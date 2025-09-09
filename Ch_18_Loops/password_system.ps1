# Password Requirements:
# at least 8 Characters long
# Must contain one number
# Exit after 3 wrong tries

$attempts = 0
$valid = $false

Write-Host "Hello User, please enter a Password"
Write-Host "It must be at least 8 characters long"
Write-Host "It must contain at least one number"

# Regex for At least one Uppercase, At least one Lowercase, At least one Number, At least one Special characeter, at least 8 characters long:
# '^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\da-zA-Z]).{8,}$'

do {
    $password = Read-Host -Prompt "Please enter Password"
    if (($password.Length -ge 8) -and ($password -match '\d')){
        $valid = $true
        Write-Host "The entered Password is valid! Well done!"
    } else {
        $attempts++
        Write-Host "Sorry, but this Password is not valid $attempts/3"
    }


} until ($attempts -ge 3 -or $valid -eq $true)