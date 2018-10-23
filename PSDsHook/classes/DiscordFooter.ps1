class DiscordFooter {
    [string]$text           = [string]::Empty
    [string]$icon_url       = [string]::Empty
    [string]$proxy_icon_url = [string]::Empty

    DiscordFooter([string]$text)
    {
        if ([string]::IsNullOrEmpty($text))
        {
            Write-Error "Please provide some footer text!"
        }
        else
        {            
            $this.name = $text
        }
    }

    DiscordFooter([string]$text, [string]$icon_url)
    {
        if ([string]::IsNullOrEmpty($text))
        {
            Write-Error "Please provide some text and an icon url"
        }
        else
        {
            $this.text       = $text
            $this.'icon_url' = $icon_url
        }
    }
}
