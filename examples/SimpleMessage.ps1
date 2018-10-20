using module PSDsHook

#Message to send
$message = "This is the message"

#Finally, call the function that will send the embed array to the webhook url via the default configuration file
Invoke-PSDsHook -HookText $message -Verbose

#Example of using another configuration file:
# Invoke-PSDsHook -HookText $message -ConfigName 'config2' -Verbose