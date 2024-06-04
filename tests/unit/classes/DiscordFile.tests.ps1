InModuleScope -ModuleName PsDsHook {
    Describe 'DiscordFile' {   
        BeforeAll {
            $dirSeparator = [IO.Path]::DirectorySeparatorChar
            $fileName     = 'test.file'
            $testFile     = "$PSScriptRoot$($dirSeparator)..$($dirSeparator)..$($dirSeparator)artifacts$($dirSeparator)$fileName"
        }
        It 'Should be able to add a file' {
            $file = [DiscordFile]::New($testFile)

            $file.FilePath  | Should -Be $testFile
            $file.FileName  | Should -Be $fileName
            $file.FileTitle | Should -Be $fileName.Substring(0,$fileName.LastIndexOf('.'))   
            $file.Content   | Should -Not -Be $null         

            $file.Stream.Dispose()
        }
    }
}