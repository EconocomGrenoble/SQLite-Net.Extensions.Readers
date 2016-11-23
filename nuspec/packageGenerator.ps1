#$location  = "C:\Sources\NoSqlRepositories";
$location  = $env:APPVEYOR_BUILD_FOLDER

$locationNuspec = $location + "\nuspec"
$locationNuspec
	
Set-Location -Path $locationNuspec

"Packaging to nuget..."
"Build folder : " + $location

$strPath = $location + '\SQLite-Net.Extensions.Readers\bin\Release\SQLite-Net.Extensions.Readers.dll'

$VersionInfos = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($strPath)
$ProductVersion = $VersionInfos.ProductVersion
"Product version : " + $ProductVersion

"Update nuspec versions ..."	
$nuSpecFile =  $locationNuspec + '\SQLite-Net.Extensions.Readers.nuspec'
(Get-Content $nuSpecFile) | 
Foreach-Object {$_ -replace "{BuildNumberVersion}", "$ProductVersion" } | 
Set-Content $nuSpecFile

"Generate nuget package ..."
.\NuGet.exe pack SQLite-Net.Extensions.Readers.nuspec

$apiKey = $env:NuGetApiKey
	
#"Publish packages ..."	
.\NuGet push SQLite-Net.Extensions.Readers.$ProductVersion.nupkg -Source https://www.nuget.org/api/v2/package -ApiKey $apiKey
