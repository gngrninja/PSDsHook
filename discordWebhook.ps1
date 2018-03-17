[cmdletbinding()]
param(
    [Parameter(
        ParameterSetName = 'embed',
        Mandatory        = $true
    )]
    [string]
    $Content,

    [Parameter(
        ParameterSetName = 'embed'
    )]
    [switch]
    $CreateEmbed,

    [Parameter(
        ParameterSetName = 'embed'
    )]
    [ValidateSet('blue','red','orange','yellow','brown','lightGreen','green','pink','purple','black','white','gray')]
    $Color,

    [Parameter(
        ParameterSetName = 'embed'
    )]
    [string]
    $Title,

    [Parameter(
        ParameterSetName = 'createConfig'
    )]
    [switch]
    $CreateConfig,

    [Parameter(
        Mandatory        = $true,
        ParameterSetName = 'createConfig'
    )]
    [string]
    $HookUrl,
    
    [Parameter(
        Mandatory = $true,
        ParameterSetName = 'createConfig'
    )]
    [ValidateSet('blue','red','orange','yellow','brown','lightGreen','green','pink','purple','black','white','gray')]
    $DefaultColor    
)

$configPath = "$PSScriptRoot/config.json"

if ($CreateConfig) {

    $configContent = [PSCustomObject]@{
        
        'hook_url'      = $HookUrl
        'default_color' = $DefaultColor

    }    

    Write-Verbose "Exporting configuration information to -> [$configPath]"

    $configContent | ConvertTo-Json | Out-File -FilePath $configPath

    break
}


if (!(Test-Path -Path $configPath)) {

    Write-Error "Unabled to access [$configPath]"
    break

}

$config    = (Get-Content -Path $configPath | ConvertFrom-Json)
$hookUrl   = $config.'hook_url'
$avatarUrl = 'https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5939e82c3e00beb37d5bc3af/1496967218880/?format=1000w'
$userName  = "Ninja Hook"
$functions = Get-ChildItem -Path "$PSScriptRoot\functions"                    |  
                Where-Object {!$_.PSIsContainer -and $_.Extension -eq '.ps1'} | 
                Select-Object -ExpandProperty FullName

$possibleHookProperties = [PSCustomObject]@{

    avatar_url = $avatarUrl
    username   = $userName 

}                
# dot source functions from functions folder
if ($functions) {

    foreach ($function in $functions) {

        Write-Verbose "Importing [$function]"
        . $function

    }
}

if ($createEmbed) {

    if (!$Color) {

        $Color = $config.'default_color'

    }

    [System.Collections.ArrayList]$embedArray = @()

    $embedArray.Add($(Get-EmbedFormat -Title $Title -Content $Content -Color $Color)) | Out-Null
    
    $hookObject = [PSCustomObject]@{

        embeds = $embedArray

    }    

} else {

    $hookObject = [PSCustomObject]@{

        content = $content
            
    }

}

foreach ($property in $possibleHookProperties.PsObject.Properties) {

    if ($property.Value) {

        $hookObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value

    }

}

Invoke-RestMethod -Uri $hookUrl -Body ($hookObject | ConvertTo-Json -Depth 3) -ContentType 'application/json' -Method Post