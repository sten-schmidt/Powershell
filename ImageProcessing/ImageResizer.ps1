#
# Resize Images and keep aspect ratio
# Example:
# .\ImageResizer.ps1 -SourceImagePath "C:\Temp\Test\orig.JPG" -DestinationImagePath "C:\Temp\Test\dest.JPG" -DestinationHeight 768 -DestinationWidth 1024
#

Param([Parameter(Mandatory=$true)][String]$SourceImagePath,
      [Parameter(Mandatory=$true)][String]$DestinationImagePath,
      [Parameter(Mandatory=$true)][Int]$DestinationHeight,
      [Parameter(Mandatory=$true)][Int]$DestinationWidth
)

try
{
    $assemblies = ("System.Drawing") 
    $imageResizerSource = Get-Content -Path .\ImageResizer.cs -Raw

    Add-Type -ReferencedAssemblies $assemblies -TypeDefinition $imageResizerSource -Language CSharp	

    $resizer = [ImageResize.ImageResizer]::New($SourceImagePath,$DestinationImagePath,$DestinationHeight,$DestinationWidth)
    $resizer.Resize();

}
catch [System.Exception]
{
    Write-Error -Message $Error[0]
}
finally
{
    if ($resizer) {
        $resizer.Dispose()
    }
}
