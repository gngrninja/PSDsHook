# Sending a Simple Message

Check out the [examples](https://github.com/gngrninja/PSDsHook/tree/master/examples) folder for actual scripted examples!

To use embeds with this module, you'll first need to have a [using statement](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_using?view=powershell-6) to access the classes within it.

Example of using statement:
```powershell
using module PSDsHook
```

If the module is not installed into a folder within one of these directories:
```powershell
($env:PSModulePath -split "$([IO.Path]::PathSeparator)")
```

You'll need to use the following statement and point it to your local copy of the module's built .psm1 file
```powershell
using module 'C:\users\thegn\repos\PsDsHook\out\PSDsHook\0.0.1\PSDsHook.psm1'
```

Create message

```powershell
$message = "This is the message."
```

Finally, call the function that will send the embed array to the webhook url:

```powershell
Invoke-PSDsHook -HookText $message -Verbose
```