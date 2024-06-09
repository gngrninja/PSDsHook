InModuleScope -ModuleName PsDsHook {
    describe 'DiscordField' {
        BeforeAll {
            [string]$name  = 'FieldName'
            [string]$value = 'FieldValue'
            [bool]$inLine  = $true
        }
        It 'Returns a field object with only a name a value passed in' {
            $field = [DiscordField]::New($name, $value)

            $field        | Should -Not -Be Null
            $field.name   | Should -Be $name
            $field.value  | Should -Be $value
            $field.inline | Should -Be $false
        }
        
        It 'Returns an inline field if specified as true' {
            $field = [DiscordField]::New($name, $value, $inLine)

            $field        | Should -Not -Be Null
            $field.name   | Should -Be $name
            $field.value  | Should -Be $value
            $field.inline | Should -Be $true
        }
    }
}