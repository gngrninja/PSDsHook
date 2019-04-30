#Default config creation/update
Invoke-PsDsHook -CreateConfig 'http://hookurl.com' -Verbose

#Example of creating another named configuration
Invoke-PsDsHook -CreateConfig 'http://hookurl.com' -ConfigName 'config2' -Verbose
