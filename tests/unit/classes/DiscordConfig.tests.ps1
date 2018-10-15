InModuleScope -ModuleName PsDsHook {

    $configPath = "$PSScriptRoot\..\..\artifacts\config.json"
    $hookUrl    = 'http://www.somehook.com/data/things/aabbccddEEffggHH'

    describe 'DiscordConfig' {
        
        it 'Creates configuration file with hook URI' {

            $config = [DiscordConfig]::New($hookUrl, $configPath)

            $config | Should Not Be $null

            (Test-Path $configPath | Should Be True)

            $config.HookUrl      | Should Be $hookUrl
        }

        it 'Imports configuration file successfully' {

            $importedConfig = [DiscordConfig]::New($configPath)

            $importedConfig              | Should Not Be $null
            $importedConfig.HookUrl      | Should Be $hookUrl
        }
    }

    #Clean up
    if ($configPath) {

         Remove-Item -Path $configPath -Force
    
    }
}
