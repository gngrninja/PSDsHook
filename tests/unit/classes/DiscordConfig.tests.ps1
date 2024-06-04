InModuleScope PsDsHook {
    Describe 'DiscordConfig' {
        BeforeAll {
            $configPath = "$PSScriptRoot\..\..\artifacts\config.json"
            $hookUrl    = 'http://www.somehook.com/data/things/aabbccddEEffggHH'
        }
        It 'Creates configuration file with hook url'  {                                               
            $config = [DiscordConfig]::New($hookUrl, $configPath) 

            $config                | Should -Not -Be $null    
            (Test-Path $configPath | Should -Be True)    
            $config.HookUrl        | Should -Be $hookUrl            
        }

        It 'Imports configuration file successfully' {                         
            $importedConfig = [DiscordConfig]::New($configPath)

            $importedConfig         | Should -Not -BeNullOrEmpty
            $importedConfig.HookUrl | Should -Be $hookUrl            
        }
        #Clean up
        if ($configPath) {
            Remove-Item -Path $configPath -Force
        }
    }
}