write-host "**************************" -foreground "Cyan"
write-host "*   Packaging to nuget   *" -foreground "Cyan"
write-host "**************************" -foreground "Cyan"

$location  = $env:APPVEYOR_BUILD_FOLDER

$locationNuspec = $location + "\nuspec"
$locationNuspec
	
Set-Location -Path $locationNuspec

"Packaging to nuget..."
"Build folder : " + $location

$strPath = $location + '\SQLite-Net.Extensions.Readers\bin\Release\SQLite-Net.Extensions.Readers.dll'

$VersionInfos = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($strPath)
$ProductVersion = $VersionInfos.ProductVersion

write-host "Product version : " $ProductVersion -foreground "Green"

write-host "Packaging to nuget..." -foreground "Magenta"

write-host "Update nuspec versions" -foreground "Green"

write-host "Update nuspec versions SQLite-Net.Extensions.Readers.nuspec" -foreground "DarkGray"
$nuSpecFile =  $locationNuspec + '\SQLite-Net.Extensions.Readers.nuspec'
(Get-Content $nuSpecFile) | 
Foreach-Object {$_ -replace "{BuildNumberVersion}", "$ProductVersion" } | 
Set-Content $nuSpecFile

write-host "Generate nuget packages" -foreground "Green"

.\NuGet.exe pack SQLite-Net.Extensions.Readers.nuspec

$apiKey = $env:NuGetApiKey
	
write-host "Publish nuget packages" -foreground "Green"

write-host SQLite-Net.Extensions.Readers.$ProductVersion.nupkg -foreground "DarkGray"
.\NuGet push SQLite-Net.Extensions.Readers.$ProductVersion.nupkg -Source https://www.nuget.org/api/v2/package -ApiKey $apiKey
