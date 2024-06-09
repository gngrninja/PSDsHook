InModuleScope PsDsHook {
    Describe 'Invoke-PayloadBuilder' {  
        BeforeAll {
            $dirSeparator = [IO.Path]::DirectorySeparatorChar

            Mock 'Invoke-RestMethod' {}            
            $fileName = 'test.file'            
            $testFile = "$PSScriptRoot..$($dirSeparator)..$($dirSeparator)..$($dirSeparator)..$($dirSeparator)artifacts$($dirSeparator)$fileName"               
        }      


        It 'Handles embeds properly' {

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

            $payload              | Should -Not -Be $null
            $payload.embeds.Count | Should -Be 2
            $payload.embeds[0]    | Should -Not -Be null
            $payload.embeds[1]    | Should -Not -Be null

        }

        it 'Handles files properly' {



            $fileInfo = [DiscordFile]::New($testFile)            
            $fileInfo.Stream.Dispose()

            $payload  = Invoke-PayloadBuilder -PayloadObject $testFile

            $payload
            $payload.ToString() | Should -Be $fileInfo.ToString()

        }

        it 'Handles strings properly' {

            $testPayload = "this is a test for the payload builder"

            $payload = Invoke-PayloadBuilder -PayloadObject $testPayload

            $payload.content | Should -Be ($testPayload | Out-String)

        }
    }
}