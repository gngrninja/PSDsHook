---
external help file: PSDsHook-help.xml
Module Name: PsDsHook
online version:
schema: 2.0.0
---

# Invoke-PsDsHook

## SYNOPSIS
Invoke-PsDsHook
Use PowerShell classes to make using Discord Webhooks easy and extensible

## SYNTAX

### createDsConfig
```
Invoke-PsDsHook [-CreateConfig] [-Color <String>] [-WebhookUrl <String>] [-ConfigName <String>]
 [<CommonParameters>]
```

### file
```
Invoke-PsDsHook [-Color <String>] [-WebhookUrl <String>] -FilePath <String> [-ConfigName <String>]
 [<CommonParameters>]
```

### configList
```
Invoke-PsDsHook [-Color <String>] [-WebhookUrl <String>] [-ConfigName <String>] [-ListConfigs]
 [<CommonParameters>]
```

### embed
```
Invoke-PsDsHook [-Color <String>] [-WebhookUrl <String>] [-ConfigName <String>] [-EmbedObject <Object>]
 [<CommonParameters>]
```

## DESCRIPTION
This funciton allows you to use Discord Webhooks with embeds, files, and various configuration settings

## EXAMPLES

### EXAMPLE 1
```
(Create a configuration file)
```

Configuration files are stored in a sub directory of your user's home directory named .psdshook/configs

Invoke-PsDsHook -CreateConfig -Color 'blue' -WebhookUrl "www.hook.com/hook"

## PARAMETERS

### -CreateConfig
If specified, will create a configuration based on other parameter settings (ConfigName, Color, and WebhookUrl)

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

### -Color
If specified, allows you to send a color.
If a color is unable to be resolved it will default to blue

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
