function Invoke-PsDsHook {
    [cmdletbinding()]
    param(
        [Parameter(
            ParameterSetName = 'createConfig'
        )]
        [switch]
        $CreateConfig,

        [Parameter(

        )]
        [string]
        $Color,

        [Parameter(
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

    begin {
        try {
            #Create full path to the configuration file
            $configPath = "$configDir/$ConfigName.json"

            #Ensure we can access the path, and error out if we cannot
            if (!(Test-Path -Path $configPath -ErrorAction SilentlyContinue) -and !$CreateConfig -and !$WebhookUrl) {

                throw "Unable to access [$configPath]. Please provide a valid configuration name. Use -ListConfigs to list configurations, or -CreateConfig to create one."

            } elseif (!$CreateConfig -and $WebhookUrl) {

                $hookUrl = $WebhookUrl

                if (!$Color) {

                    $Color = [DiscordColor]::New().ToString()

                }
            
            } elseif (!$CreateConfig) {
                #Get configuration information from the file specified
                $config  = [DiscordConfig]::New($configPath)
                $hookUrl = $config.HookUrl

                if ([string]::IsNullOrEmpty($Color)) {

                    Write-Verbose "Did not receive a color, using default -> [$($config.DefaultColor)]"
                    $Color = $config.DefaultColor

                }
            }
        }
        catch {

            $PSCmdlet.ThrowTerminatingError($PSitem)

        }
    }

    process {
        try {
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
        
                        $errorMessage = $PSitem.Exception.Message
                        throw "Error executing Discord Webhook -> [$errorMessage]!"
        
                    }
                }
        
                'file' {
        
                    $payload = (Invoke-PayloadBuilder -PayloadObject $FilePath).Content
        
                    Write-Verbose "Sending:"
                    Write-Verbose ""
                    Write-Verbose ($payload | Out-String)
        
                    #If it is a file, we don't want to include the ContentType parameter as it is included in the body
                    try {
        
                        Invoke-RestMethod -Uri $hookUrl -Body $payload -Method Post
        
                    }
                    catch {
        
                        $errorMessage = $PSitem.Exception.Message
                        throw "Error executing Discord Webhook -> [$errorMessage]!"
        
                    }
                }
        
                'createConfig' {
        
                    if ([string]::IsNullOrEmpty($Color)) {
        
                        $Color = 'lightGreen'
        
                    }
        
                    [DiscordConfig]::New($WebhookUrl, $Color, $configPath)
        
                }
        
                'configList' {
        
                    $configs = (Get-ChildItem -Path (Split-Path $configPath) | Where-Object {$PSitem.Extension -eq '.json'} | Select-Object -ExpandProperty Name)
                    if ($configs) {

                        Write-Host "Configuration files in [$configDir]:"
                        return $configs

                    } else {

                        Write-Host "No configuration files found in [$configDir]"

                    }  
                }
            }
        }
        catch {

            $PSCmdlet.ThrowTerminatingError($PSitem)
            
        }
    }
}