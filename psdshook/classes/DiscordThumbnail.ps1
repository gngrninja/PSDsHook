class DiscordThumbnail {

    [string]$url = [string]::Empty
    [int]$width  = $null
    [int]$height = $null

    DiscordThumbnail([string]$url)
    {
        if ([string]::IsNullOrEmpty($url))
        {
            Write-Error "Please provide a url!"
        }
        else
        {
            #$this.Url = $url
            $this.url = $url

        }
    }

    DiscordThumbnail([int]$width, [int]$height, [string]$url)
    {
        if ([string]::IsNullOrEmpty($url))
        {
            Write-Error "Please provide a url!"
        }
        else
        {

            $this.url    = $url
            $this.height = $height
            $this.width  = $width

        }
    }
}