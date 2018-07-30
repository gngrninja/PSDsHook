#Import functions
$functions = Get-ChildItem -Path "$PSScriptRoot\functions"                    |
                Where-Object {!$_.PSIsContainer -and $_.Extension -eq '.ps1'} |
                Select-Object -ExpandProperty FullName

#Dot source functions from functions folder
if ($functions) {

    foreach ($function in $functions) {

        Write-Verbose "Importing [$function]"
        . $function

    }
}

$Public  = @( Get-ChildItem -Path "$PSScriptRoot\functions\public\*.ps1" )
$Private = @( Get-ChildItem -Path "$PSScriptRoot\functions\private\*.ps1" )

@($Public + $Private) | ForEach-Object {

    Try {

        . $_.FullName

    } Catch {

        Write-Error -Message "Failed to import function $($_.FullName): $_"
        
    }

}

Export-ModuleMember -Function $Public.BaseName
#End function importing

#Import classes
$classes = Get-ChildItem -Path "$PSScriptRoot\classes\*.ps1"
foreach ($class in $classes) {
    try {

        . $class.FullName
        Write-Verbose "Imported [$($class.FullName)]!"

    }
    catch {

        Write-Error "Unable to import [$($class.FullName)] -> [$($_.Exception.Message)]!"

    }
}

$configDir  = "$PSScriptRoot/configs"