# This script Monitors CPU Usage of selected apps. 
$processes = @("notepad", "CalculatorApp")

# Set the cpu threshhold
$cpuThreshhold = 10

$interval = 3


do {
    foreach ($processName in $processes){
        $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
        
        if($process) {
            $startCPU = (Get-Process -Name $processName | Measure-Object -Property CPU -Sum).Sum
            Start-Sleep -Seconds 1
            $endCPU = (Get-Process -Name $processName | Measure-Object -Property CPU -Sum).Sum
            $cpuPercentage = ($endCPU - $startCPU) * 100
            Write-Host "$($processName): $cpuPercentage %"
            if($cpuPercentage -gt $cpuThreshhold){
                Write-Host "$processName is using $cpuPercentage% CPU - Above treshold!" -ForegroundColor Red
            } else {
                Write-Host "$processName is using $cpuPercentage% CPU" - ForegroundColor Green
            }
        } else {
            Write-Host "$processName is not running" -ForegroundColor Yellow
        }
    }
    Start-Sleep -Seconds $interval
} while ($true) #loop foreveeeer