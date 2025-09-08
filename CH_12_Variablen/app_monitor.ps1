# Ask the user for a process name
$process_name = Read-Host "Enter the name of the process you want to monitor"

#try to get the process
$process_object = Get-Process $process_name

# Check if the Process is running and responding  -eq = equal and $null is null So we ask if process is equal to null
if($null -eq $process_object) {
    Write-Host "$process_name is not currently running"
}
elseif ($process_object.Responding) {
    Write-Host "$process_name is working correctly."
}
else {
    Write-Host "$process_name is not responding, closing..."
    $process_object.Kill()
}

# Other ways would be if(-not $process_object)
# or (!$process_object)
