# Tool to filter Documents, and move them to specific folders. 

# Create a Hashmap with all the Extensions, and where to move them

# Feel free to add or Remove Types. and Folders as you wish
# Syntax is ".type" = "Folder"

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
    # Construct the path for the destination Folder
    # $PWD represents the current working directory
    $destinationFolder = "C:\Users\$env:USERNAME\Desktop\$category"

    #Create the destination folder, if it doesnt exist
    if (!(Test-Path $destinationFolder)) {
        [void](New-Item -Path $destinationFolder -ItemType Directory)
    }

    #Construct the full destination path for the file
    # This preserves the Original Filename
    $destinationPath = "$destinationFolder\$($file.name)"

    # Move the File (with -WhatIf for safety)
    # Remove -WhatIf to actually do the action
    Move-Item -Path $file.FullName -Destination $destinationPath

    #Output a Message about the move for user Feedback
    Write-Host "Moved: $($file.Name) -> $category"
}

# Init counter for files
# This will help provide a summary in the end
$categorizedCount = 0

# Loop Through all files in the current directory
# Get-Child Item ensures that we only process files, not directories
foreach ($file in Get-ChildItem -File) {
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
    # Note: Files not in our Map, will be left in place
}

# Print out how many files were moved
Write-Host "`nCategorized $categorizedCount file(s)`n"

Write-Host "`nFound the following Extra types:"
# At the end Loop through all the Extra extensions and their count. 
foreach ($element in $unknownExtensions.Keys) {
    Write-Host "The Extension $element was found $($unknownExtensions[$element]) times"
}
