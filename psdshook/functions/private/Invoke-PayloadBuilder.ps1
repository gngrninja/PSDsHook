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

                $payload = [DiscordFile]::New($payloadObject)

            }
        }
    }
    
    end {

        return $payload

    }
}
