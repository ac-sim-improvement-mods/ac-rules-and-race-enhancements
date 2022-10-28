$build_dir = "$PSScriptRoot\build"
$build_ver = ((Get-Content $PSScriptRoot\F1Regs.lua -First 1) -split "`"")[1]
$app_dir = "$build_dir\apps\lua\F1Regs"

(Get-Content "$PSScriptRoot\manifest.ini") | ForEach-Object { $_ -replace "VERSION =.+","VERSION = $build_ver"  } | Set-Content "$PSScriptRoot\manifest.ini"

if (!(Test-Path $app_dir))
{
New-Item -itemType Directory -Path $app_dir
}

Copy-Item "$PSScriptRoot\extension" -Destination $build_dir -Recurse -Force
Copy-Item "$PSScriptRoot\assets" -Destination $app_dir -Recurse -Force
Copy-Item "$PSScriptRoot\data" -Destination $app_dir -Recurse -Force
Copy-Item "$PSScriptRoot\F1Regs.lua" -Destination $app_dir -Force
Copy-Item "$PSScriptRoot\manifest.ini" -Destination $app_dir -Force
Copy-Item "$PSScriptRoot\settings_default.ini" -Destination $app_dir -Force
Copy-Item "$PSScriptRoot\icon.png" -Destination $app_dir -Force

$target_file = "$build_dir\F1Regs_$build_ver.zip"
if (Test-Path $target_file) {
  Remove-Item $target_file
}

Compress-Archive -Path $build_dir\* -DestinationPath $target_file