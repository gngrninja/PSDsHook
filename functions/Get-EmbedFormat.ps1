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
        #[ValidateSet('blue','red','orange','yellow','brown','lightGreen','green','pink','purple','black','white','gray')]
        $Color        
    )

    if (!$Color) {

        $Color = 'black'

    }
    [System.Collections.ArrayList]$embedAdditions = @()

    $embedColor    = [DiscordColor]::New($Color)
    $thumbNail     = [DiscordThumbnail]::New($avatarUrl)
    $fieldTest1    = [DiscordField]::New("field1","some stuff1",$true)
    $fieldTest2    = [DiscordField]::New("field2","some more stuff2",$true)

    [System.Collections.ArrayList]$fieldArray = @()
    $fieldArray.Add($fieldTest1) | Out-Null
    $fieldArray.Add($fieldTest2) | Out-Null
    $embedAdditions.Add($fieldArray) | Out-Null

    if ($thumbNail) {
        $thumbNailInfo = [PSCustomObject]@{}

        foreach ($property in $thumbNail.PsObject.Properties) {
    
            if ($property.Value) {
    
                $thumbNailInfo | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value
    
            }
    
        }

        $embedAdditions.Add($thumbNailInfo) | Out-Null

    }
    
    $embed = [PSCustomObject]@{

        title       = $Title
        description = $Content
        color       = $embedColor.ToString()
        thumbnail   = $thumbNailInfo
        fields      = $fieldArray

    }
    <#
    foreach ($property in $embedAdditions.PsObject.Properties) {
    
        if ($property.Value) {

            $embed | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value

        }

    }
    #>
    return $embed

}