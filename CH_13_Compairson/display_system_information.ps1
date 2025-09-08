# First create the Menu
Write-Host "Welcome to the System Information Tool"
Write-Host "Please select one of the following options"
Write-Host "1. Operating System Information"
Write-Host "2. CPU Information"
Write-Host "3. Total Memory"
Write-Host "4. Current User"

# Now get the user's choice
$choice = Read-Host "Enter your choice (1-4)"

# Now display the information
switch ($choice) {
    "1" { 
        $os = Get-CimInstance Win32_OperatingSystem
        $os_name = $os.Vaption
        $os_version = $os.Version
        Write-Host "Operating System: $os_name"
        Write-Host "Version: $os_version"
    }
    "2" { 
        $cpu = Get-CimInstance Win32_Processor
        $cpu_name = $cpu.Name
        $cpu_cores = $cpu.NumberOfCores
        $cpu_speed = $cpu.MaxClockSpeed
        Write-Host "CPU Name: $cpu_name"
        Write-Host "CPU Cores: $cpu_cores"
        Write-Host "CPU Max Clock Speed: $($cpu_speed / 1000) GHz" # Convers MHz to GHz
    }
    "3" { 
        $memoryInGB = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
        Write-Host "Total Physical Memory: $memoryInGB GB"
    }
    "4" { 
        $currentUser = $env:USERNAME
        Write-Host "Current User: $currentUser"
    }
    default { 
        Write-Host "Invalid choice, please try again" 
    }
}
