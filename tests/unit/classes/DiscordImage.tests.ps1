InModuleScope -ModuleName PsDsHook {

    [string]$url      = 'http://url/to/thumb.jpg'
    [string]$proxyUrl = 'http://proxy/url.jpg'
    [int]$width       = 50
    [int]$height      = 25

    describe 'DiscordImage' {

        it 'Accepts only a url if specified' {

            $image = [DiscordImage]::New($url)

            $image.url | Should Be $url

        }

        it 'Accepts url and proxy url' {

            $imageWProxy = [DiscordImage]::New($url, $proxyUrl)

            $imageWProxy.url      | should be $url
            $imageWProxy.proxyUrl | should be $proxyUrl
            
        }

        it 'Accepts url, proxy url, width, and height' {

            $imageWProxy = [DiscordImage]::New($url, $proxyUrl, $width, $height)

            $imageWProxy.url      | should be $url
            $imageWProxy.proxyUrl | should be $proxyUrl
            $imageWProxy.width    | should be $width
            $imageWProxy.height   | should be $height
            
        }
    }
}
