# PowerShell -> Discord Webhook
This script allows you to easily consume Discord Wehooks via PowerShell.

## Getting Started
The first think you'll want to do is create your configuration file.

To do that, run the script with the follow parameters:
```powershell
./discordWebhook.ps1 -CreateConfig -HookUrl "put your hook URL here" -DefaultColor purple
```

This will result in a config.json being dropped into the folder you called the script from.
