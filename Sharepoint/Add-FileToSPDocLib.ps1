﻿#
# Upload a File to Sharepoint document library 
#

Add-PsSnapin Microsoft.SharePoint.PowerShell

function Add-FileToSPDocLib([String]$spWebUrl, [String]$docLibName, [String]$filePath, [Bool]$override) {

    [Microsoft.SharePoint.SPWeb]$spWeb = Get-SPWeb $spWebUrl 
    [Microsoft.SharePoint.SPFolder]$spFolder = $spWeb.GetFolder($docLibName) 
    [Microsoft.SharePoint.SPFileCollection]$spFileCollection = $spFolder.Files
    
    [IO.FileSystemInfo]$file = Get-ChildItem $filePath
    [String]$fileName = $file.Name

    $spFileCollection.Add($docLibName + "/" + $fileName, $file.OpenRead(), $override)  | Out-Null

    $file = $null
    $spFileCollection = $null
    $spFolder = $null
    $spWeb.Dispose()	
}

Add-FileToSPDocLib -spWebUrl "http://sharepoint/websites/testweb" -docLibName  “Doks” -filePath “C:\Temp\Neues Textdokument.txt” -override $true