# My own written Script, to test all the things i learned


function Create-BackupObject {
    param (
        [Parameter(Mandatory = $true)][String]$BackupFolder,
        [Parameter(Mandatory = $true)][String]$TargetFolder,
        [Parameter(Mandatory = $true)][Int]$Intervall
    )

    $backup = [PSCustomObject]@{
        BackupFolder = $BackupFolder
        TargetFolder = $TargetFolder
        Intervall    = $Intervall
    }

    $backup | Add-Member -MemberType ScriptMethod -Name Init -Value {
        if (!(Test-Path $this.BackupFolder)) {
            New-Item -Path $this.BackupFolder -ItemType Directory | Out-Null
            Write-Host "Backup folder successfully created"
        } else {
            Write-Host "Wrong"
        }
    }

$backup | Add-Member -MemberType ScriptMethod -Name Start -Value {
    Write-Host "Starting backup loop. Press Ctrl+C to stop."
    while ($true) {
        $source = $this.TargetFolder
        $destination = $this.BackupFolder
        $timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
        $backupDestination = Join-Path $destination "Backup_$timestamp"

        # Create backup destination with timestamp
        Copy-Item -Path $source -Destination $backupDestination -Recurse -Force

        Write-Host "Backup completed to $backupDestination at $timestamp"

        Start-Sleep -Seconds ($this.Intervall * 60)
    }
}

    return $backup
}