# Display menu options
Write-Host "Simple Network Troubleshooter"
Write-Host "Please Enter one of the following numbers"
Write-Host "1. Check Internet Connection"
Write-Host "2. Check IP-Configuration"
Write-Host "3. Flush DNS"

$choice = Read-Host "Enter your choice (1-3)"

switch ($choice) {
    "1" {
        # Check internet connection
        $testResult = Test-Connection -ComputerName www.google.com -Count 1 -Quiet
        if ($testResult -eq "True") {
            Write-Host "Internet connection is working"
        } else {
            Write-Host "Unable to connect to the Internet"
        }
    }
    "2" {
        # Display IP Configuration
        $ipAddress = (Get-NetIPConfiguration).IPv4Address.IPAddress
        $defaultGateway = (Get-NetIPConfiguration).IPv4DefaultGateway.NextHop
        Write-Host "IP Adress: $ipAddress"
        Write-Host "Default Gateway: $defaultGateway"
    }
    "3" {
        # Flush the DNS Cache
        Clear-DnsClientCache
        Write-Host "DNS Cache has been flushed"
    }
    default {
        # Invalid Choice
        Write-Host "Invalid Choice, please run the script again"
    }
}