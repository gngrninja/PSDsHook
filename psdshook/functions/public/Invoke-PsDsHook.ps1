function Invoke-PSDsHook {
    <#
    .SYNOPSIS
    Invoke-PsDsHook
    Use PowerShell classes to make using Discord Webhooks easy and extensible
    .DESCRIPTION
    This funciton allows you to use Discord Webhooks with embeds, files, and various configuration settings
    .PARAMETER CreateConfig
    If specified, will create a configuration based on other parameter settings (ConfigName and WebhookUrl)

    .EXAMPLE
    (Create a configuration file)
    Configuration files are stored in a sub directory of your user's home directory named .psdshook/configs

    Invoke-PsDsHook -CreateConfig -WebhookUrl "www.hook.com/hook"
    .EXAMPLE
    (Create a configuration file with a non-standard name)
    Configuration files are stored in a sub directory of your user's home directory named .psdshook/configs

    Invoke-PsDsHook -CreateConfig -WebhookUrl "www.hook.com/hook2" -ConfigName 'config2'
    .EXAMPLE
    (Send an embed with the default config)
    

    Invoke-PsDsHook -CreateConfig -WebhookUrl "www.hook.com/hook2" -ConfigName 'config2'
    #>    
    [cmdletbinding()]
    param(
        [Parameter(
            ParameterSetName = 'createDsConfig'
        )]
        [switch]
        $CreateConfig,

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

        #Create full path to the configuration file
        $configPath = "$($configDir)$($seperator)$($ConfigName).json"
                    
        #Ensure we can access the path, and error out if we cannot
        if (!(Test-Path -Path $configPath -ErrorAction SilentlyContinue) -and !$CreateConfig -and !$WebhookUrl) {

            throw "Unable to access [$configPath]. Please provide a valid configuration name. Use -ListConfigs to list configurations, or -CreateConfig to create one."

        } elseif (!$CreateConfig -and $WebhookUrl) {

            $hookUrl = $WebhookUrl

            Write-Verbose "Manual mode enabled..."

        } elseif ((!$CreateConfig -and !$WebhookUrl) -and $configPath) {

            #Get configuration information from the file specified                 
            $config = [DiscordConfig]::New($configPath)                
            $hookUrl = $config.HookUrl             

        }        
    }

    process {
            
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

                $fileInfo = Invoke-PayloadBuilder -PayloadObject $FilePath
                $payload  = $fileInfo.Content

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
                finally {

                    $fileInfo.Stream.Dispose()
                    
                }
                
            }

            'createDsConfig' {
                
                [DiscordConfig]::New($WebhookUrl, $configPath)

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
}