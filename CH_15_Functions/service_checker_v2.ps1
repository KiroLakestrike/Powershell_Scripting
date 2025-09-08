# Function to check the status of a given service

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

# Array of services to check
$services = @("wuauserv" , "w32time", "spooler", "BITS")

foreach ($service in $services) {
    if (Get-ServiceStatus -ServiceName $service) {
        Write-Host "$service is running"
    } else {
        Write-Host "$service is not running"
    }
}
