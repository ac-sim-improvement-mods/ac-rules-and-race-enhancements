$build_dir = "$PSScriptRoot\build"

Copy-Item "$PSScriptRoot\F1Regs.lua" -Destination "$build_dir\apps\lua\F1Regs" -Force
Copy-Item "$PSScriptRoot\manifest.ini" -Destination "$build_dir\apps\lua\F1Regs" -Force
Copy-Item "$PSScriptRoot\settings.ini" -Destination "$build_dir\apps\lua\F1Regs" -Force
Copy-Item "$PSScriptRoot\icon.png" -Destination "$build_dir\apps\lua\F1Regs" -Force
Copy-Item "$PSScriptRoot\assets" -Destination "$build_dir\apps\lua\F1Regs" -Recurse -Force
Copy-Item "$PSScriptRoot\data" -Destination "$build_dir\apps\lua\F1Regs" -Recurse -Force