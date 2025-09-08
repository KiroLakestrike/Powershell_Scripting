#Promt The user for the Applications Name
$appName = Read-Host "Enter the name of the Application"

#Declare the directory
$appDataDir = "${appName}_Data"

# 1. Create a new Directory named "MyAwesomeAppData"
New-Item $appDataDir -ItemType Directory

# 2. Create a Configuration text file and Write Content
New-Item -Path "${appDataDir}\config.txt" -ItemType "File" 
Add-Content -Path "${appDataDir}\config.txt" -Value "$(Get-Date -Format 'yyy-MM-dd HH:mm:ss'): Hello, this is the configuration file for the App: ${appName}."

# 3. Verify that the Files were created
Get-ChildItem $appDataDir
# 4. Verify that the content was added
Get-Content -Path "${appDataDir}\config.txt"

# Ask the user to Input new Content
$newContent = Read-Host "What would you like to add?"

# Input the new Content
Add-Content -Path "${appDataDir}\config.txt" -Value "$(Get-Date -Format 'yyy-MM-dd HH:mm:ss'): ${newContent}"