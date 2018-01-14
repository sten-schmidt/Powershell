#
# Upload a File to Sharepoint document library 
# .\Add-FileToSPDocLib -SpWebUrl "http://sharepoint/websites/testweb" -DocLibName  “Doks” -FilePath “C:\Temp\Neues Textdokument.txt” -override $true
#

Param(
    [Parameter(Mandatory=$true)][String]$SpWebUrl,
    [Parameter(Mandatory=$true)][String]$DocLibName,
    [Parameter(Mandatory=$true)][String]$FilePath,
    [Parameter(Mandatory=$true)][Bool]$Override
)

Add-PsSnapin Microsoft.SharePoint.PowerShell

try
{
    
    function Add-FileToSPDocLib([String]$spWebUrl, [String]$docLibName, [String]$filePath, [Bool]$override) {

        [Microsoft.SharePoint.SPWeb]$spWeb = Get-SPWeb $spWebUrl 
        [Microsoft.SharePoint.SPFolder]$spFolder = $spWeb.GetFolder($docLibName) 
        [Microsoft.SharePoint.SPFileCollection]$spFileCollection = $spFolder.Files
    
        [IO.FileSystemInfo]$file = Get-ChildItem $filePath
        [String]$fileName = $file.Name

        [IO.FileStream]$fs = $file.OpenRead()

        $spFileCollection.Add($docLibName + "/" + $fileName, $fs, $override)  | Out-Null

        $fs.Dispose()
        $file = $null
        $spFileCollection = $null
        $spFolder = $null
        $spWeb.Dispose()	
    }

    Add-FileToSPDocLib -spWebUrl $SpWebUrl -docLibName $DocLibName -filePath $FilePath -override $Override

}
catch [System.Exception]
{
    Write-Error -Message $Error[0]
}
finally
{
    
}