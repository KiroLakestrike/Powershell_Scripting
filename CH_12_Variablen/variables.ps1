# First we create a variable to our new File and a variable for the content
$filename = "myNewDocument.txt"
$content = "This goes right into the new File, its Content. much WOW"

# Then we create the new file
New-Item $filename -ItemType "File"

# Afterwards we fill it with the content
Add-Content -Path $filename -Value $content

# then we print out the content of the file
Get-Content -Path $filename