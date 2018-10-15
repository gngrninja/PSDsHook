class DiscordEmbed {

    [string]$title                        = [string]::Empty
    [string]$description                  = [string]::Empty
    [System.Collections.ArrayList]$fields = @()
    [string]$color                        = [DiscordColor]::New().ToString()   
    $thumbnail                            = [string]::Empty

    DiscordEmbed()
    {
        Write-Error "Please provide a title and description (and optionally, a color)!"
    }

    DiscordEmbed([string]$embedTitle, [string]$embedDescription)
    {
        $this.title       = $embedTitle
        $this.description = $embedDescription
    }

    DiscordEmbed([string]$embedTitle, [string]$embedDescription, [DiscordColor]$embedColor)
    {
        $this.title       = $embedTitle
        $this.description = $embedDescription
        $this.color       = $embedColor.ToString()
    }

    [void]AddField($field) 
    {
        if ($field.PsObject.TypeNames[0] -eq 'DiscordField')
        {
            Write-Verbose "Adding field to field array!"
            $this.Fields.Add($field) | Out-Null
        } 
        else
        {
            Write-Error "Did not receive a [DiscordField] object!"
        }
    }

    [void]AddThumbnail($thumbNail)
    {
        if ($thumbNail.PsObject.TypeNames[0] -eq 'DiscordThumbnail')
        {
            $this.thumbnail = $thumbNail
        } 
        else 
        {
            Write-Error "Did not receive a [DiscordField] object!"
        }
    }

    [System.Collections.ArrayList] ListFields()
    {
        return $this.Fields
    }
}
