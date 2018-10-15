#Default config creation/update
Invoke-PsDsHook -CreateConfig -WebhookUrl 'http://hookurl.com' -Verbose

#Example of creating another named configuration
Invoke-PsDsHook -CreateConfig -WebhookUrl 'http://hookurl.com' -ConfigName 'config2' -Verbose
