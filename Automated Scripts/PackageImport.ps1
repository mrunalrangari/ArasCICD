$configFile = "D:\Projects\PMI\Configuration Files\PackageImportConfiguration.xml"
$xml = [xml](Get-Content $configFile)
$sg_consoleUpgradePath = $xml.config.sg_consoleUpgradeFilePath
$sg_serverUrl = $xml.config.sg_innovatorPageUrl
$sg_databaseName = $xml.config.sg_dbName
$sg_username = $xml.config.sg_arasUser
$sg_password = $xml.config.sg_arasPassword
$sg_packagePath = $xml.config.sg_importPackagePath
$sg_directoryName = $xml.config.sg_importDirectoryName

# Build the command to import the MF file
$sg_command = "& `"$sg_consoleUpgradePath`" import login='$sg_username' password='$sg_password' server='$sg_serverUrl' database='$sg_databaseName' release=rel11.0 mfFile='$sg_packagePath'  dir='$sg_directoryName'"


# Execute the command
Invoke-Expression -Command $sg_command