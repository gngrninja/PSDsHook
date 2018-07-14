#your hook URL
$hookUri   = 'https://discordapp.com/api/webhooks/422145668971495434/WcmAg7f1NOqKJ6I7FgJRJ5mofj1i3ZqW5tRduWZfQ1VQTvJHz3XPHiOywKEiClrFhhp9'

#path to the file you want to upload
$filePath  = '/Users/Ninja/Documents/users.csv'

#get the name of the file, including extension
$fileName  = Split-Path $filePath -Leaf

#get the title of the file (name minus extension)
$fileTitle = $fileName.Substring(0,$fileName.LastIndexOf('.')) 

#create new multipart content form
$multipartContent = [System.Net.Http.MultipartFormDataContent]::new()

#create file stream based on file contents
$FileStream = [System.IO.FileStream]::new($filePath, [System.IO.FileMode]::Open)

#create the headers we need for this form
$fileHeader = [System.Net.Http.Headers.ContentDispositionHeaderValue]::new("form-data")

#add file information
$fileHeader.Name                        = $fileTitle
$fileHeader.FileName                    = $fileName
$fileContent                            = [System.Net.Http.StreamContent]::new($FileStream)
$fileContent.Headers.ContentDisposition = $fileHeader
$fileContent.Headers.ContentType        = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse("text/plain")

#add form information to the multipart form object we created
$multipartContent.Add($fileContent)

#finally, send if all over to Discord
Invoke-WebRequest -Uri $hookUri -Body $multipartContent -Method Post