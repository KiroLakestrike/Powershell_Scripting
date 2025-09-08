# Get System Information
$computerNAme = $env:COMPUTERNAME
$osInfo = Get-CimInstance Win32_OperatingSystem
$cpu = (Get-CimInstance Win32_Processor).LoadPercentage
$totalMemory = $osInfo.TotalVisibleMemorySize / 1MB
$freeMemory = $osInfo.FreePhysicalMemory / 1MB
$totalSpace = (Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object DeviceID -eq 'C:').Size / 1GB
$freeSpace = (Get-CimInstance -ClassName Win32_LogicalDisk | Where-Object DeviceID -eq 'C:').FreeSpace / 1GB

# Get some more information, like uptime in days hours and minutes
$uptime = (Get-Date) - (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$uptimeDays = $uptime.Days
$uptimeHours = $uptime.Hours
$uptimeMinutes = $uptime.Minutes

# Create the report
$report = "System Health Report Tool`n"
$report += "-----------------------`n"
$report += "Generated on: {0:yyyy-MM-dd HH:mm:ss}`n`n" -f (Get-Date)

$report += "Computer Name: {0}`n" -f $computerNAme
$report += "OS: {0}`n" -f $osInfo.Caption
$report += "OS version: {0}`n" -f $osInfo.Version
$report += "CPU usage: {0}%`n" -f $cpu
$report += "Memory usage: {0:N2} GB / {1:N2} GB`n" -f $totalMemory, $freeMemory
$report += "Disk usage: {0:N2} GB / {1:N2} GB`n" -f $totalSpace, $freeSpace

# Calculate and add usage percentages
$memoryUsagePercent = 100-(($freeMemory / $totalMemory) * 100)
$diskUsagePercent = 100- (($freeSpace / $totalSpace) * 100)

$report += "`nMemory usage percentage: {0:N2}%`n" -f $memoryUsagePercent
$report += "Disk usage percentage: {0:N2}%`n" -f $diskUsagePercent

# Add uptime information with conditional statements
$report += "`nSystem Uptime: {0} `n" -f $(
    $uptimeString = ""
    if ($uptimeDays -gt 0) {
        $uptimeString += "{0} days " -f $uptimeDays
    }
    if ($uptimeHours -gt 0) {
        $uptimeString += "{0} hours " -f $uptimeHours
    }
    if ($uptimeMinutes -gt 0) {
        $uptimeString += "{0} minutes" -f $uptimeMinutes
    }
    $uptimeString
)

# Add the llast boot time to the Report
$report += "Last Boot Time: {0:yyyy-MM-dd HH:mm:ss}`n`n" -f $osInfo.LastBootUpTime

# Check if there is a internet connection and respond accordingly
if (Test-Connection -ComputerName www.google.com -Count 1 -Quiet) {
    $report += "Internet connection is working`nIt takes {0} ms to connect to Google`n" -f (Measure-Command { Test-Connection -ComputerName www.google.com -Count 1 }).TotalMilliseconds
} else {
    $report += "Unable to connect to the Internet`n"
}

# Display the report
Write-Host $report

# Save the report to a file
$report | Out-File -FilePath "system_health_report.txt"
Write-Host "Report saved to system_health_report.txt"

# Open the report in Notepad
notepad.exe "system_health_report.txt"