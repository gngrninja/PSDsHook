---
external help file: PSDsHook-help.xml
Module Name: PSDsHook
online version:
schema: 2.0.0
---

# Invoke-PSDsHook

## SYNOPSIS
Invoke-PsDsHook
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

## DESCRIPTION
This funciton allows you to use Discord Webhooks with embeds, files, and various configuration settings

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

Invoke-PsDsHook -CreateConfig -WebhookUrl "www.hook.com/hook2" -ConfigName 'config2'

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
{{Fill WebhookUrl Description}}

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
{{Fill ConfigName Description}}

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
{{Fill ListConfigs Description}}

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
{{Fill EmbedObject Description}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
