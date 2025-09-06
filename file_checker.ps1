# First setup the 2D Array
# Get all files in the specified directory
$directory = "C:\Users\$env:USERNAME\Desktop"
$files = Get-ChildItem -Path $directory -File

$fileInfoArray = @()
foreach ($file in $files) {
    $fileInfo = @(
        $file.Name,
        $File.Extension,
        $file.Length,
        $file.LastWriteTime,
        $file.CreationTime
    )
    $fileInfoArray += ,$fileInfo
}

#we can Also sort the files accordingly
$sortedFileInfoArray = $fileInfoArray | Sort-Object { $_[2] } -Descending
foreach ($fileInfo in $sortedFileInfoArray) {
        $filename = $fileInfo[0]
    $fileExtension = $fileInfo[1]
    $fileLength = $fileInfo[2]
    $fileLastWrite= $fileInfo[3]
    $fileCreation = $fileInfo[4]

    Write-Host "File: $fileName"
    Write-Host "File Extension: $fileExtension"
    Write-Host "File Size: $fileLength bytes"
    Write-Host "File Last Modified: $fileLastWrite"
    Write-Host "File created: $fileCreation"
    Write-Host ""
}