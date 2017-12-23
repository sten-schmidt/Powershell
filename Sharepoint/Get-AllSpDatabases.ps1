#
# Get a List of all SP-Databases
#

Add-PsSnapin Microsoft.SharePoint.PowerShell
Get-SPDatabase | Format-Table Name, Type