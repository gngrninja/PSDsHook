using module PSDsHook

#If the module is not in one of the folders listed in ($env:PSModulePath -split "$([IO.Path]::PathSeparator)")
#You must specify the full path to the psm1 file in the above using statement
#Example: using module 'C:\users\thegn\repos\PsDsHook\out\PSDsHook\0.0.1\PSDsHook.psm1'

#Create embed builder object via the [DiscordEmbed] class
$embedBuilder = [DiscordEmbed]::New(
                    'title',
                    'description'
                )

#Add blue color
$embedBuilder.WithColor(
    [DiscordColor]::New(
            'blue'
    )
)

#Finally, call the function that will send the embed to the webhook url via the default configuration file
Invoke-PSDsHook -EmbedObject $embedBuilder -Verbose

#Example of using another configuration file:
# Invoke-PSDsHook -EmbedObject $embedArray -ConfigName 'config2' -Verbose