function Invoke-PayloadBuilder {
    [cmdletbinding()]
    param(
        [Parameter(
            ParameterSetName = 'embed'
        )]
        $PayloadObject,

        [Parameter(
            ParameterSetName = 'file'
        )]
        $FilePath
    )
    
    process {

        switch ($PSCmdlet.ParameterSetName) {

            'file' {

                $payload = [DiscordFile]::New($FilePath)

            }

            'embed' {

                $payload = [PSCustomObject]@{}

                $type = $payloadObject | Get-Member | Select-Object -ExpandProperty TypeName -Unique
    
                switch ($type) {
            
                    'DiscordEmbed' {
            
                        $payload | Add-Member -MemberType NoteProperty -Name 'embeds' -Value $payloadObject
            
                    }
                }
            }
        }
    }
    end {

        return $payload

    }

            #$possibleHookProperties = $hookObject

            #foreach ($property in $possibleHookProperties.PsObject.Properties) {

            #    if ($property.Value) {

            #        $hookObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value

            #    }

            #}
}