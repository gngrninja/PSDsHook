class DiscordImage {    
    [string]$url      = [string]::Empty
    [string]$proxyUrl = [string]::Empty
    [int]$width       = $null
    [int]$height      = $null

    DiscordImage([string]$url)
    {
        if ([string]::IsNullOrEmpty($url))
        {
            Write-Error "Please provide a url!"
        }
        else
        {            
            $this.url = $url
        }
    }

    DiscordImage(   
        [string]$url,         
        [string]$proxyUrl
    )
    {
        if ([string]::IsNullOrEmpty($url) -and [string]::IsNullOrEmpty($proxyUrl))
        {
            Write-Error "Please provide: a url and proxyurl"
        }
        else
        {
            $this.url      = $url
            $this.proxyUrl = $proxyUrl
        }
    }

    DiscordImage(
        [string]$url,         
        [string]$proxyUrl,
        [int]$width, 
        [int]$height
    )
    {
        if (
            [string]::IsNullOrEmpty($url)      -and 
            [string]::IsNullOrEmpty($proxyUrl) -and
            !$width -and !($height)
        )
        {
            Write-Error "Please provide: a url and proxyurl"
        }
        else
        {
            $this.url      = $url
            $this.proxyUrl = $proxyUrl        
            $this.height   = $height
            $this.width    = $width
        }
    }
}
