function Get-EmbedFormat {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory
        )]
        [string]
        $Title,

        [Parameter(
            Mandatory
        )]
        [String]
        $Content,

        [Parameter(
            Mandatory
        )]
        [int]
        $ColorValue
    )

    [System.Collections.ArrayList]$embedAdditions = @()

    #$thumbNail   = [DiscordThumbnail]::New($avatarUrl)
    $fieldTest1  = [DiscordField]::New("field1","some stuff1",$true)
    $fieldTest2  = [DiscordField]::New("field2","some more stuff2",$true)

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
        color       = $ColorValue
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