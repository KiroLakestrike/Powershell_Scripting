
# Get total and free Space on C drive, rounded to two decimal spaces 
$totalSpace = [Math]::Round((Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'").Size / 1GB, 2)
$freeSpace = [Math]::Round((Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DeviceID='C:'").FreeSpace / 1GB, 2)

# Calculate free Space Percentage
$freeSpacePercentage = [Math]::Round(($freeSpace / $totalSpace) * 100, 2)

# Calculate used Space
$usedSpace = $totalSpace - $freeSpace

# calculate used space percentage
$usedSpacePercentage = [Math]::Round(($usedSpace / $totalSpace) * 100, 2)

# Create a silly statement
if ($usedSpacePercentage -gt 90){
    Write-Host "Wow your drive is almost full, You have $usedSpace GB used and $freeSpace GB free, means you have $usedSpacePercentage % used and $freeSpacePercentage % free"
} elseif ($usedSpacePercentage -gt 50){
    Write-Host "Some space left for now, You have $usedSpace GB used and $freeSpace GB free, means you have $usedSpacePercentage % used and $freeSpacePercentage % free"
} elseif ($usedSpacePercentage -gt 25){
    Write-Host "You have still plenty of free space, You have $usedSpace GB used and $freeSpace GB free, means you have $usedSpacePercentage % used and $freeSpacePercentage % free"
} else {
    Write-Host "You have a lot of free space, You have $usedSpace GB used and $freeSpace GB free, means you have $usedSpacePercentage % used and $freeSpacePercentage % free"
}