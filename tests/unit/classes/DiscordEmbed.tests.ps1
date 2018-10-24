InModuleScope -ModuleName PsDsHook {

    Describe 'DiscordEmbed' {

        $title        = 'embedTitle'
        $description  = 'embedDescription'
        $testField    = [DiscordField]::New('FieldName','FieldValue')
        $embedBuilder = [DiscordEmbed]::New($title, $description)

        it 'Should accept a title and description' {
            
            $embedBuilder             | Should Not Be $null
            $embedBuilder.title       | Should Be $title
            $embedBuilder.description | Should Be $description

        }

        it 'Should accept a field object' {

            $embedBuilder.AddField($testField)
            
            $embedBuilder.ListFields.Count | Should Be 1

        }

        it 'Should contain a default color' {

            $embedBuilder.color | Should Be '8311585'

        }

        it 'Should accept a color' {

            $color          = [DiscordColor]::New(255, 0, 255)
            $embedWithColor = [DiscordEmbed]::New('test','test',$color)

            $embedWithColor.color | Should Be '16711935'
                        
        }

        it 'Accepts a thumbnail object' {

            $thumbUrl = 'https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5aa44874e4966bde3633b69c/1520715914043/webhook_resized.png'

            $thumbnail      = [DiscordThumbnail]::New($thumbUrl)
            $embedWithThumb = [DiscordEmbed]::New('test','test')

            $embedWithThumb.AddThumbnail($thumbnail)

            $embedWithThumb               | Should Not Be $null
            $embedWithThumb               | Should BeOfType ([DiscordEmbed])
            $embedWithThumb.thumbnail.url | Should Be $thumbUrl

        }

        it 'Accepts an image object' {

            $imageUrl = 'https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5aa44874e4966bde3633b69c/1520715914043/webhook_resized.png'

            $disImage       = [DiscordImage]::New($imageUrl)
            $embedWithImage = [DiscordEmbed]::New('test','test')

            $embedWithImage.AddImage($disImage)

            $embedWithImage           | Should Not Be $null
            $embedWithImage           | Should BeOfType ([DiscordEmbed])
            $embedWithImage.image.url | Should Be $imageUrl

        }

        it 'Accepts an author object' {

            $name = "author"
            
            $disAuthor       = [DiscordAuthor]::New($name)
            $embedWithAuthor = [DiscordEmbed]::New('test','test')

            $embedWithAuthor.AddAuthor($disAuthor)

            $embedWithAuthor             | Should Not Be $null
            $embedWithAuthor             | Should BeOfType ([DiscordEmbed])
            $embedWithAuthor.author.name | Should Be $name

        }

        it 'Accepts a footer object' {

            $text = "footer"
            
            $disFooter       = [DiscordFooter]::New($text)
            $embedWithFooter = [DiscordEmbed]::New('test','test')

            $embedWithFooter.AddFooter($disFooter)

            $embedWithFooter             | Should Not Be $null
            $embedWithFooter             | Should BeOfType ([DiscordEmbed])
            $embedWithFooter.footer.text | Should Be $text

        }
    }
}