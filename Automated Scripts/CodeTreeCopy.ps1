."D:\PMI_CRT\AutomatedProcedures\PowershellScripts\CopyCodeTreeConfiguration.ps1"

$sourcePath = $pathOfCodeTree
$destinationPath = $destinationServerPath
$username = $serverUser
$password = $serverPassword
$localLogFilePath = $localMachineLogFilePath

$logFilePath = Join-Path -Path $destinationPath -ChildPath "CopyLog.txt"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$sourceMachine = $env:COMPUTERNAME

$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

try {
    # Create a PSDrive using the destination path and provided credentials
    New-PSDrive -Name "Remote" -PSProvider "FileSystem" -Root $destinationPath -Credential $credential

    # Copy the folder from source to destination using Robocopy
    robocopy $sourcePath $destinationPath /MIR /LOG+:$logFilePath /NP /R:1 /W:1 /XD thumbs.db desktop.ini

    Write-Host "Folder copied successfully."
}
catch {
    Write-Host "Error occurred during folder copy: $_"
}
finally {
    # Remove the PSDrive
    Remove-PSDrive -Name "Remote"
}

# Append additional information to the destination log file
"`nCopy details:`nTimestamp: $timestamp`nSource Machine: $sourceMachine`nSource Path: $sourcePath`nDestination Path: $destinationPath" | Out-File -FilePath $logFilePath -Append

# Append additional information to the local log file
"`nCopy details:`nTimestamp: $timestamp`nSource Machine: $sourceMachine`nSource Path: $sourcePath`nDestination Path: $destinationPath" | Out-File -FilePath $localLogFilePath -Append
