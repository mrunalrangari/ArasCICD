#jo bhi powershell scripts run karene he idahr path add karo 
# You can add multiple paths

$Script1Path = "D:\PMI_CRT\AutomatedProcedures\Scripts\Pre-Script.ps1"
$Script2Path = "D:\PMI_CRT\AutomatedProcedures\Scripts\PackageImport.ps1"
$Script3Path = "D:\PMI_CRT\AutomatedProcedures\Scripts\Post-Script.ps1"
$Script4Path = "D:\PMI_CRT\AutomatedProcedures\Scripts\CodeTreeCopy.ps1"

# Run scripts sequentially

& $Script1Path
& $Script2Path
& $Script3Path
& $Script4Path
