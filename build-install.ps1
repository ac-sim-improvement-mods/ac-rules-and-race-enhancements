& "$PSScriptRoot\build.ps1"

$ac_dir = "C:\Program Files (x86)\Steam\steamapps\common\assettocorsa"

Copy-Item "$PSScriptRoot\assettocorsa\" -Destination $ac_dir -Recurse -Force