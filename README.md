[![Build status](https://ci.appveyor.com/api/projects/status/9u4rk1k9u4r233b0?svg=true)](https://ci.appveyor.com/project/gngrninja/psdshook) [![Documentation Status](https://readthedocs.org/projects/psdshook/badge/?version=latest)](https://psdshook.readthedocs.io/en/latest/?badge=latest) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# PowerShell -> Discord Webhook
PSDsHook allows you to easily utilize Discord webhooks via [PowerShell Core](https://github.com/PowerShell/PowerShell/releases).

PowerShell core is required for its enhancements to Invoke-RestMethod.

## Getting Started

### Install module from the PowerShell Gallery

This is the easiest way to use the module!
To install it, use:

```powershell
Install-Module PSDsHook
```

Then check out the [documentation](https://psdshook.readthedocs.io/en/latest/) and [examples](https://github.com/gngrninja/PSDsHook/tree/master/examples) to get started!

### Quick and Dirty

To create the configuration file, run:
```powershell
Invoke-PsDsHook -CreateConfig -WebhookUrl 'https://discordapp.com/api/webhooks/4221456689714954341337/thisisfakeandwillnotwork' -Verbose
```

To create/send an embed, run:
```powershell
using module PSDsHook
```

If the module is not installed into a folder within one of these directories:
```powershell
($env:PSModulePath -split "$([IO.Path]::PathSeparator)")
```

You'll need to use the following statement and point it to your local copy of the module's built .psm1 file.
```powershell
using module 'C:\users\thegn\repos\PsDsHook\out\PSDsHook\0.0.1\PSDsHook.psm1'
```

Embeds are sent as an array, and you can have more than one embed per webhook call. Now we'll want to create an empty array.
```powershell
[System.Collections.ArrayList]$embedArray = @()
```

(optional) specify a thumbnail url to use in the hook
```powershell
$thumbUrl = 'https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5aa44874e4966bde3633b69c/1520715914043/webhook_resized.png'
```

Create embed builder object via the [DiscordEmbed] class. 
You can customize the title and description.
```powershell
$embedBuilder = [DiscordEmbed]::New(
                    'title',
                    'description'
                )
```

Add our thumbnail to the embed:
```powershell
$embedBuilder.AddThumbnail(
    [DiscordThumbnail]::New(
        $thumbUrl
    )
)
```

Add a color:
```powershell
$embedBuilder.WithColor(
    [DiscordColor]::New(
            'purple'
    )
)
```

Add the embed to the array created above:
```powershell
$embedArray.Add($embedBuilder) | Out-Null
```

Finally, call the function that will send the embed array to the webhook url:

```powershell
Invoke-PSDsHook -EmbedObject $embedArray -Verbose
```
