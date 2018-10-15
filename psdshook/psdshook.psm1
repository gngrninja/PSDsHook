#Setup default paths for module in user home dir

$seperator = [io.path]::DirectorySeparatorChar

switch ($PSVersionTable.Platform) {
    'Win32NT' {

        $userDir = $env:USERPROFILE

    }

    'Unix' {

        $userDir = $env:HOME

    }
}

$script:defaultPsDsDir = (Join-Path -Path $userDir -ChildPath '.psdshook')
$script:configDir      = "$($defaultPsDsDir)$($seperator)configs"
