# Tool to filter Documents, and move them to specific folders. 

# Create a Hashmap with all the Extensions, and where to move them

# Feel free to add or Remove Types. and Folders as you wish
# Syntax is ".type" = "Folder"

$errorLogPath = "C:\ImportantApp\Errors"
$errorLogFile = "$errorLogPath\file_organizer_error_log.txt"

if (!(Test-Path $errorLogFile)) {
    Write-Host "Creating Error Log file..."
    New-Item -Path $errorLogFile - ItemType File -ErrorAction Stop
}


$categoryMap = @{
".txt" = "Documents"
".pdf" = "Documents"
".docx" = "Documents"
".doc" = "Documents"
".jpg" = "Images"
".gif" = "Images"
".png" = "Images"
".mp3" = "Audio"
".wav" = "Audio"
".mp4" = "Video"
".avi" = "Video"
".zip" = "Archives"
".rar" = "Archives"
".7z" = "Archives"
}

# Any other type will be moved to a "Miscellaneous" folder
$unknownExtensions = @{}


Set-Location "C:\Users\$env:USERNAME\Desktop"

function Move-FileToCategory($file, $category){
    try{
        $destinationFolder = "C:\Users\$env:USERNAME\Desktop\$category"
        if (!(Test-Path $destinationFolder)) {
            [void](New-Item -Path $destinationFolder -ItemType Director -ErrorAction Stop) 
        }
        $destinationPath = "$destinationFolder\$($file.name)"
        Move-Item -Path $file.FullName -Destination $destinationPath
        Write-Host "Moved: $($file.Name) -> $category"
    }
    catch {
        #Log the Error with timestamp File name and error Details:
        $errorMessage = "$(Get-Date) - Error moving file $($file.Name) to $category : $_"
        Add-Content -Path $errorLogFile -Value $errorMessage
        Write-Warning "Failed to move file $($file.Name). Check error log for Details."
    }
}

# Init counter for files
# This will help provide a summary in the end
$categorizedCount = 0

# Loop Through all files in the current directory
# Get-Child Item ensures that we only process files, not directories
foreach ($file in Get-ChildItem -File -ErrorAction SilentlyContinue) {
    try {
        #Get the file extension(converted to lowercase for consistency)
        $extension = $file.Extension.ToLower()

        #Check if the extension exists in our category map
        if ($categoryMap.ContainsKey($extension)) {
            # move the file to its category
            Move-FileToCategory $file $categoryMap[$extension]
            $categorizedCount++
        } else {
            Move-FileToCategory $file "Miscellaneous"
            $categorizedCount++

            if ($unknownExtensions.ContainsKey($extension)) {
                $unknownExtensions[$extension]++
            } else {
                $unknownExtensions[$extension] = 1
            }
        }
    }
    catch {
        $errorMessage = "$(Get-Date) - Error mprocessing file $($file.Name): $_"
        Add-Content -Path $errorLogFile -Value $errorMessage
        Write-Warning "Failed to process $($file.Name). Check error log for Details."
    }
}

# Print out how many files were moved
Write-Host "`nCategorized $categorizedCount file(s)`n"

Write-Host "`nFound the following Extra types:"
# At the end Loop through all the Extra extensions and their count. 
foreach ($element in $unknownExtensions.Keys) {
    Write-Host "The Extension $element was found $($unknownExtensions[$element]) times"
}


#Chech and report on Errors:
if(Test-Path $errorLogFile) {
    $errorCount = (Get-Content $errorLogPath).Count
    if ($errorCount -gt 0) {
        Write-Host "`nEncountered $errorCount error(s). Check $errorLogPath for Details."
    } else {
        Write-Host "`nNo Errors encountered during file organisatiion."
    }
} else {
    Write-Host "`nNo error log found. File Organization completed witout any logged errors."
}