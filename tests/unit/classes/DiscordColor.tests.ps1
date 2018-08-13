 InModuleScope -ModuleName PsDsHook {

    describe 'DiscordColor' {

        it 'Default constructor works' {

            $defaultValue = [DiscordColor]::New()

            $defaultValue | Should Not Be $null

        }

        it 'Default constructor returns light green as string' {

            $defaultValue = [DiscordColor]::New()

            $defaultValue | Should Be "8311585"

        }

        it 'Properly handles hex colors' {

            $hexColor  = [DiscordColor]::New('0XFF5733')
            $hexColor2 = [DiscordColor]::New(0XFF5733)

            $hexColor.HexColor | Should Be '0xFF5733'
            $hexColor          | Should Be '16734003'

            $hexColor2.HexColor | Should Be '0xFF5733'
            $hexColor2          | Should Be '16734003'

        }

        it 'Handles string color values (blue)' {

            $stringColor = [DiscordColor]::New('blue')
            
            $stringColor | Should Be '4886754'

        }

        it 'Handles decimal color values as int' {

            $decimalColor = [DiscordColor]::New(4886754)

            $decimalColor | Should Be '4886754'

        }

        it 'Handles RGB color values' {

            $rgbColor = [DiscordColor]::New(255,0,255)

            $rgbColor.HexColor | Should Be '0xFF00FF'
            $rgbColor          | Should Be '16711935'

        }
    }
}