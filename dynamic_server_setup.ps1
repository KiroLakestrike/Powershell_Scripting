# Initial Variable Setup
$appName = "MyAwesomeApp"
$appDataDir = "${appName}_Data"

# 1. Create a new Directory named "MyAwesomeAppData"
New-Item $appDataDir -ItemType Directory

# 2. Create a Configuration text file and Write Content
New-Item -Path "${appDataDir}\config.txt" -ItemType "File" 
Add-Content -Path "${appDataDir}\config.txt" -Value "Hello, this is the configuration file for the App: ${appName}."

# 3. Verify that the Files were created
Get-ChildItem $appDataDir
# 4. Verify that the content was added
Get-Content -Path "${appDataDir}\config.txt"
