class DiscordConfig {

    [string]$HookUrl    = [string]::Empty
    [int]$DefaultColor  = 0

    DiscordConfig([string]$configPath)
    {               
        $settings = $this.ImportConfig($configPath)    
    }

    DiscordConfig([string]$url, $color, [string]$path)
    {
        $this.HookUrl      = $url
        $this.DefaultColor = [DiscordColor]::New($color).DecimalColor        
        $this.ExportConfig($path)
    }

    [void]ExportConfig([string]$path)
    {
        Write-Verbose "Exporting configuration information to -> [$path]"

        $folderPath = Split-Path -Path $path

        if (!(Test-Path -Path $folderPath))
        {
            Write-Verbose "Creating folder -> [$folderPath]"
            New-Item -ItemType Directory -Path $folderPath            
        }

        $this | ConvertTo-Json | Out-File -FilePath $path
    }

    [void]ImportConfig([string]$configPath)
    {    
        Write-Verbose "Importing configuration from -> [$configPath]"

        $configSettings = Get-Content -Path $configPath -ErrorAction Stop | ConvertFrom-Json

        $this.HookUrl = $configSettings.HookUrl

        if ($configSettings.DefaultColor) 
        {
            $this.DefaultColor = [DiscordColor]::New($configSettings.DefaultColor).DecimalColor
        }     
    }
}
