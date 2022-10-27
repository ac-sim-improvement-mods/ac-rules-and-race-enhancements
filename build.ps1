$build_dir = "$PSScriptRoot\build"

Copy-Item "$PSScriptRoot\F1Regs.lua" -Destination "$build_dir\apps\lua\F1Regs"
Copy-Item "$PSScriptRoot\manifest.ini" -Destination "$build_dir\apps\lua\F1Regs"
Copy-Item "$PSScriptRoot\settings.ini" -Destination "$build_dir\apps\lua\F1Regs"
Copy-Item "$PSScriptRoot\icon.png" -Destination "$build_dir\apps\lua\F1Regs"
Copy-Item "$PSScriptRoot\assets" -Destination "$build_dir\apps\lua\F1Regs" -Recurse

$folders = Get-ChildItem "$build_dir\content\cars"

foreach ($folder in $folders.name){
$data_dir = "$build_dir\content\cars\$folder\data"
if (!(test-path -PathType container $data_dir)) {
    New-Item $data_dir -ItemType Directory
}

Copy-Item -Path "$PSScriptRoot\script.lua" -Destination "$build_dir\content\cars\$folder\data" -Recurse
}