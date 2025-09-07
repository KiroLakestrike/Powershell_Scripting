# parameter for search functionality
param(
    [string]$searchProcess
)


# Generate the Array List to track Memory hungry Processes

$memoryHungry =  [System.Collections.ArrayList]::new() 
#iterate over every process and save the ones who use more than 100 mb to the aarray list. 

$allProcesses = Get-Process

foreach ($process in $allProcesses) {
    if ($process.WorkingSet / 1MB -gt 100){
        [void]$memoryHungry.Add($process)
    }
}

# Display Report

Write-Output "Memory-Intensive Processes Report"
Write-Output " Total Memory Hungry Processes: $($memoryHungry.Count)"

 #Sort the Memory hungry Processes
 $sortedProcesses = $memoryHungry | Sort-Object -Property WorkingSet -Descending

# Add the search functionality
if($searchProcess) {
    Write-Output "`nSearching for Process: $searchProcess `n"
    $found = $false
    foreach ($process in $memoryHungry) {
        if($process.Name -eq $searchProcess) {
            $memoryUsageMB = [math]::Round($process.WorkingSet / 1MB, 2)
            Write-Output "$searchProcess is using $memoryUsageMB MB of Memory"
            $found = $true
            exit
        }
    }
    if(-not $found) {
        Write-Output "$searchProcess is not in the list of Memory-intensive Processes"
        exit
    }
}

# Loop through the array List to display info: 
foreach ($process in $sortedProcesses) {
    $memoryUsageMB = [math]::Round($process.WorkingSet / 1MB, 2)
    Write-Output "$($process.Name) is using $memoryUsageMB MB of Memory"
}


# Clculate and display total memory usage

$totalMemoryUsage = ($memoryHungry | Measure-Object -Property WorkingSet -sum).sum / 1GB
$totalMemoryUsage = [math]::Round($totalMemoryUsage, 2)
Write-Output "`n Total Memory Usage of intense processes: $totalMemoryUsage GB"