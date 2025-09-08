# Function to check the status of a given service, and return if the service is running or not returning true or false
function Get-ServiceStatus{
    param (
	    [Parameter(Position=0, Mandatory=$true)]
        [string]$ServiceName,
        [Parameter(Position=1)]
        [ValidateSet("Start", "Stop", "None")]
        [string]$action = "None"
    )

    $serviceStatus = (Get-Service -Name $ServiceName).Status
    if ($serviceStatus -eq "Running") {
        Write-Host "$ServiceName is running"
        if ($action -eq "Stop") {
            # Stop-Service -Name $ServiceName
            Write-Host "$ServiceName has been stopped"
        }
    }else {
        Write-Host "$ServiceName is not running"
        if ($action -eq "Start") {
            # Start-Service -Name $ServiceName
            Write-Host "$ServiceName has been started"
        }
    }
}   

Get-ServiceStatus -ServiceName "wuauserv"


