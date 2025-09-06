# Get system resource information

$cpu = (Get-CimInstance Win32_Processor).LoadPercentage
$memory = (Get-CimInstance Win32_OperatingSystem).FreePhysicalMemory / 1MB

# Display the Current resource usage
Write-Host "Current CPU usage: $cpu %"
Write-Host "Available memory: $memory GB"

# Check the conditions and display a message accordingly
if (($cpu -gt 90) -and ($memory -lt 2)) {
    Write-Host "High CPU usage and low memory available!"
} elseif (($cpu -gt 90) -or ($memory -lt 2)) {
    Write-Host "High CPU usage or low memory available!"
} elseif (($cpu -lt 20) -and ($memory -gt 8)) {
    Write-Host "Low CPU usage and high memory available! Perfect Conditions"
} else {
    Write-Host "System resources are normal!"
}

# Example of using parentheses to control operators precedence
# Its the same principle as in math parantheses first
if (($cpu -gt 90 -or $memory -lt 2) -and $cpu -lt 95) {
    Write-Host "High usage but not critical"
}