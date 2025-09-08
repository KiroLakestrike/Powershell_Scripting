# 1. Create a new Directory named "MyAwesomeAppData"
New-Item MyAwesomeAppData -ItemType Directory

# 2. Create a Configuration text file and Write Content
New-Item -Path "MyAwesomeAppData\config.txt" -ItemType "File" 
Add-Content -Path "MyAwesomeAppData\config.txt" -Value "Hello, this is the configuration file for My Awesome App."

# 3. Verify that the Files were created
Get-ChildItem MyAwesomeAppData
# 4. Verify that the content was added
Get-Content -Path "MyAwesomeAppData\config.txt"
