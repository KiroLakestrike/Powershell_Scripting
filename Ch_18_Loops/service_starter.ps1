# Run as Administrator
# First specify the service to start
$serviceName = "Spooler"
$maxAttempts = 5
$serviceStarted = $false

for($attempt = 1; $attempt -le $maxAttempts; $attempt++) {
    # Check if the service is already running
    $service = Get-Service -Name $serviceName
    if($service.Status -eq "Running") {
        Write-Host "Service $serviceName is already running." -ForegroundColor Green
        $serviceStarted = $true
        break
    }

    #attempt to start the service
    Write-Host "Attempt: $($attempt): Trying to start service $($serviceName)..."
    Start-Service -Name $serviceName

    # Wait for 5 Seconds
    Start-Sleep -Seconds 5
    $service = Get-Service -Name $serviceName
    if($service.Status -eq "Running") {
        Write-Host "Success. Service $serviceName started on attempt $attempt." -ForegroundColor Green
        $serviceStarted = $true
        break
    } else {
        Write-Host "Attempt $attempt failed. Service $serviceName is still stopped."-ForegroundColor Yellow
    }

    #Calculate and wait for the next attempt (except on the last attempt)
    if($attempt -lt $maxAttempts) {
        $waitTime = $attempt * 10
        Write-Host "Waiting $waitTime seconds before the next attempt..."
        Start-Sleep -seconds $waitTime
    }
}

if (-not $serviceStarted) {
    Write-Host "Failed to start service $serviceName after $maxAttempts tries. Try again" -ForegroundColor Red
}


