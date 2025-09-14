# This is just a little Example of a Command line Script written in this lesson. 
# The past few Chapters didnt have any scripting, it was more just understanding Powershell more deeply. 

$output = Get-ChildItem -Path "$HOME\Desktop"

# I must Admit, i Really, enjoy this -Begin - Process -End structure. 

$output | ForEach-Object `
-Begin {
    $totalSize = 0 
    $filecount = 0
} `
-Process {
    $totalSize += $_.Length
    $filecount++
} `
-End {
    Write-Host "Processed $filecount files with a total of $([math]::Round($totalSize / 1MB, 2)) Megabytes."
}


#I add the rest of the Chapter here, as Commented, because it was vers interesting, but stuff id rather have in my Obsidian. 

# Get-ChildItem | Select-Object Name, @{Name="Last Modified"; Expression={$days = ((Get-Date) - $_.LastWriteTime).Days; if ($days -eq 0 ){"Today"} elseif ($days -eq 1) {"Yesterday"} else {"$days days ago"}}}
# Get-ChildItem -Directory | Add-Member -MemberType ScriptProperty -Name "SizeMB" -Value {"{0:F2} MB" -f ((Get-ChildItem $this.FullName -Recurse | Measure-Object Length -Sum).Sum /1MB)} -PassThru | Select-Object Name, SizeMB

Update-TypeData -TypeName System.IO.DirectoryInfo -MemberType ScriptProperty -MemberName "SizeMB" -Value {[math]::Round((Get-ChildItem $this.FullName -Recurse | Measure-Object Length -Sum).Sum / 1MB, 2) }

