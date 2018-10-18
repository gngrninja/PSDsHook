using module PSDsHook

#If the module is not in one of the folders listed in ($env:PSModulePath -split "$([IO.Path]::PathSeparator)")
#You must specify the full path to the psm1 file in the above using statement
#Example: using module 'C:\users\thegn\repos\PsDsHook\out\PSDsHook\0.0.1\PSDsHook.psm1'

#Message to send
$pathToFile = "path\to\file.txt"

#Finally, call the function that will send the embed array to the webhook url via the default configuration file
Invoke-PSDsHook -FilePath $pathToFile -Verbose

#Example of using another configuration file:
# Invoke-PSDsHook -FilePath $pathToFile -ConfigName 'config2' -Verbose