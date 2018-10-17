function Invoke-PSDsHook {
    <#
    .SYNOPSIS
    Invoke-PSDsHook
    Use PowerShell classes to make using Discord Webhooks easy and extensible

    .DESCRIPTION
    This function allows you to use Discord Webhooks with embeds, files, and various configuration settings

    .PARAMETER CreateConfig
    If specified, will create a configuration based on other parameter settings (ConfigName and WebhookUrl)

    .PARAMETER WebhookUrl
    If used with CreateConfig, this is the url that will be stored in the configuration file.
    If used with an embed or file, this URL will be used in the webhook call.

    .PARAMETER ConfigName
    Specified a name for the configuration file. 
    Can be used when creating a configuration file, as well as when passing embeds/files.

    .PARAMETER ListConfigs
    Lists configuration files

    .PARAMETER EmbedObject
    Accepts an array of [EmbedObject]'s to pass in the webhook call.

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

    using module PSDsHook

    If the module is not in one of the folders listed in ($env:PSModulePath -split "$([IO.Path]::PathSeparator)")
    You must specify the full path to the psm1 file in the above using statement
    Example: using module 'C:\users\thegn\repos\PsDsHook\out\PSDsHook\0.0.1\PSDsHook.psm1'

    Create array of hook properties
    [System.Collections.ArrayList]$embedArray = @()

    Create embed builder object via the [DiscordEmbed] class
    $embedBuilder = [DiscordEmbed]::New(
                        'title',
                        'description'
                    )

    Add blue color
    $embedBuilder.WithColor(
        [DiscordColor]::New(
                'blue'
        )
    )

    Add the embed to the array created above
    $embedArray.Add($embedBuilder) | Out-Null

    Finally, call the function that will send the embed array to the webhook url via the default configuraiton file
    Invoke-PSDsHook -EmbedObject $embedArray -Verbose

    .EXAMPLE
    (Send an webhook with just text)

    Invoke-PSDsHook -HookText 'this is the webhook message' -Verbose
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
        $EmbedObject,

        [Parameter(
            ParameterSetName = 'simple'
        )]
        [string]
        $HookText
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

                    $errorMessage = $_.Exception.Message
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

                    $errorMessage = $_.Exception.Message
                    throw "Error executing Discord Webhook -> [$errorMessage]!"

                }
                finally {

                    $fileInfo.Stream.Dispose()
                    
                }
                
            }

            'simple' {

                $payload = Invoke-PayloadBuilder -PayloadObject $HookText

                Write-Verbose "Sending:"
                Write-Verbose ""
                Write-Verbose ($payload | ConvertTo-Json -Depth 4)

                try {

                    Invoke-RestMethod -Uri $hookUrl -Body ($payload | ConvertTo-Json -Depth 4) -ContentType $contentType -Method Post

                }
                catch {

                    $errorMessage = $_.Exception.Message
                    throw "Error executing Discord Webhook -> [$errorMessage]!"

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