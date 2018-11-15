---
external help file: PSDsHook-help.xml
Module Name: PSDsHook
online version:
schema: 2.0.0
---

# Invoke-PSDsHook

## SYNOPSIS
Invoke-PSDsHook
Use PowerShell classes to make using Discord Webhooks easy and extensible

## SYNTAX

### createDsConfig
```
Invoke-PSDsHook [-CreateConfig] [-WebhookUrl <String>] [-ConfigName <String>] [<CommonParameters>]
```

### file
```
Invoke-PSDsHook [-WebhookUrl <String>] -FilePath <String> [-ConfigName <String>] [<CommonParameters>]
```

### configList
```
Invoke-PSDsHook [-WebhookUrl <String>] [-ConfigName <String>] [-ListConfigs] [<CommonParameters>]
```

### embed
```
Invoke-PSDsHook [-WebhookUrl <String>] [-ConfigName <String>] [-EmbedObject <Object>] [<CommonParameters>]
```

### simple
```
Invoke-PSDsHook [-WebhookUrl <String>] [-ConfigName <String>] [-HookText <String>] [<CommonParameters>]
```

## DESCRIPTION
This function allows you to use Discord Webhooks with embeds, files, and various configuration settings

## EXAMPLES

### EXAMPLE 1
```
(Create a configuration file)
```

Configuration files are stored in a sub directory of your user's home directory named .psdshook/configs

Invoke-PsDsHook -CreateConfig -WebhookUrl "www.hook.com/hook"

### EXAMPLE 2
```
(Create a configuration file with a non-standard name)
```

Configuration files are stored in a sub directory of your user's home directory named .psdshook/configs

Invoke-PsDsHook -CreateConfig -WebhookUrl "www.hook.com/hook2" -ConfigName 'config2'

### EXAMPLE 3
```
(Send an embed with the default config)
```

using module PSDsHook

If the module is not in one of the folders listed in ($env:PSModulePath -split "$(\[IO.Path\]::PathSeparator)")
You must specify the full path to the psm1 file in the above using statement
Example: using module 'C:\users\thegn\repos\PsDsHook\out\PSDsHook\0.0.1\PSDsHook.psm1'

Create embed builder object via the \[DiscordEmbed\] class
$embedBuilder = \[DiscordEmbed\]::New(
                    'title',
                    'description'
                )

Add blue color
$embedBuilder.WithColor(
    \[DiscordColor\]::New(
            'blue'
    )
)

Finally, call the function that will send the embed array to the webhook url via the default configuraiton file
Invoke-PSDsHook -EmbedObject $embedBuilder -Verbose

### EXAMPLE 4
```
(Send an webhook with just text)
```

Invoke-PSDsHook -HookText 'this is the webhook message' -Verbose

## PARAMETERS

### -CreateConfig
If specified, will create a configuration based on other parameter settings (ConfigName and WebhookUrl)

```yaml
Type: SwitchParameter
Parameter Sets: createDsConfig
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -WebhookUrl
If used with CreateConfig, this is the url that will be stored in the configuration file.
If used with an embed or file, this URL will be used in the webhook call.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
{{Fill FilePath Description}}

```yaml
Type: String
Parameter Sets: file
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ConfigName
Specified a name for the configuration file. 
Can be used when creating a configuration file, as well as when passing embeds/files.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Config
Accept pipeline input: False
Accept wildcard characters: False
```

### -ListConfigs
Lists configuration files

```yaml
Type: SwitchParameter
Parameter Sets: configList
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -EmbedObject
Accepts an array of \[EmbedObject\]'s to pass in the webhook call.

```yaml
Type: Object
Parameter Sets: embed
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -HookText
{{Fill HookText Description}}

```yaml
Type: String
Parameter Sets: simple
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
