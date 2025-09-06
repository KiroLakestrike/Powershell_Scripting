#Welcome Message 
Write-Host "Welcome to the Createn Date File Renamer Tool!"

# Prompt the user for a $fileName
 $fileName = Read-Host "Enter the name of the file you want to rename"

# Check if the file exists
if (Test-Path  $fileName) {
    Write-Host "File found! Preparing to rename..."
    # Rest of the renaming goes here

    # Retrieve the files object
    $fileInfo = Get-Item $fileName # we use Get-Item to retrieve the files object instead of Get-Child item because Get-Item focuses only on the one file that we want.

    # Extract the creation date
    $creationDate = $fileInfo.CreationTime

    #Write-Host "File was created on: $($creationDate.ToString("yyyy-MM-dd"))" # Option 1
    Write-Host "File was created on: $(Get-Date $creationDate -Format "yyyy-MM-dd")" # Option 2

    #contruct the new file name
    $newFileName = "$($creationDate.ToString("yyyy-MM-dd"))_$($fileInfo.BaseName)$($fileInfo.Extension)"

    # Rename the file
    Rename-Item -Path $fileName -NewName $newFileName

    # Inform the user that the file has been renamed
    Write-Host "File renamed to $newFileName"
} else {
    Write-Host "File not found"
    exit
}