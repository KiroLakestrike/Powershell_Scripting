# Define variables
$server = "www.klodel.de"
$maxAttempts = 5
$successfulPing = $false

# Start the for-Loop

for ($attempt = 1; $attempt -le $maxAttempts; $attempt++) {
    # Calculate a timeout, increasing by 1 second each attempt
    $timeout = $attempt
    Write-Host "Attempt $attempt with timeout $timeout s"

    # Attempt to ping the server
    $result = Test-Connection -ComputerName $server -Count 1 -TimeoutSeconds $timeout -ErrorAction SilentlyContinue

    # Check if the Ping was sucessful
    if($result) {
        $successfulPing = $true
        Write-Host "Success! Latency: $($result.Latency) ms" -ForegroundColor Green
        break # the loop is sucessful
    } else {
        Write-Host "Failed. Increasing timeout and retrying..." -ForegroundColor Yellow
    }
}

# Final Check after all Attempts:
if (-not $successfulPing) {
    Write-Host "All Attempts failed. Unable to reach $server." -ForegroundColor Red
}

