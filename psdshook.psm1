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

$Public  = @( Get-ChildItem -Path "$PSScriptRoot\functions\public\*.ps1" )
$Private = @( Get-ChildItem -Path "$PSScriptRoot\functions\private\*.ps1" )

@($Public + $Private) | ForEach-Object {

    Try {

        . $_.FullName

    } Catch {

        Write-Error -Message "Failed to import function $($_.FullName): $_"
        
    }

}

Export-ModuleMember -Function $Public.BaseName
#End function importing

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
#Expose color class externally
class DiscordColor {

    [int]$DecimalColor = $null
    [string]$HexColor  = [string]::Empty


    DiscordColor()
    {
        $embedColor = 8311585
        $this.HexColor     = "0x$([Convert]::ToString($embedColor, 16).ToUpper())"
        $this.DecimalColor = $embedColor
    }

    DiscordColor([int]$hex)
    {
        $this.DecimalColor = $hex
        $this.HexColor     = "0x$([Convert]::ToString($hex, 16).ToUpper())"
    }

    DiscordColor([string]$color)
    {

        [int]$embedColor = $null

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
$configDir  = "$PSScriptRoot/configs"