function Invoke-PsDsHook {
    [cmdletbinding()]
    param(
        [Parameter(
            ParameterSetName = 'embed'
        )]
        [string]
        $Content,

        [Parameter(

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
            Mandatory,
            ParameterSetName = 'createConfig'
        )]
        [string]
        $WebhookUrl,

        [Parameter(
            Mandatory,
            ParameterSetName = 'file'
        )]
        [string]
        $FilePath,

        [Parameter(

        )]
        [string]
        $ConfigName = 'config',

        [Parameter(
            ParameterSetName = 'configList'
        )]
        [switch]
        $ListConfigs,

        [Parameter(
            ParameterSetName = 'embed'
        )]
        $EmbedObject
    )

    $configPath = "$configDir/$ConfigName.json"

    if (!(Test-Path -Path $configPath) -and !$CreateConfig) {

        Write-Error "Unable to access [$configPath]. Please provide a valid configuration name. Use -ListConfigs to list configurations, or -CreateConfig to create one."
        break

    } elseif (!$CreateConfig) {

        #$config      = (Get-Content -Path $configPath | ConvertFrom-Json)
        $config      = [DiscordConfig]::New($configPath)
        $hookUrl     = $config.HookUrl
        if ([string]::IsNullOrEmpty($Color)) {

            Write-Verbose "Did not receive a color, using default -> [$($config.DefaultColor)]"
            $Color = $config.DefaultColor

        }

    }

    switch ($PSCmdlet.ParameterSetName) {

        'embed' {

            $hookObject = [PSCustomObject]@{}
            $possibleHookProperties = $EmbedObject
            foreach ($property in $possibleHookProperties.PsObject.Properties) {

                if ($property.Value) {

                    $hookObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value

                }

            }

            Write-Verbose "Sending:"
            Write-Verbose ""
            Write-Verbose ($hookObject | ConvertTo-Json -Depth 4)

            try {

                Invoke-RestMethod -Uri $hookUrl -Body ($hookObject | ConvertTo-Json -Depth 4) -ContentType $contentType -Method Post

            }
            catch {

                $errorMessage = $_.Exception.Message
                Write-Error "Error executing Discord Webhook -> [$errorMessage]!"

            }
        }

        'file' {

            $fileInfo   = [DiscordFile]::New($FilePath)
            $hookObject = $fileInfo.Content

            Write-Verbose "Sending:"
            Write-Verbose ""
            Write-Verbose ($hookObject | Out-String)

            #If it is a file, we don't want to include the ContentType parameter as it is included in the body
            try {

                Invoke-RestMethod -Uri $hookUrl -Body $hookObject -Method Post

            }
            catch {

                $errorMessage = $_.Exception.Message
                Write-Error "Error executing Discord Webhook -> [$errorMessage]!"

            }
        }

        'createConfig' {

            if ([string]::IsNullOrEmpty($Color)) {

                $Color = 'lightGreen'

            }
            [DiscordConfig]::New($WebhookUrl, $Color, $configPath)

        }
    }
}