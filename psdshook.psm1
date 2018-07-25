#Import functions
$functions = Get-ChildItem -Path "$PSScriptRoot\functions"                    |
                Where-Object {!$_.PSIsContainer -and $_.Extension -eq '.ps1'} |
                Select-Object -ExpandProperty FullName

#Dot source functions from functions folder
if ($functions) {

    foreach ($function in $functions) {

        Write-Verbose "Importing [$function]"
        . $function

    }
}

#Import classes
$classes = Get-ChildItem -Path "$PSScriptRoot\classes\*.ps1"
foreach ($class in $classes) {
    try {

        . $class.FullName
        Write-Verbose "Imported [$($class.FullName)]!"

    }
    catch {

        Write-Error "Unable to import [$($class.FullName)] -> [$($_.Exception.Message)]!"

    }
}

$configDir  = "$PSScriptRoot/configs"
class DiscordColor {

    [int]$DecimalColor = $null
    [string]$HexColor  = [string]::Empty

    DiscordColor([int]$hex)
    {
        $this.DecimalColor = $hex
        $this.HexColor     = "0x$([Convert]::ToString($hex, 16).ToUpper())"
    }

    DiscordColor([string]$color)
    {

        [int] $embedColor = $null

        try {

            $embedColor = $color

        }
        catch {
            switch ($Color) {

                'blue' {

                    $embedColor = 4886754
                }

                'red' {

                    $embedColor = 13632027

                }

                'orange' {

                    $embedColor = 16098851

                }

                'yellow' {

                    $embedColor = 16312092

                }

                'brown' {

                    $embedColor = 9131818

                }

                'lightGreen' {

                    $embedColor = 8311585

                }

                'green' {

                    $embedColor = 4289797

                }

                'pink' {

                    $embedColor = 12390624

                }

                'purple' {

                    $embedColor = 9442302

                }

                'black' {

                    $embedColor = 1
                }

                'white' {

                    $embedColor = 16777215

                }

                'gray' {

                    $embedColor = 10197915

                }

                default {

                    $embedColor = 1

                }
            }
        }

        $this.HexColor     = "0x$([Convert]::ToString($embedColor, 16).ToUpper())"
        $this.DecimalColor = $embedColor

    }

    DiscordColor([int]$r, [int]$g, [int]$b)
    {
        $this.DecimalColor = $this.ConvertFromRgb($r, $g, $b)
    }

    [string] ConvertFromHex([string]$hex)
    {
        [int]$decimalValue = [Convert]::ToDecimal($hex)

        return $decimalValue
    }

    [string] ConvertFromRgb([int]$r, [int]$g, [int]$b)
    {
        $hexR = [Convert]::ToString($r, 16).ToUpper()
        if ($hexR.Length -eq 1)
        {
            $hexR = "0$hexR"
        }

        $hexG = [Convert]::ToString($g, 16).ToUpper()
        if ($hexG.Length -eq 1)
        {
            $hexG = "0$hexG"
        }

        $hexB = [Convert]::ToString($b, 16).ToUpper()
        if ($hexB.Length -eq 1)
        {
            $hexB = "0$hexB"
        }

        [string]$hexValue     = "0x$hexR$hexG$hexB"
        $this.HexColor        = $HexValue
        [string]$decimalValue = $this.ConvertFromHex([int]$hexValue)

        return $decimalValue
    }

    [string] ToString()
    {
        return $this.DecimalColor
    }
}
function Invoke-PsDsHook {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory,
            ParameterSetName = 'embed'
        )]
        [string]
        $Content,

        [Parameter(

        )]
        $Color,

        [Parameter(
            ParameterSetName = 'embed'
        )]
        [string]
        $Title,

        [Parameter(
            ParameterSetName = 'createConfig'
        )]
        [switch]
        $CreateConfig,

        [Parameter(
            Mandatory,
            ParameterSetName = 'createConfig'
        )]
        [string]
        $WebhookUrl,

        [Parameter(
            Mandatory,
            ParameterSetName = 'file'
        )]
        [string]
        $FilePath,

        [Parameter(

        )]
        [string]
        $ConfigName = 'config',

        [Parameter(
            ParameterSetName = 'configList'
        )]
        [switch]
        $ListConfigs
    )

    $configPath = "$configDir/$ConfigName.json"

    if (!(Test-Path -Path $configPath) -and !$CreateConfig) {

        Write-Error "Unable to access [$configPath]. Please provide a valid configuration name. Use -ListConfigs to list configurations, or -CreateConfig to create one."
        break

    } elseif (!$CreateConfig) {

        #$config      = (Get-Content -Path $configPath | ConvertFrom-Json)
        $config      = [DiscordConfig]::New($configPath)
        $hookUrl     = $config.HookUrl
        if ([string]::IsNullOrEmpty($Color)) {

            Write-Verbose "Did not receive a color, using default -> [$($config.DefaultColor)]"
            $Color = $config.DefaultColor

        }

    }

    switch ($PSCmdlet.ParameterSetName) {

        'embed' {

            foreach ($property in $possibleHookProperties.PsObject.Properties) {

                if ($property.Value) {

                    $hookObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value

                }

            }

            Write-Verbose "Sending:"
            Write-Verbose ""
            Write-Verbose ($hookObject | ConvertTo-Json -Depth 4)

            try {

                Invoke-RestMethod -Uri $hookUrl -Body ($hookObject | ConvertTo-Json -Depth 4) -ContentType $contentType -Method Post

            }
            catch {

                $errorMessage = $_.Exception.Message
                Write-Error "Error executing Discord Webhook -> [$errorMessage]!"

            }
        }

        'file' {

            $fileInfo   = [DiscordFile]::New($FilePath)
            $hookObject = $fileInfo.Content

            Write-Verbose "Sending:"
            Write-Verbose ""
            Write-Verbose ($hookObject | Out-String)

            #If it is a file, we don't want to include the ContentType parameter as it is included in the body
            try {

                Invoke-RestMethod -Uri $hookUrl -Body $hookObject -Method Post

            }
            catch {

                $errorMessage = $_.Exception.Message
                Write-Error "Error executing Discord Webhook -> [$errorMessage]!"

            }
        }

        'createConfig' {

            if ([string]::IsNullOrEmpty($Color)) {

                $Color = 'lightGreen'

            }
            [DiscordConfig]::New($WebhookUrl, $Color, $configPath)

        }
    }
}