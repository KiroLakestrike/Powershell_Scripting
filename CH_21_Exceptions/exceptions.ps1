# Here i skipped most of the videos. 
# The first 2 Videos is going on about 20 Different Exceptions that can happen 
# While showing us on each how to use the same command: 
# $error[0].Exception.GetType().FullName
# Just to get the name of the Exception. 

# in Video 3 of 5 i will write some examples on how to catch them, 
# but i will not be doing the full script anymore. 
try {
New-Item -Path "C:\Windows\System32\blahblah.txt" -ItemType File
}
catch [System.UnauthorizedAccessException] {
    Write-Error "Access denied, why would you try that? $($_.Exception.Message)" # Omg this simple solution took the dude almost 20 minutes,
    # More code to deal with the Error goes here. For example logging into a file or anthing you please. 
    # With this simple soltuion you can catch every specific Exception you need.

}
