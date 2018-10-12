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


           #$possibleHookProperties = $hookObject

            #foreach ($property in $possibleHookProperties.PsObject.Properties) {

            #    if ($property.Value) {

            #        $hookObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value

            #    }

            #}