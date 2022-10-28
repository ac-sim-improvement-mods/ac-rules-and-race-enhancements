& "$PSScriptRoot\_build.ps1"

$build_dir = "$PSScriptRoot\build"
$ac_dir = "E:\Games\Steam\steamapps\common\assettocorsa"

Copy-Item "$build_dir\assettocorsa\apps" -Destination $ac_dir -Recurse -Force
Copy-Item "$build_dir\assettocorsa\extension" -Destination $ac_dir -Recurse -Force