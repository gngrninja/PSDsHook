function Invoke-PsDsHook {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory,
            ParameterSetName = 'embed'
        )]
        [string]
        $Content,

        [Parameter(
            ParameterSetName = 'embed'
        )]
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
        $DefaultColor,

        [Parameter(
            Mandatory = $true,
            ParameterSetName = 'file'
        )]
        [string]
        $FilePath
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

    $config      = (Get-Content -Path $configPath | ConvertFrom-Json)
    $hookUrl     = $config.'hook_url'
    $avatarUrl   = 'https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5939e82c3e00beb37d5bc3af/1496967218880/?format=1000w'
    $userName    = "Ninja Hook"
    $contentType = 'application/json'

    #Import functions
    $functions = Get-ChildItem -Path "$PSScriptRoot\functions"                    |
                    Where-Object {!$_.PSIsContainer -and $_.Extension -eq '.ps1'} |
                    Select-Object -ExpandProperty FullName
    # dot source functions from functions folder
    if ($functions) {

        foreach ($function in $functions) {

            Write-Verbose "Importing [$function]"
            . $function

        }
    }

    #Import classes
    $classes = Get-ChildItem -Path "$PSScriptRoot\Classes\*.ps1"
    foreach ($class in $classes) {
        try {

            . $class.FullName
            Write-Verbose "Imported [$($class.FullName)]!"

        }
        catch {

            Write-Error "Unable to import [$($class.FullName)] -> [$($_.Exception.Message)]!"

        }
    }

    #Create array of hook properties
    $possibleHookProperties = [PSCustomObject]@{

        avatar_url = $avatarUrl
        username   = $userName

    }

    switch ($PSCmdlet.ParameterSetName) {

        'embed' {

            if (!$Color) {

                $Color = $config.'default_color'

            }

            [System.Collections.ArrayList]$embedArray = @()

            $embedArray.Add($(Get-EmbedFormat -Title $Title -Content $Content -Color $Color)) | Out-Null

            $hookObject = [PSCustomObject]@{

                embeds = $embedArray

            }

            foreach ($property in $possibleHookProperties.PsObject.Properties) {

                if ($property.Value) {

                    $hookObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value

                }

            }

            $result = Invoke-RestMethod -Uri $hookUrl -Body ($hookObject | ConvertTo-Json -Depth 4) -ContentType $contentType -Method Post

            Write-Verbose "Sending:"
            Write-Verbose ""
            Write-Verbose ($hookObject | ConvertTo-Json -Depth 4)
        }

        'file' {

            $fileInfo   = [DiscordFile]::New($FilePath)
            $hookObject = $fileInfo.Content

            #If it is a file, we don't want to include the ContentType parameter as it is included in the body
            $result = Invoke-RestMethod -Uri $hookUrl -Body $hookObject -Method Post

            Write-Verbose "Sending:"
            Write-Verbose ""
            Write-Verbose ($hookObject | Out-String)

        }
    }
}