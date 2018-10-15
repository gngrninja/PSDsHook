InModuleScope -ModuleName PsDsHook {

    $configPath = "$PSScriptRoot\..\..\artifacts\config.json"
    $hookUrl    = 'http://www.somehook.com/data/things/aabbccddEEffggHH'
    $color      = 'blue'

    describe 'DiscordConfig' {
        
        it 'Creates configuration file with hook URI and default color' {

            $config = [DiscordConfig]::New($hookUrl, $color, $configPath)

            $config | Should Not Be $null

            (Test-Path $configPath | Should Be True)

            $config.HookUrl      | Should Be $hookUrl
            $config.DefaultColor | Should Be '4886754'

        }

        it 'Imports configuration file successfully' {

            $importedConfig = [DiscordConfig]::New($configPath)

            $importedConfig              | Should Not Be $null
            $importedConfig.HookUrl      | Should Be $hookUrl
            $importedConfig.DefaultColor | Should Be '4886754'

        }
    }

    #Clean up
    if ($configPath) {

         Remove-Item -Path $configPath -Force
    
    }
}
