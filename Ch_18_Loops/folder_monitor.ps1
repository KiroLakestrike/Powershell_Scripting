#set the path to the folder to monitor
$folderPath = "C:\Users\$env:USERNAME\Desktop\Kiro"

#Get the initial file count in the specified folder
$fileCount = (Get-ChildItem $folderPath).Count
#Display this information
Write-Host "Initialized Folder-Watch with $fileCount items."

while ($true) {
    #Pause the script at the beginnning, to prevent excessive resource usage
    Start-Sleep -Seconds 5

    # Get the new Current file count
    $newCount = (Get-ChildItem $folderPath).Count 

    #Check if the number has changed and Give an Alert message if it did. 
    if ($newCount -ne $fileCount){
        Write-Host "ALERT!!! Red Spy is in the Base! He came for Scouts Mother" -ForegroundColor Red
        break
    } else {
        Write-Host "All according to Plan: Original Number $fileCount current Number: $newCount" -ForegroundColor Green
    }
}
