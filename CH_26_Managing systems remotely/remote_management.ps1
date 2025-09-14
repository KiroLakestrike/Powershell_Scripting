# Create an Array of hashtables to get going
$computers = @(
    @{Name = "guest1"; Cred = Get-Credential},
    @{Name = "guest2"; Cred = Get-Credential},
    @{Name = "guest3"; Cred = Get-Credential}
)

# Create Sessions fpr Each Server
$sessions = @()
foreach ($computer in $computers) {
    $session = New-PSSession -ComputerName $computer.Name -Credential $computer.Cred
    $sessions += $session
}

$highMemoryProcesses = @()
#Execute Command on each session
foreach ($session in $Sessions) {
    # We can add infinite more commands here for example: 
    $result = Invoke-Command -Session $session -ScriptBlock { 
        Get-Process | Where-Object {$_.WorkingSet -gt 100MB}
    }
$highMemoryPRocesses += $result
}

#Display the result
$highMemoryProcesses | Format-Table PSComputername, ProcessName, ID, WorkingSet

#Clean up
Remove-PSSession -Session $sessions