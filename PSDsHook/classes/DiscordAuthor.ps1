
class DiscordAuthor {
    [string]$name           = [string]::Empty
    [string]$url            = [string]::Empty
    [string]$icon_url       = [string]::Empty
    [string]$proxy_icon_url = [string]::Empty

    DiscordAuthor([string]$name)
    {
        if ([string]::IsNullOrEmpty($name))
        {
            Write-Error "Please provide a name!"
        }
        else
        {            
            $this.name = $name
        }
    }

    DiscordAuthor([string]$name, [string]$icon_url)
    {
        if ([string]::IsNullOrEmpty($name))
        {
            Write-Error "Please provide a name and icon url"
        }
        else
        {
            $this.name       = $name
            $this.'icon_url' = $icon_url
        }
    }
}
