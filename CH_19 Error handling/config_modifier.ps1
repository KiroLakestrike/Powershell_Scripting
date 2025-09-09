# Define the Path to the config file
# $ErrorActionPreference = 'Stop'

$configFile = "C:\Users\Anwender\Desktop\app_config.txt"
$backupFolder = "C:\Users\Anwender\Desktop\App_Backups"
# Define the new content for the config file
$newContent = "This is a config for the My_Awesome_App app"

# Attempt to back it up
Write-Host "Backing up existing config file"
Copy-Item -path $configFile -Destination $backupFolder -ErrorAction Stop

# Modify the Config file
Write-Host "Modyfing the config file"
Set-Content -Path $configFile -Value $newContent

Write-Host "Done!"