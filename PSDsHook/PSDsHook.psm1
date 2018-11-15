#Setup default paths for module in user home dir

$script:seperator = [io.path]::DirectorySeparatorChar

switch ($PSVersionTable.PSEdition) {

    'Desktop' {

        $userDir = $env:USERPROFILE

    }

    'Core' {

        switch ($PSVersionTable.Platform) {

            'Win32NT' {
        
                $userDir = $env:USERPROFILE
        
            }
        
            'Unix' {
        
                $userDir = $env:HOME
        
            }
        }
    }
}

$script:defaultPsDsDir = (Join-Path -Path $userDir -ChildPath '.psdshook')
$script:configDir      = "$($defaultPsDsDir)$($seperator)configs"
