---
external help file: psdshook-help.xml
Module Name: psdshook
online version:
schema: 2.0.0
---

# Invoke-PsDsHook

## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### createConfig
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
{{Fill in the Description}}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Color
{{Fill Color Description}}

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

### -ConfigName
{{Fill ConfigName Description}}

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

### -CreateConfig
{{Fill CreateConfig Description}}

```yaml
Type: SwitchParameter
Parameter Sets: createConfig
Aliases:

Required: False
Position: Named
Default value: None
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

### -ListConfigs
{{Fill ListConfigs Description}}

```yaml
Type: SwitchParameter
Parameter Sets: configList
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
