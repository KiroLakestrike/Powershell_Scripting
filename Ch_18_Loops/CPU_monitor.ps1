# This script will check the 
$intervall = 10 # Intervall of the script in seconds.
$logFileDestination = "~\Desktop\Logs\log.txt"


while ($true) {
$loadMessage = "{0:yyy-MM-dd HH:mm:ss}: " -f (Get-Date)
$cpuUsage = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty LoadPercentage


# Create the Load Percentage "progress Bar" 
for($i = 1; $i -le 100; $i++){
    if ($i -le $cpuUsage){
        $loadMessage += "█"
    } else {
        $loadMessage += "_"
    }
}

# Add a Summary to to the load message: 
$loadMessage += " CPU Load at $cpuUsage %    "

# Color Switcher and File Writer for HEavy Load
if ($cpuUsage -ge 90) { # CPU at more than 90 % Load
    $diplayColor = "Red"
    Add-Content -Path $logFileDestination -Value $loadMessage
} elseif ($cpuUsage -ge 50) { # CPU at more than 50 % Load
    $diplayColor = "Orange"
} elseif ($cpuUsage -ge 25) {# CPU at more than 25 % Load
    $diplayColor = "Yellow"
} else {
    $diplayColor = "Green"
}

Write-Host $loadMessage -ForegroundColor $diplayColor -NoNewline
Write-Host "`r" -NoNewline  # Return cursor to line start

Start-Sleep -Seconds $intervall
}