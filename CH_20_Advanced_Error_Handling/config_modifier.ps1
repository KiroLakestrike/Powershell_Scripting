#First we globally set the Error Variable to stop.
$ErrorActionPreference = 'Stop'

#define Paths
$configPath = "C:\ImportantApp\settings.txt"
$backupFolder = "C:\ImportantApp\Backups"
$errorLogPath = "C:\ImportantApp\Errors\backup_error_log.txt"

# Create Error log file, if it doesn't exist
if(!(Test-Path $errorLogPath)) {
    Write-Host "Creating Error Log file..."
    New-Item -Path $errorLogPath -ItemType File -ErrorAction Stop
}



# Advanced Logging function

# Ist mir SCHEISS egal, ob der Funktionsname unapproved ist.

function Kiro-LogError {
	param (
	$errorRecord,
	$customMessage
	)

	$errorDetails = @"
Date:               $(Get-Date)
Custom Message:     $customMessage
Error Message:      $($errorRecord.Exception.Message)
Error Type:         $($errorRecord.Exception.GetType().FullName)
Script Name:        $($errorRecord.InvocationInfo.ScriptName)
Script Line:        $($errorRecord.InvocationInfo.ScriptLineNumber)
Invocation Name:    $($errorRecord.InvocationInfo.InvicationName)
Position Message:   $($errorRecord.InvocationInfo.PositionMessage)
Stack Trace:        $($errorRecord.ScriptStackTrace)
"@
    #Append error details to log file
    Add-Content -path $errorLogPath -Value $errorDetails
    Write-Host "Error logged. See $errorLogPath for details."
}

try{
    #Check if configuration file exists
    if (!(Test-Path $configPath)) {
        throw "Configuration file not found"    # Throw will end the scrip instantly, 
                                                # and generate a Error that is then handleable
    }

    # Create backup folder if it doesnt exist
    if (!(Test-Path $backupFolder)) {
        New-ITem -Path $backupFolder -ItemType Directory
    }
}
catch {
    Kiro-LogError -errorRecord $_ -customMessage "Error occured during initial checks"
    Write-Error "Error during inital checks: $_"
    Exit
}

try {
    # Generate a unique backup file name with timestamp
    $timestamp = Get-Date -Format "yyyy_MM_dd_HH_mm_ss"
    $configObject = Get-ChildItem $configPath
    $backupPath = "$backupFolder\$($configObject.Basename)_$timestamp$($configObject.Extension)"

    # Attempt to copy the sonfiguration file to the backup location
    Copy-ITem -PAth $configPath -Destination $backupPath

    Write-Host "Backup created successfully at $backupPath"
}
catch {
    #Log the rror to the Error log file:
    Kiro-LogError -errorRecord $_ -customMessage "Error during primary backup method"
    Write-Warning "Failed to create backup using Copy-Item. Attempting alternative method."
    try{     

        $content = Get-Content -Path $configPath -Raw
        $content | Out-File -FilePath $backupPath
        Write-Host "Backup created sucessfully using alternative method at: $backupPath"
        # This attempt will Read out the content of the config file, and create a new one in the backup location.
    }
    catch {
    Kiro-LogError -errorRecord $_ -customMessage "Secondary backup Message also failed. Backup not possible."
    Write-Error "Secondary backup Message also failed. BaAckup not possible."
        Exit
    }
}
finally {
    Write-Host "Backup Operation completed. Exiting the script."
}
