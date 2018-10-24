InModuleScope -ModuleName PsDsHook {

    [string]$name     = "author"
    [string]$iconUrl  = 'http://icon/url/image.jpg'

    describe 'DiscordAuthor' {

        it 'Accepts only a name if specified' {

            $author = [DiscordAuthor]::New($name)

            $author.name | Should Be $name

        }

        it 'Accepts a name and icon url' {

            $authorWIcon = [DiscordAuthor]::New($name, $iconUrl)

            $authorWIcon.name       | should be $name
            $authorWIcon.'icon_url' | should be $iconUrl
            
        }
    }
}
