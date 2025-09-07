# Initialize a flag to detemine if there is any unresponsive process

$anyUnresponsive = $false

foreach ($process in Get-Process) {
    if(!$process.Responding) {
        Write-Output "Process: $($process.Name) is not responding."
        $anyUnresponsive = $true
    }
}

if (!$anyUnresponsive) {
    Write-Output "All processes are responding. All clear"
}