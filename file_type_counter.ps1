param(
    [string]$directory = "C:\Users\$($ENV:USERNAME)\Desktop",
    [string[]]$extensions = @(".txt", ".docx", ".pdf", ".jpg", ".png")
)

#setup directorie to look for

$directory = "C:\Users\$($ENV:USERNAME)\Desktop"

#Loop through each extension in the array
$totalFiles = 0
$totalSize = 0

foreach ($ext in $extensions) {
    $files = Get-ChildItem -path $directory -Filter *$ext
    
    $count = $files.Count

    $size = ($files | Measure-Object -Property Length -Sum).sum / 1MB

    $totalFiles += $count
    $totalSize += $size

    Write-Host "Number of $ext files: $count, Total Size: $($size.ToString('N2')) MB"
}

Write-Host "Total File Count: $totalFiles"

Write-Host "Total File Size: $($totalSize.ToString('N2')) MB"