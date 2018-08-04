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
            $embedWithThumb.thumbnail.url | Should Be $thumbUrl

        }
    }
}