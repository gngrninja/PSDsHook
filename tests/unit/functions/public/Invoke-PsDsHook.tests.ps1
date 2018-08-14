InModuleScope PsDsHook {

    describe 'Invoke-PsDsHook' {

        mock 'Invoke-RestMethod' {

            $mockResult = [PSCustomObject]@{

                Uri     = $Uri
                Payload = $Body

            }

            return $mockResult
            
        }

        $mockParams = @{

            CommandName = 'Invoke-RestMethod'
            Times       = 1
            Exactly     = $true                

        }

        $name           = 'testConfig'
        $configFullPath = "$configDir\$name.json"
        $testHookUrl    = 'www.hook.com'

        it 'Should be able to create a configuration file' {
                                                
            Invoke-PsDsHook -CreateConfig -ConfigName $name -Color 'blue' -WebhookUrl $testHookUrl

            (Test-Path -Path $configFullPath) | Should Be $true

        }

        it 'Should be able to receive an embed array' {

            [System.Collections.ArrayList]$embedArray = @()            
            $embedBuilder = [DiscordEmbed]::New('test title', 'test content')

            $embedArray.Add($embedBuilder) | Out-Null

            $result = Invoke-PsDsHook -EmbedObject $embedArray -ConfigName $name        
            
            Assert-MockCalled @mockParams
            
            $payload = [PSCustomObject]@{

                embeds = $embedArray

            } | ConvertTo-Json -Depth 4

            $result.Uri     | Should Be $testHookUrl
            $result.Payload | Should Be $payload 

        }

        it 'Should be able to receive a file path' {

            $filePath = Get-ChildItem "$PSScriptRoot\..\..\..\artifacts\test.file"            
            $result   = Invoke-PsDsHook -FilePath $filePath -ConfigName $name

            $result.Uri     | Should Be $testHookUrl
            $result.Payload | Should Be 'System.Net.Http.StreamContent'

        }

        it 'Should list configurations' {

            $list           = (Get-ChildItem -Path (Split-Path -Path $configFullPath) | Where-Object {$_.Extension -eq '.json'} | Select-Object -ExpandProperty Name)
            $listFromModule = Invoke-PsDsHook -ListConfigs

            $list | Should Be $listFromModule

        }

        if (Test-Path -Path $configFullPath) {

            Remove-Item -Path $configFullPath -Force
            
        }
    }
}