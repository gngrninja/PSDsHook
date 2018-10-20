InModuleScope PsDsHook {

    describe 'Invoke-PayloadBuilder' {

        $dirSeperator = [IO.Path]::DirectorySeparatorChar

        mock 'Invoke-RestMethod' {}

        it 'Handles embeds properly' {

            [System.Collections.ArrayList]$embedArray = @()
            $thumbUrl                                 = 'https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5aa44874e4966bde3633b69c/1520715914043/webhook_resized.png'
            $embedBuilder                             = [DiscordEmbed]::New('title','description')

            $embedBuilder.AddField(
                [DiscordField]::New(
                    'field name', 
                    'field value/contents', 
                    $true
                )
            )

            $embedBuilder.AddField(
                [DiscordField]::New(
                    'field name2',
                    'field value2/contents2', 
                    $true
                )
            )

            $embedBuilder.AddThumbnail(
                [DiscordThumbnail]::New(
                    $thumbUrl
                )
            )

            $embedArray.Add($embedBuilder) | Out-Null
            $embedArray.Add($embedBuilder) | Out-Null

            $payload = Invoke-PayloadBuilder -PayloadObject $embedArray

            $payload              | Should Not Be $null
            $payload.embeds.Count | Should Be 2
            $payload.embeds[0]    | Should Be $embedArray[0]
            $payload.embeds[1]    | Should Be $embedArray[1]

        }

        it 'Handles files properly' {

            $fileName = 'test.file'            
            $testFile = "$PSScriptRoot..$($dirSeperator)..$($dirSeperator)..$($dirSeperator)..$($dirSeperator)artifacts$($dirSeperator)$fileName"   

            $fileInfo = [DiscordFile]::New($testFile)            
            $fileInfo.Stream.Dispose()

            $payload  = Invoke-PayloadBuilder -PayloadObject $testFile

            $payload
            $payload.ToString() | Should Be $fileInfo.ToString()

        }
    }
}