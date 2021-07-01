#
# Trim dynamically expanding disks (vhdx-files).
# On Linux-VMs run 'fstrim /' as root before executing this script.
#

function Get-FileSizeGb ($FilePath) {
    return (Get-Item -Path $FilePath).Length/1GB
}

function Optimize-HDDFile($FilePath) {
    
    Write-Output "Processing: $FilePath"

    [double]$size1 = Get-FileSizeGb($FilePath);
    Write-Output "Size before: $size1 GB"
    
    Optimize-VHD -Path $FilePath -Mode Full -ErrorAction Stop 
    
    [double]$size2 = Get-FileSizeGb($FilePath);
    Write-Output "Size after: $size2 GB"
    [double]$diff = $size1 - $size2
    Write-Output "Difference: $diff GB"
}

#
# Main
#

Get-ChildItem -Path C:\HyperV\Festplatten\*.vhdx | ForEach-Object {
    Optimize-HDDFile -FilePath "$_"
}