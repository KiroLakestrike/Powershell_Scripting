# Get current day and hour
$day = (Get-Date).DayOfWeek # Typically returns a string like "Sunday"
$hour = (Get-Date).Hour

# Check if its a weekday
$isWeekday = $day -ge 1 -and $day -le 5 # Powershelll uses 0 = Sunday and 6 = Saturday, its smart enough to convert these on the fly via ENUM, will return True or False

# Check if its a business hour
$isBusinessHour = $hour -ge 8 -and $hour -lt 17

if ($day -eq "Wednesday" -and $hour -gt 14 -and $hour -lt 15) {
    Write-Host "Meeting Hour!"
} elseif ($isWeekday -and $isBusinessHour) {
    Write-Host "It's a weekday and a business hour!"
} elseif (-not $isWeekday -or -not $isBusinessHour) {
    Write-Host "It's not a weekday or a business hour!"
}