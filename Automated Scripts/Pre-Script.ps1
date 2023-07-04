."D:\PMI_CRT\AutomatedProcedures\PowershellScripts\PreScriptConfiguration.ps1"

	$InnovatorUrl =  $InnovatorPageUrl
	$DatabaseName = $DBName
	$DatabaseUser = $DBUser
	$DatabasePassword = $Password
	$PathToIomDll = $PathToIDll
	$folderPath = $readingFolderPath
	
	$LogFolder = "D:\Log"
	$LogFileName = "Log_$(Get-Date -Format 'yyyyMMdd').log"
	$Global:LogFile = Join-Path -Path $LogFolder -ChildPath $LogFileName

	# Function to write log entries
function Write-Log {
	param (
		[string]$Message
	)
		$TimeStamp = (Get-Date).ToString("yyyy/MM/dd HH:mm:ss")
		$LogEntry = "$TimeStamp $Message"
		$LogEntry | Out-File -Append -FilePath $Global:LogFile
	}
		
function Write-ErrorLog {
    
	$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "$timestamp File: $folderPath\$file : $ErrorMessage"
    Add-Content -Path $LogFile -Value $logMessage
 
}

Write-Log -Message "Custom log entry."


[System.Reflection.Assembly]::LoadFrom($PathToIomDll)

$connection = [Aras.IOM.IomFactory]::CreateHttpServerConnection($InnovatorUrl, $DatabaseName, $DatabaseUser, $DatabasePassword)
$global:files = ""
$global:file = ""
try 
{
	$connection.Login()
	$innovator = New-Object "Aras.IOM.Innovator" -ArgumentList $connection
	$files = Get-ChildItem -Path $folderPath -Recurse -File

	foreach ($file in $files) {
   
    $content = Get-Content -Path $file.FullName
	$result = $innovator.ApplyAML($content)
	Write-Host "File: $($file.FullName) : Success"
	Write-Log -Message "File: $($file.FullName) : Success"
	 
	}	
}
catch
{	
	Write-Host "File: $($file.FullName) : Error - Please check log file"
	$errorMessage = $_.Exception.Message
    Write-ErrorLog -ErrorMessage $errorMessage
	
}
finally {
	Write-Log -Message "Custom log exit."
	$connection.Logout()
}

