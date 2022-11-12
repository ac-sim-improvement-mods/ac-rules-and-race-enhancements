& "$PSScriptRoot\build.ps1"

$ac_dir = "E:\Games\Steam\steamapps\common\"

Copy-Item "$PSScriptRoot\assettocorsa\" -Destination $ac_dir -Recurse -Force