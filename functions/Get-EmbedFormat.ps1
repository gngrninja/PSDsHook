function Get-EmbedFormat {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory = $true
        )]  
        [string]
        $Title,
        [Parameter(
            Mandatory = $true
        )]  
        [String]
        $Content,
        [Parameter(
            Mandatory = $false
        )]
        [String]
        [ValidateSet('blue','red','orange','yellow','brown','lightGreen','green','pink','purple','black','white','gray')]
        $Color
    )

    if (!$Color) {

        $Color = 'black'

    }

    $embedColor = Get-EmbedColor -Color $Color

    $embed = [PSCustomObject]@{

        title       = $Title
        description = $Content
        color       = $embedColor
        thumbnail = [PSCustomObject]@{

            url = $avatarUrl

        }

    }

    return $embed

}