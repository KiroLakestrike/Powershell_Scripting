# Get the free space of your drive
$freeSpace = (Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object DeviceID -eq 'C:').FreeSpace / 1GB

# Print out the Free Space
Write-Host "$freeSpace GB of free Space detected"

# Create a silly statement
if ($freeSpace -gt 500) {
    Write-Host "Wow thats a lot of Free Space"
}
elseif ($freeSpace -lt 500 -and $freeSpace -gt 50 ) {
    Write-Host "Plenty of space left my dear"
}
else {
    Write-Host "Wow its getting cramped in here"
}