function Get-ServiceStatus {
    param(
        [Parameter(Mandatory=$true)]
        [string]$ServiceName
    )
    $serviceStatus = (Get-Service -Name $ServiceName)

    if($serviceStatus -eq "Stopped") {
        return $false
    } else {
        return $true
    }
}


# Array with all the services to check
$services = @(
    @("wuauserv", "Windows Update", "TryStart", "Critial: Windows Update Service is vital for receiving updates."),
    @("w32time", "Time Service", "TryStart", "Critical: Time Service is vital for time synchronization."),
    @("spooler", "Printer Service", "AlertOnly", "Non-Critical: Printer Service is for printing."),
    @("BITS", "Background Intelligent Transfer Service", "TryStart", "Non-Critical: BITS is vital background transfer.")
)

foreach ($service in $services) {
    #Extract Information from the Inner Array
    $serviceName = $service[0]
    $serviceDisplayName = $service[1]
    $serviceAction = $service[2]
    $serviceDescription = $service[3]

    #Check if the service is running
    if (Get-ServiceStatus -ServiceName $serviceName) {
        Write-Host "$serviceDisplayName is running"
        # Now see it the action is "tryStop"
        if($serviceAction -eq "TryStop") {
            #Stop-Service -Name $serviceName
            Write-Host "Service has been stopped"
        }
        if($serviceAction -eq "AlertOnly") {
        Write-Host "$serviceDescription"
        }
    } else {
        Write-Host "Service is not running"
        #now see what the actiona are: 
        if ($serviceAction -eq "TryStart") {
            Write-Host "Starting the service"
            #Start-Service -Name $serviceName
            Write-Host "Service has been started"
        }
        if($serviceAction -eq "AlertOnly") {
            Write-Host "$serviceDescription"
        }
    }
}