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

    DiscordImage([int]$width, [int]$height, [string]$url, [string]$proxyUrl)
    {
        if ([string]::IsNullOrEmpty($url))
        {
            Write-Error "Please provide a url!"
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
