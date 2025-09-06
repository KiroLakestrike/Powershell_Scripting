#Function to check if a process is running

function Get-ProcessStatus {
    param (
        [string]$ProcessName
    )
    $process = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
    if ($process) {
        return $true
    } else {
        return $false
    }
}

#Function to ask the user to start a process if its not running using the Get-ProcessStatus
function Start-ProcessIfNotRunning {
    param (
        [string]$ProcessName
    )
    if (-not (Get-ProcessStatus -ProcessName $ProcessName)) {
        Write-Host "$ProcessName is not running"
        # Ask user if he wants to start process
        $userInput = Read-Host "Do you want to start $ProcessName? (Y/N)"
        if ($userInput -eq "Y") {
            Start-Process $ProcessName
            Start-Sleep -Seconds 2
            #check if th process is now running
            if (Get-ProcessStatus -ProcessName $ProcessName) {
                Write-Host "$ProcessName has been started"
            } else {
                Write-Host "Failed to start $ProcessName"
            }
        }
    }
}

# test with notepad.exe
Start-ProcessIfNotRunning -ProcessName "notepad"