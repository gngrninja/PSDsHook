function Invoke-PayloadBuilder {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory
        )]
        $PayloadObject
    )    
    process {
        $type = $PayloadObject | 
            Get-Member | 
                Select-Object -ExpandProperty TypeName -Unique    
        switch ($type) {                        
            'DiscordEmbed' {
                [bool]$createArray = $true
                #check if array
                $PayloadObject.PSObject.TypeNames | ForEach-Object {
                    switch ($_) {
                        {$_ -match '^System\.Collections\.Generic\.List.+'} {                            
                            $createArray = $false
                        }

                        'System.Array' {
                            $createArray = $false

                        }
                        'System.Collections.ArrayList' {                            
                            $createArray = $false
                        }
                    }
                }
                if (!$createArray) {
                    $embedArray = New-Object 'System.Collections.Generic.List[PSCustomObject]'
                    $PayloadObject | ForEach-Object {
                        $curObject    = $null
                        $populated    = $null
                        $returnObject = $null

                        $curObject = $_
                        $populated = $curObject.PSObject.Properties |
                            Where-Object {$_.Value} |
                                ForEach-Object {$_.Name} 
                        $returnObject = $curObject | Select-Object -Property $populated

                        $embedArray.Add($returnObject) | Out-Null
                    }    
                    $payload = [PSCustomObject]@{
                        embeds = $embedArray
                    }                                      
                } else {
                    $populated = $PayloadObject.PSObject.Properties |
                        Where-Object {$_.Value} |
                            ForEach-Object {$_.Name} 
                    $embedArray = New-Object 'System.Collections.Generic.List[PSCustomObject]'                    
                    $PayloadObject = $PayloadObject | Select-Object -Property $populated
                    $embedArray.Add($PayloadObject) | Out-Null
                    $payload = [PSCustomObject]@{
                        embeds = $embedArray
                    }                      
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
