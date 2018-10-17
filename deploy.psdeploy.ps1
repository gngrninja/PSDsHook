$projectRoot = $ENV:BHProjectPath

if(-not $projectRoot) {

    $projectRoot = $PSScriptRoot

}

$outputDir    = Join-Path -Path $projectRoot -ChildPath 'out'
$outputModDir = Join-Path -Path $outputDir -ChildPath $env:BHProjectName

if(
    $env:BHModulePath -and
    $env:BHBuildSystem -ne 'Unknown' -and
    $env:BHBranchName -eq "master" -and
    $env:BHCommitMessage -match '!deploy'
)
{
    Deploy Module {
        By PSGalleryModule {
            FromSource $ENV:BHModulePath
            To PSGallery
            WithOptions @{
                ApiKey = $ENV:NugetApiKey
            }
        }
    }
}
else
{
    "Skipping deployment: To deploy, ensure that...`n" +
    "`t* You are in a known build system (Current: $ENV:BHBuildSystem)`n" +
    "`t* You are committing to the master branch (Current: $ENV:BHBranchName) `n" +    
    "`t* Your commit message includes !deploy (Current: $ENV:BHCommitMessage) ($ENV:snowflake)`n" + 
    "`t* Diag info (module path) -> (Current: $outputModDir) `n" |
        Write-Host
}