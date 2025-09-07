#Start counters for any Started, or Stopped services
$runningServices = 0
$stoppedServices = 0


$services = Get-Service

# Now write a foreach loop accordningly
# To count the running and stopped services

foreach ($service in $services) {
    if ($service.status -eq "Running") {
        $runningServices++
        Write-Host "$($service.Name) is Running..." 
    } else {
        $stoppedServices++
        Write-Host "$($service.Name) is Stopped..." 
    }
}

Write-Host "$runningServices Services are Running"
Write-Host "$stoppedServices Services are stopped"
