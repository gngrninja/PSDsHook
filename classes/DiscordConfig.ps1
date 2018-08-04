class DiscordConfig {

    [string]$HookUrl    = [string]::Empty
    [int]$DefaultColor  = $null

    DiscordConfig([string]$configPath)
    {
        $this.ImportConfig($configPath)
    }

    DiscordConfig([string]$url, $color, [string]$path)
    {
        $this.HookUrl      = $url
        $this.DefaultColor = [DiscordColor]::New($color).DecimalColor

        $this.ExportConfig($path)
    }

    [void] ExportConfig([string]$path)
    {
        Write-Verbose "Exporting configuration information to -> [$path]"

        $folderPath = Split-Path $path
        if (!(Test-Path -Path $folderPath))
        {
            Write-Verbose "Creating folder -> [$folderPath]"
            New-Item -ItemType Directory -Path $folderPath            
        }

        $this | ConvertTo-Json | Out-File -FilePath $path
    }

    [void] ImportConfig([string]$path)
    {
        Write-Verbose "Importing configuration from -> [$path]"

        $config            = Get-Content -Path $path | ConvertFrom-Json

        $this.HookUrl      = $config.HookUrl
        $this.DefaultColor = $config.DefaultColor
    }
}