Import-Module -Name SqlServer
$SharedFolder = "C:\01_Backup"

$RelocateData = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("OLM12", "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\innovatorsolution12Far.mdf")
$RelocateLog = New-Object Microsoft.SqlServer.Management.Smo.RelocateFile("OLM12_log", "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\innovatorsolution12Far_log.ldf")
Restore-SqlDatabase -ServerInstance "DESKTOP-1HTN4I7" -Database "innovatorsolution12Far" -BackupFile "$($SharedFolder)\20230628.bak" -RelocateFile @($RelocateData,$RelocateLog) -ReplaceDatabase
Write-Host "Database restore completed successfully."