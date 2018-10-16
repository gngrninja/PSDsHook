# Creating Your Configuration File

## Create your Discord webhook

1. Follow the getting started instructions [here](https://www.gngrninja.com/script-ninja/2018/3/10/using-discord-webhooks-with-powershell).
2. Keep that webhook URL handy.

## Create configuration file via Invoke-PSDsHook

If you have the module installed via the PowerShell gallery, great! It should auto-magically import and the command will be available. 

If not, make sure you import the compiled module via:
```powershell
Import-Module 'path\to\module.psd1' 
```

To create the configuration file, run:
```powershell
Invoke-PsDsHook -CreateConfig -WebhookUrl 'https://discordapp.com/api/webhooks/4221456689714954341337/thisisfakeandwillnotwork' -Verbose
```

## Creating more configuration files

You can create configuration files with different names.
This can be handy when you want to send a hook to a different channel with the module.

To create another configuration file, run:
```powershell
Invoke-PsDsHook -CreateConfig -WebhookUrl 'https://discordapp.com/api/webhooks/4221456689714954341337/thisisfakeandwillnotwork' -ConfigName 'config2' -Verbose
```

## List configurations

To list config files available, run:
```powershell
Invoke-PSDsHook -ListConfigs
```