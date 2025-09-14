# Specify the Log file name with the current date and time
$logFile ="$(Get-Date -Format 'yyyMMdd_HHmmss')_SFC_report.txt"

Write-Host "Running system file Checker. This may take some time..."
sfc /scannow

# Interpret the exit code
$interpretation = switch ($LASTEXITCODE) {
    0 { "No integrity Problems found. No further action required."}
    1 { "SFC could not perform the requested operation. Please check the log for details."}
    2 { "SFC performed repairs. It's recommended to reboot your system." }
    4 { "SFC coult not perform the requested action. A reboot is required."}
    default { "Unexpected Exit code. Please review the log file" }
}

$report = @"
SFC Scan Report
Date: $(Get-Date)
Exit Code: $LASTEXITCODE
Interpretation: $interpretation
"@

$report | Tee-Object $logFile

Write-Host "`nDetailed report saved to: $logFile" -ForegroundColor Cyan
