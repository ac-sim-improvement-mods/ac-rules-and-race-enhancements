$build_dir = "$PSScriptRoot\build"
$build_ver = ((Get-Content $PSScriptRoot\assettocorsa\apps\lua\F1Regs\F1Regs.lua)[0] -split "`"")[1]
$build_code = ((Get-Content $PSScriptRoot\assettocorsa\apps\lua\F1Regs\F1Regs.lua)[1] -split "= ")[1]

$date = Get-Date -Format "yyyy-MM-dd"

(Get-Content "$PSScriptRoot\assettocorsa\apps\lua\F1Regs\manifest.ini") | ForEach-Object { $_ -replace "VERSION =.+","VERSION = $build_ver"  } | Set-Content "$PSScriptRoot\assettocorsa\apps\lua\F1Regs\manifest.ini"
(Get-Content "$PSScriptRoot\assettocorsa\apps\lua\F1Regs\F1Regs.lua") | ForEach-Object { $_ -replace "SCRIPT_BUILD_DATE =.+","SCRIPT_BUILD_DATE = `"$date`""  } | Set-Content "$PSScriptRoot\assettocorsa\apps\lua\F1Regs\F1Regs.lua"

$target_file = "$build_dir\F1Regs_$build_ver.zip"
if (Test-Path $target_file) {
  Remove-Item $target_file
}

Compress-Archive -Path $PSScriptRoot\assettocorsa\* -DestinationPath $target_file