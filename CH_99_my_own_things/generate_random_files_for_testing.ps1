# This script will generate $howManyFiles Amount of files, and fill them with a little random Content.
# Mostly for testing purposes, as its kinda boring to work with only 1-2 test files at a time. 

$destination = "~\Desktop\Test"
$howManyFiles = 5000

$content = "I am Random file, with some content to maybe work with me at some point`n"
$content += "-----------------------------------------------------------------------`n"
$content += "I was created at: {0:yyy-MM-dd HH:mm:ss}`n" -f (Get-Date)
$content += "-----------------------------------------------------------------------`n"
$content += "I will also create Random number Pairs, to maybe be used as Serial Codes for some learning Content `n"
$content += "-----------------------------------------------------------------------`n"
$content += "Serial-Number: {0}-{1}-{2}-{3}`n" -f (Get-Random -Minimum 1111 -Maximum 9999), (Get-Random -Minimum 1111 -Maximum 9999), (Get-Random -Minimum 1111 -Maximum 9999), (Get-Random -Minimum 1111 -Maximum 9999)


for ($filesCreated = 1; $filesCreated -le $howManyFiles; $filesCreated++){
    New-Item -Path "$destination\Random_file_$filesCreated.txt" -Value $content 
}