function Invoke-PsDsHook {
    [cmdletbinding()]
    param(
        [Parameter(
            ParameterSetName = 'createConfig'
        )]
        [switch]
        $CreateConfig,

        [Parameter(
            ParameterSetName = 'createConfig'
        )]
        [string]
        $Color,

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

    #Create full path to the configuration file
    $configPath = "$configDir/$ConfigName.json"

    #Ensure we can access the path, and error out if we cannot
    if (!(Test-Path -Path $configPath) -and !$CreateConfig) {

        throw "Unable to access [$configPath]. Please provide a valid configuration name. Use -ListConfigs to list configurations, or -CreateConfig to create one."

    } elseif (!$CreateConfig) {

        #Get configuration information from the file specified
        $config      = [DiscordConfig]::New($configPath)
        $hookUrl     = $config.HookUrl
        
        if ([string]::IsNullOrEmpty($Color)) {

            Write-Verbose "Did not receive a color, using default -> [$($config.DefaultColor)]"
            $Color = $config.DefaultColor

        }

    }

    switch ($PSCmdlet.ParameterSetName) {

        'embed' {

            $payload = Invoke-PayloadBuilder -PayloadObject $EmbedObject

            Write-Verbose "Sending:"
            Write-Verbose ""
            Write-Verbose ($payload | ConvertTo-Json -Depth 4)

            try {

                Invoke-RestMethod -Uri $hookUrl -Body ($payload | ConvertTo-Json -Depth 4) -ContentType $contentType -Method Post

            }
            catch {

                $errorMessage = $_.Exception.Message
                Write-Error "Error executing Discord Webhook -> [$errorMessage]!"

            }
        }

        'file' {

            $payload = Invoke-PayloadBuilder -FilePath $FilePath

            Write-Verbose "Sending:"
            Write-Verbose ""
            Write-Verbose ($payload | Out-String)

            #If it is a file, we don't want to include the ContentType parameter as it is included in the body
            try {

                Invoke-RestMethod -Uri $hookUrl -Body $payload -Method Post

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

        'configList' {

            $configs = (Get-ChildItem -Path (Split-Path $configPath) | Where-Object {$_.Extension -eq '.json'} | Select-Object -ExpandProperty Name)
            
            return $configs

        }
    }
}