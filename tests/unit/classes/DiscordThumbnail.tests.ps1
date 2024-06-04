InModuleScope -ModuleName PsDsHook {
    Describe 'DiscordThumbnail' {
        BeforeAll {
            [string]$url  = 'http://url/to/thumb.jpg'
            [int]$width   = 50
            [int]$height  = 25
        }        
        It 'Accepts only a url if specified' {
            $thumb = [DiscordThumbnail]::New($url)

            $thumb.url | Should -Be $url
        }

        It 'Accepts a width and height' {
            $thumbWithStats = [DiscordThumbNail]::New($width, $height, $url)

            $thumbWithStats        | Should -Not -Be $null
            $thumbWithStats.url    | Should -Be $url
            $thumbWithStats.width  | Should -Be 50
            $thumbWithStats.height | Should -Be 25            
        }
    }
}