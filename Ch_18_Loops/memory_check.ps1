# Create a few Variables
$processName = "notepad"
$memoryThreshold = 50MB

# Start the do-While Loop

do{
    #Try to get the process
    $process = Get-Process $processName

    if($process) {
        #Get the current memory usage
        $memoryUsage = $process.WorkingSet

        Write-Host "$processName is using $($memoryUsage / 1MB) MB of Memory"

        # Wait 5 seconds before the next check
        Start-Sleep -Seconds 5
    }
    #Continue the loop while the process exists and memory usage is below threshold
} while ($process -and $memoryUsage -lt $memoryThreshold)

#After Loop ends, figure out why

if($process) {
    #if process still exists, it must have exceeded the threshold
    Write-Host "$processName has exceeded the memory threshold of $($memoryThreshold / 1MB) MB"
} else {
    # if process doesnt exist, it much have stopped running
    Write-Host "$processName is not Running"
}