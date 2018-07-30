function Get-EmbedColor {
    [cmdletbinding()]
    param(
        [Parameter(
            Mandatory
        )]
        [string]
        $Color
    )

    $embedColor = $null

    switch ($Color) {

        'blue' {

            $embedColor = '4886754'        
        }

        'red' {

            $embedColor = '13632027'

        }

        'orange' {

            $embedColor = '16098851'

        }

        'yellow' {

            $embedColor = '16312092'

        }

        'brown' {

            $embedColor = '9131818'

        }

        'lightGreen' {

            $embedColor = '8311585'

        }

        'green' {

            $embedColor = '4289797'

        }
        
        'pink' {

            $embedColor = '12390624'

        }

        'purple' {

            $embedColor = '9442302'

        }

        'black' {

            $embedColor = '1'
        }

        'white' {

            $embedColor = '16777215'

        }

        'gray' {

            $embedColor = '10197915'

        }

        default {

            $embedColor = '1'

        }      
    }

    return $embedColor
    
}