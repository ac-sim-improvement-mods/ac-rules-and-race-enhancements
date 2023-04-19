$app_dir = "$PSScriptRoot\RARE"
$ac_app_dir = "E:\Games\Steam\steamapps\common\assettocorsa\apps\lua"

Copy-Item $app_dir -Destination $ac_app_dir -Recurse -Force