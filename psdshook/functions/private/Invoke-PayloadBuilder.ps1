function Invoke-PayloadBuilder {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory
        )]
        $PayloadObject
    )
    
    process {

        $type = $payloadObject | Get-Member | Select-Object -ExpandProperty TypeName -Unique
    
        switch ($type) {

            'DiscordEmbed' {

                $payload = [PSCustomObject]@{

                    embeds = $payloadObject

                }

            }

            'System.String' {

                if (Test-Path $PayloadObject -ErrorAction SilentlyContinue) {

                    $payload = [DiscordFile]::New($payloadObject)

                } else {

                    $payload = [PSCustomObject]@{

                        content = ($PayloadObject | Out-String)

                    }
                }                
            }
        }
    }
    
    end {

        return $payload

    }
}
