# Function to create a custom object representing a remote server

function New-ServerObject {
    param (
        [Parameter(Mandatory=$true)][string]$HostName,
        [Parameter(Mandatory=$true)][System.Management.Automation.PSCredential]$credential
    )

    $server = [PSCustomObject]@{
        HostName = $HostName
        Credential = $credential

        # Get OS information from remote computer
        os = Invoke-Command -ComputerName $HostName -Credential $credential -ScriptBlock {
            (Get-CimInstance -Classname Win32_OperatingSystem).Caption 
        }
        # Calculate total memory in GB from remote computer
        TotalMemoryGB = Invoke-Command -ComputerName $HostName -Credential $credential -ScriptBlock {
            [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)
        }

        # Get CPU count from remote Computer
        CPUCount = Invoke-Command -ComputerName $HostName -Credential $credential -ScriptBlock {
            (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
        }
    }


    return $server
}
