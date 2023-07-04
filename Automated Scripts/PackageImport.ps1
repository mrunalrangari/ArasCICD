."D:\PMI_CRT\AutomatedProcedures\PowershellScripts\PackageImportConfiguration.ps1"

# Specify the path to the ConsoleUpgrade utility
$consoleUpgradePath = $consoleUpgradeFilePath
# Aras server details
$serverUrl = $InnovatorPageUrl
$databaseName = $dbName

# Aras login credentials
$username = $ArasUser
$password = $ArasPassword

# Path to the MF file to import
$packagePath = $importPackagePath
$directoryName = $importDirectoryName

# Build the command to import the MF file
$command = "& `"$consoleUpgradePath`" import login='$username' password='$password' server='$serverUrl' database='$databaseName' release=rel11.0 mfFile='$packagePath'  dir='$directoryName'"


# Execute the command
Invoke-Expression -Command $command