# Create an arrayList to store unresponsive Processes

$unresponsiveProcesses = [System.Collections.ArrayList]::new()

#iterate Through each process using a foreach
foreach ($process in Get-Process) {
    if (!$process.Responding) {
        # void is used to suppress the index output
        [void]$unresponsiveProcesses.Add($process)
    }
}

# Check if ayny unresponsive processes weere found
if($unresponsiveProcesses.Count -gt 0) {
    Write-Output "Found $($unresponsiveProcesses.Count) unresponsive Processes"
#Iterate through unresponsive processes
    foreach($process in $unresponsiveProcesses) {
        Write-Output "Following processs doesnt respond: $($process.Name), attemtping to restart"
        # $process.CloseMainWindow()
        # Start-Process $process.name
    } 
}else {
    Write-Host "All Processes are running"
}
