class DiscordEmbed {
    [string]$title                        = [string]::Empty
    [string]$description                  = [string]::Empty
    [System.Collections.ArrayList]$fields = @()
    [string]$color                        = [DiscordColor]::New().ToString()   
    $thumbnail                            = [string]::Empty
    $image                                = [string]::Empty
    $author                               = [string]::Empty
    $footer                               = [string]::Empty
    $url                                  = [string]::Empty

    DiscordEmbed()
    {
        Write-Error "Please provide a title and description (and optionally, a color)!"
    }

    DiscordEmbed(
        [string]$embedTitle, 
        [string]$embedDescription
    )
    {
        $this.title       = $embedTitle
        $this.description = $embedDescription
    }

    DiscordEmbed(
        [string]      $embedTitle, 
        [string]      $embedDescription, 
        [DiscordColor]$embedColor
    )
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
            Write-Error "Did not receive a [DiscordThumbnail] object!"
        }
    }

    [void]AddImage($image)
    {
        if ($image.PsObject.TypeNames[0] -eq 'DiscordImage')
        {
            $this.image = $image
        } 
        else 
        {
            Write-Error "Did not receive a [DiscordImage] object!"
        }
    }

    [void]AddAuthor($author)
    {
        if ($author.PsObject.TypeNames[0] -eq 'DiscordAuthor')
        {
            $this.author = $author
        } 
        else 
        {
            Write-Error "Did not receive a [DiscordAuthor] object!"
        }
    }

    [void]AddFooter($footer)
    {
        if ($footer.PsObject.TypeNames[0] -eq 'DiscordFooter')
        {
            $this.footer = $footer
        } 
        else 
        {
            Write-Error "Did not receive a [DiscordFooter] object!"
        }
    }

    [void]WithUrl($url)
    {
        if (![string]::IsNullOrEmpty($url))
        {
            $this.url = $url
        } 
        else 
        {
            Write-Error "Please provide a url!"
        }
    }

    [void]WithColor([DiscordColor]$color)
    {
        $this.color = $color
    }
    
    [System.Collections.ArrayList] ListFields()
    {
        return $this.Fields
    }
}
