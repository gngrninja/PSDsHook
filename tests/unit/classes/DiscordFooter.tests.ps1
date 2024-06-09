InModuleScope -ModuleName PsDsHook {
    Describe 'DiscordFooter' {
        BeforeAll {
            [string]$text     = "footertext"
            [string]$iconUrl  = 'http://icon/url/image.jpg'
        }
        It 'Accepts only a name if specified' {
            $footer = [DiscordFooter]::New($text)

            $footer.text | Should -Be $text
        }

        It 'Accepts a name and icon url' {
            $footerWIcon = [DiscordFooter]::New($text, $iconUrl)

            $footerWIcon.text       | should -be $text
            $footerWIcon.'icon_url' | should -be $iconUrl            
        }
    }
}
