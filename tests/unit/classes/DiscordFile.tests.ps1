InModuleScope -ModuleName PsDsHook {
    #Fix file in use error, use artifacts
    $fileName = 'test.file'
    $testFile = "$PSScriptRoot/../../artifacts/test.file"

    describe 'DiscordFile' {   

        it 'Should be able to add a file' {

            $file = [DiscordFile]::New($testFile)

            $file.FilePath  | Should Be $testFile
            $file.FileName  | Should Be $fileName
            $file.FileTitle | Should Be $fileName.Substring(0,$fileName.LastIndexOf('.'))   
            $file.Content   | Should Not Be $null         

            $file.Stream.Dispose()
        }
    }
}