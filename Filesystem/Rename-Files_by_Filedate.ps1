#
# Rename-Files, add the changedate to the filename.
#

$baseDir = "C:\Temp\"
$baseDirFilter = "*"
Set-Location -Path $baseDir
Get-Childitem -Path $baseDir -Filter $baseDirFilter | ForEach-Object {
    $fileNameNew = $_.LastWriteTime.ToString("yyyy-MM-dd_HHmm") + "_" + $_.Name
    Rename-Item -Path $_ -NewName $fileNameNew -WhatIf
}