# Wir erstellen einen neuen Ordner namens Backup auf dem Desktop. 
New-Item "C:\Users\Anwender\Desktop\Backup" -ItemType "Directory"

# Wir erstellen 3 neue Datein in diesem Ordner und Füllen wir diese 3 Dateien mit Inhalt
New-Item "C:\Users\Anwender\Desktop\Backup\File1.txt", "C:\Users\Anwender\Desktop\Backup\File2.txt", "C:\Users\Anwender\Desktop\Backup\File3.txt" -ItemType "File"

# Nun Füllen wir diese 3 Dateien mit Inhalt
Add-Content -Path "C:\Users\Anwender\Desktop\Backup\File1.txt" -Value "Hello, this is content for file 1."
Add-Content -Path "C:\Users\Anwender\Desktop\Backup\File2.txt" -Value "Hello, this is Content for file 2."
Add-Content -Path "C:\Users\Anwender\Desktop\Backup\File3.txt" -Value "Hello, this is content for file 3."

# Verify
Get-ChildItem -Path "C:\Users\Anwender\Desktop\Backup\"
