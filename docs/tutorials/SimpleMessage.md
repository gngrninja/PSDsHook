# Sending a Simple Message
Check out the [examples](https://github.com/gngrninja/PSDsHook/tree/master/examples) folder for actual scripted examples!

Create message
```powershell
$message = "This is the message."
```

Finally, call the function that will send the embed array to the webhook url:
```powershell
Invoke-PSDsHook -HookText $message -Verbose
```