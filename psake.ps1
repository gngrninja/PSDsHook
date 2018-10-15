properties {
    $projectRoot = $ENV:BHProjectPath
    if(-not $projectRoot) {

        $projectRoot = $PSScriptRoot

    }

    $sut             = $env:BHModulePath
    $tests           = "$projectRoot/tests"
    $outputDir       = Join-Path -Path $projectRoot -ChildPath 'out'
    $outputModDir    = Join-Path -Path $outputDir -ChildPath $env:BHProjectName
    $manifest        = Import-PowerShellDataFile -Path $env:BHPSModuleManifest
    $outputModVerDir = Join-Path -Path $outputModDir -ChildPath $manifest.ModuleVersion
    $psVersion       = $PSVersionTable.PSVersion.Major
    $pathSeperator   = [IO.Path]::PathSeparator
    $dirSeperator    = [IO.Path]::DirectorySeparatorChar

}

task default -depends Test

task Init {
    Write-Host @"
    STATUS: Testing with PowerShell $psVersion
    
    Build System Details:
    
    $($(Get-Item ENV:BH*) | Out-String)
"@    
    
    'Pester', 'PlatyPS', 'PSScriptAnalyzer' | Foreach-Object {
        if (-not (Get-Module -Name $_ -ListAvailable -Verbose:$false -ErrorAction SilentlyContinue)) {
            Install-Module -Name $_ -Repository PSGallery -Scope CurrentUser -AllowClobber -Confirm:$false -ErrorAction Stop
        }
        Import-Module -Name $_ -Verbose:$false -Force -ErrorAction Stop
    }

} -description 'Initialize build environment'

task Test -Depends Init, Analyze, Pester -description 'Run test suite'

task Analyze -Depends Build {
    Write-Host "[$outputModVerDir]"
    $analysis = Invoke-ScriptAnalyzer -Path $outputModVerDir -Verbose:$false -Recurse
    $errors = $analysis | Where-Object {$_.Severity -eq 'Error'}
    $warnings = $analysis | Where-Object {$_.Severity -eq 'Warning'}

    if (($errors.Count -eq 0) -and ($warnings.Count -eq 0)) {
        Write-Host 'PSScriptAnalyzer passed without errors or warnings'
    }

    if (@($errors).Count -gt 0) {
        Write-Error -Message 'One or more Script Analyzer errors were found. Build cannot continue!'
        $errors | Format-Table
    }

    if (@($warnings).Count -gt 0) {
        Write-Warning -Message 'One or more Script Analyzer warnings were found. These should be corrected.'
        $warnings | Format-Table
    }

} -description 'Run PSScriptAnalyzer'

task Compile -depends Clean {
    # Create module output directory
    $modDir = New-Item -Path $outputModDir -ItemType Directory
    New-Item -Path $outputModVerDir -ItemType Directory > $null

    # Append items to psm1
    Write-Verbose -Message 'Creating psm1...'
    $psm1 = Copy-Item -Path (Join-Path -Path $sut -ChildPath 'PSDsHook.psm1') -Destination (Join-Path -Path $outputModVerDir -ChildPath "$($ENV:BHProjectName).psm1") -PassThru

    # This is dumb but oh well :)
    # We need to write out the classes in a particular order
    $classDir = (Join-Path -Path $sut -ChildPath 'Classes')
    @(
        'DiscordColor'      
        'DiscordConfig'          
        'DiscordField'
        'DiscordThumbnail'    
        'DiscordEmbed'
        'DiscordFile'        
    ) | ForEach-Object {

        Get-Content -Path (Join-Path -Path $classDir -ChildPath "$($_).ps1") | Add-Content -Path $psm1 -Encoding UTF8

    }
    
    Get-ChildItem -Path (Join-Path -Path $sut -ChildPath "functions$($dirSeperator)private") -Recurse |
        Get-Content -Raw | Add-Content -Path $psm1 -Encoding UTF8
    Get-ChildItem -Path (Join-Path -Path $sut -ChildPath "functions$($dirSeperator)public") -Recurse |
        Get-Content -Raw | Add-Content -Path $psm1 -Encoding UTF8    

    # Copy over other items
    Copy-Item -Path $env:BHPSModuleManifest -Destination $outputModVerDir    

    Write-Host "Created compiled module at [$modDir]"

} -description 'Compiles module from source'

task Pester -Depends Build {
    Push-Location
    Set-Location -PassThru $outputModDir
    if(-not $ENV:BHProjectPath) {
        Set-BuildEnvironment -Path $PSScriptRoot\..
    }

    $origModulePath = $env:PSModulePath
    if ( $env:PSModulePath.split($pathSeperator) -notcontains $outputDir ) {

        $env:PSModulePath = ($outputDir + $pathSeperator + $origModulePath)

    }

    Remove-Module $ENV:BHProjectName -ErrorAction SilentlyContinue -Verbose:$false
    Import-Module -Name $outputModDir -Force -Verbose:$false

    $testResultsXml = Join-Path -Path $outputDir -ChildPath 'testResults.xml'
    $testResults    = Invoke-Pester -Path $tests -PassThru -OutputFile $testResultsXml -OutputFormat NUnitXml

    #Upload test artifacts to AppVeyor
    if ($env:APPVEYOR_JOB_ID) {
        $wc = New-Object 'System.Net.WebClient'
        $wc.UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", $testResultsXml)
    }

    if ($testResults.FailedCount -gt 0) {

        $testResults | Format-List
        
        Write-Error -Message 'One or more Pester tests failed. Build cannot continue!'
    }

    Pop-Location
    $env:PSModulePath = $origModulePath

} -description 'Run Pester tests'

task CreateMarkdownHelp -Depends Compile {

    #Get functions
    Import-Module -Name $outputModDir -Verbose:$false -Global
    $mdHelpPath = Join-Path -Path $projectRoot -ChildPath 'docs/reference/functions'
    $mdFiles    = New-MarkdownHelp -Module $env:BHProjectName -OutputFolder $mdHelpPath -WithModulePage -Force

    Write-Host \t"Module markdown help created at [$mdHelpPath]"

    @($env:BHProjectName).ForEach({
        Remove-Module -Name $_ -Verbose:$false
    })

} -description 'Create initial markdown help files'

task UpdateMarkdownHelp -Depends Compile {

    #Import-Module -Name $sut -Force -Verbose:$false
    Import-Module -Name $outputModDir -Verbose:$false
    $mdHelpPath = Join-Path -Path $projectRoot -ChildPath 'docs/reference/functions'
    $mdFiles = Update-MarkdownHelpModule -Path $mdHelpPath -Verbose:$false

    Write-Host \t"Markdown help updated at [$mdHelpPath]"

} -description 'Update markdown help files'

task CreateExternalHelp -Depends CreateMarkdownHelp {

    New-ExternalHelp "$projectRoot\docs\reference\functions" -OutputPath "$outputModVerDir\en-US" -Force

} -description 'Create module help from markdown files'

Task RegenerateHelp -Depends UpdateMarkdownHelp, CreateExternalHelp

task Clean -depends Init {

    Remove-Module -Name $env:BHProjectName -Force -ErrorAction SilentlyContinue

    if (Test-Path -Path $outputDir) {
        Get-ChildItem -Path $outputDir -Recurse | Remove-Item -Force -Recurse
    } else {
        New-Item -Path $outputDir -ItemType Directory > $null
    }
    "    Cleaned previous output directory [$outputDir]"

} -description 'Cleans module output directory'


#CreateMarkdownHelp (add back to build)
task Build -depends Compile, CreateMarkdownHelp, CreateExternalHelp {
    # External help
    
    $helpXml = New-ExternalHelp "$projectRoot\docs\reference\functions" -OutputPath (Join-Path -Path $outputModVerDir -ChildPath 'en-US') -Force
    
    Write-Host \t"Module XML help created at [.helpXml]"
}

Task Publish -Depends Test {

    Write-Host \t"Publishing version [$($manifest.ModuleVersion)] to PSGallery..."
    Publish-Module -Path $outputModVerDir -NuGetApiKey $env:PSGALLERY_API_KEY -Repository PSGallery
    
}