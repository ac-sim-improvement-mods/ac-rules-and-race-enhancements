$build_dir = "$PSScriptRoot\build"
$build_ver = ((Get-Content $PSScriptRoot\assettocorsa\apps\lua\RARE\RARE.lua)[1] -split "`"")[1]
$build_code = ((Get-Content $PSScriptRoot\assettocorsa\apps\lua\RARE\RARE.lua)[0] -split "= ")[1]
$build_code = [int]$build_code + 1

$date = Get-Date -Format "yyyy-MM-dd"

(Get-Content "$PSScriptRoot\assettocorsa\apps\lua\RARE\manifest.ini") | ForEach-Object { $_ -replace "VERSION =.+","VERSION = $build_ver"  } | Set-Content "$PSScriptRoot\assettocorsa\apps\lua\RARE\manifest.ini"
(Get-Content "$PSScriptRoot\assettocorsa\apps\lua\RARE\RARE.lua") | ForEach-Object { $_ -replace "SCRIPT_BUILD_DATE =.+","SCRIPT_BUILD_DATE = `"$date`""  } | Set-Content "$PSScriptRoot\assettocorsa\apps\lua\RARE\RARE.lua"
(Get-Content "$PSScriptRoot\assettocorsa\apps\lua\RARE\RARE.lua") | ForEach-Object { $_ -replace "SCRIPT_VERSION_CODE =.+","SCRIPT_VERSION_CODE = $build_code"  } | Set-Content "$PSScriptRoot\assettocorsa\apps\lua\RARE\RARE.lua"

$target_file = "$build_dir\RARE_$build_ver.zip"
if (Test-Path $target_file) {
  Remove-Item $target_file
}

Compress-Archive -Path $PSScriptRoot\assettocorsa\* -DestinationPath $target_file