# Welcome Message
Write-Host "Welcome to the Process Checker Tool!"

#setup a persistent run count
$countFile = "runcount.txt"
if (Test-Path $countFile) {
    $fileContent = get-Content $countFile

    if($filecontent -match '^\d+$'){
        $global:scriptTunCount = [int]$fileContent
    } else {
        Write-Host "Invalid content in count file. Resetting Count."
        $global:scriptRunCount = 0
    }
} else {
    $global:scriptRunCount =0
}
$global:scriptRunCount++

$runningCount = 0
$notRunningCount = 0

function Check-ProcessStatus {
    param(
        [Parameter(Mandatory = $true)]
        [String]$processName
    )

    $process = Get-Process -Name $processName
    if ($process) {
        #Process is Runnning increment the counter
        $script:runningCount++
        return $true
    } else {
        # Process is not running, increment the other count
        $script:notRunningCount++
        return $false
    }
}

Check-ProcessStatus "notepad"
Check-ProcessStatus "explorer"
Check-ProcessStatus "firefox"
Check-ProcessStatus "discord"

Write-Host "Total Processes running: $runningCount `n Not Running: $notRunningCount"

Write-Host "times this script has run: $global:scriptRunCount"

$global:scriptRunCount | Out-File $countFile