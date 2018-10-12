class DiscordField {
    
    [string]$name
    [string]$value
    [bool]$inline = $false

    DiscordField([string]$name, [string]$value)
    {
        $this.name  = $name
        $this.value = $value
    }

    DiscordField([string]$name, [string]$value, [bool]$inline)
    {
        $this.name   = $name
        $this.value  = $value
        $this.inline = $inline
    }
}