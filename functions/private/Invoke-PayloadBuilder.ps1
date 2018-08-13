function Invoke-PayloadBuilder {
    [cmdletbinding()]
    param(
        $PayloadObject
    )
    
    $payload = [PSCustomObject]@{}

    $type = $payloadObject | Get-Member | Select-Object -ExpandProperty TypeName -Unique
    
    switch ($type) {

        'DiscordEmbed' {

            $payload | Add-Member -MemberType NoteProperty -Name 'embeds' -Value $payloadObject

        }
    }
            #$possibleHookProperties = $hookObject

            #foreach ($property in $possibleHookProperties.PsObject.Properties) {

            #    if ($property.Value) {

            #        $hookObject | Add-Member -MemberType NoteProperty -Name $property.Name -Value $property.Value

            #    }

            #}
    return $payload
}