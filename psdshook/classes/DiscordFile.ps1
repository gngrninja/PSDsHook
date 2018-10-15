class DiscordFile {

    [string]$FilePath                                  = [string]::Empty
    [string]$FileName                                  = [string]::Empty
    [string]$FileTitle                                 = [string]::Empty
    [System.Net.Http.MultipartFormDataContent]$Content = [System.Net.Http.MultipartFormDataContent]::new()
    [System.IO.FileStream]$Stream                      = $null

    DiscordFile([string]$FilePath)
    {
        $this.FilePath  = $FilePath
        $this.FileName  = Split-Path $filePath -Leaf
        $this.fileTitle = $this.FileName.Substring(0,$this.FileName.LastIndexOf('.'))
        $fileContent = $this.GetFileContent($FilePath)
        $this.Content.Add($fileContent)                 
    }

    [System.Net.Http.StreamContent]GetFileContent($filePath)
    {        
        $fileStream                             = [System.IO.FileStream]::new($filePath, [System.IO.FileMode]::Open)
        $fileHeader                             = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")
        $fileHeader.Name                        = $this.fileTitle
        $fileHeader.FileName                    = $this.FileName
        $fileContent                            = [System.Net.Http.StreamContent]::new($fileStream)        
        $fileContent.Headers.ContentDisposition = $fileHeader
        $fileContent.Headers.ContentType        = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse("text/plain")   
                        
        $this.stream = $fileStream
        return $fileContent        
    }    
}