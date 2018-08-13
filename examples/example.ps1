using module /Users/ninja/Documents/repos/discordWebHook/psdshook.psm1
#/Users/ninja/Documents/repos/discordWebHook/PsDsHook.psm1
#Create array of hook properties
Import-Module /Users/ninja/Documents/repos/discordWebHook/psdshook.psm1 -Force

[System.Collections.ArrayList]$embedArray = @()
$thumbUrl                                 = 'https://static1.squarespace.com/static/5644323de4b07810c0b6db7b/t/5aa44874e4966bde3633b69c/1520715914043/webhook_resized.png'
$embedBuilder                             = [DiscordEmbed]::New('title','description')

$embedBuilder.AddField(
    [DiscordField]::New(
        'field name', 
        'field value/contents', 
        $true
    )
)

$embedBuilder.AddField(
    [DiscordField]::New(
        'field name2',
        'field value2/contents2', 
        $true
    )
)

$embedBuilder.AddThumbnail(
    [DiscordThumbnail]::New(
        $thumbUrl
    )
)

$embedArray.Add($embedBuilder) | Out-Null
$embedArray.Add($embedBuilder) | Out-Null
Invoke-PsDsHook -EmbedObject $embedArray -Verbose

<# Don't use for now
$possibleHookProperties = [PSCustomObject]@{

    avatar_url = $avatarUrl
    username   = $userName

}
#>