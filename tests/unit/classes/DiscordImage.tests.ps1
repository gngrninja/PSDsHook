InModuleScope -ModuleName PsDsHook {
    Describe 'DiscordImage' {
        BeforeAll {
            [string]$url      = 'http://url/to/thumb.jpg'
            [string]$proxyUrl = 'http://proxy/url.jpg'
            [int]$width       = 50
            [int]$height      = 25
        }
        It 'Accepts only a url if specified' {
            $image = [DiscordImage]::New($url)

            $image.url | Should -Be $url
        }

        It 'Accepts url and proxy url' {
            $imageWProxy = [DiscordImage]::New($url, $proxyUrl)

            $imageWProxy.url      | should -Be $url
            $imageWProxy.proxyUrl | should -Be $proxyUrl            
        }

        It 'Accepts url, proxy url, width, and height' {
            $imageWProxy = [DiscordImage]::New($url, $proxyUrl, $width, $height)

            $imageWProxy.url      | Should -Be $url
            $imageWProxy.proxyUrl | Should -Be $proxyUrl
            $imageWProxy.width    | Should -Be $width
            $imageWProxy.height   | Should -Be $height            
        }
    }
}
