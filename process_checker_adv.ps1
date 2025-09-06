#first create a function to check on the process
function Check-Process {
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [String]$processName,
        [Parameter(Position = 1, Mandatory = $true)]
        [ValidateSet("Start", "Stop", "Restart", "Info")]
        [String]$action
    )

    $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
        switch ($action) {
            "Start" {
                if ($process) {
                    Write-Host "$processName is already running"
                } else {
                    Start-Process $processName
                    Write-Host "$processName has been started"
                }
            }
            "Stop" {
                if ($process) {
                    Stop-Process -Name $processName
                    Write-Host "$processName has been stopped"
                } else {
                    Write-Host "$processName is not running"
                }
            }
            "Restart" {
                if ($process) {
                    Stop-Process -Name $processName -Force
                    Start-Process $processName
                    Write-Host "$processName has been restarted"
                } else {
                    Start-Process $processName
                    Write-Host "$processName has been started"
                }
            }
            "Info" {
                if ($process) {
                    Write-Host "Process Name: $($process.Name)"
                    Write-Host "Process ID: $($process.Id)"
                    Write-Host "Process CPU Usage: $($process.CPU)"
                    Write-Host "Process Memory Usage: $($process.WorkingSet64 / 1MB) MB"
                } else {
                    Write-Host "$processName is not running"
                }
            }
            Default {
                Write-Host "Invalid action"
            }
        }
}

Check-Process -processName "notepad" Info