$location  = Get-Location

$location.Path

$strPath = $location.Path + '\..\SQLite-Net.Extensions.Readers\bin\Release\SQLite-Net.Extensions.Readers.dll'

$strPath

$Assembly = [Reflection.Assembly]::Loadfile($strPath)
$AssemblyName = $Assembly.GetName()
$Assemblyversion =  $AssemblyName.version
$Assemblyversion

$nuSpecFile =  $location.Path + '\SQLite-Net.Extensions.Readers.nuspec'

(Get-Content $nuSpecFile) | 
Foreach-Object {$_ -replace "(<version>([0-9.]+)<\/version>)", "<version>$Assemblyversion</version>" } | 
Set-Content $nuSpecFile

.\NuGet pack SQLite-Net.Extensions.Readers.nuspec

$apiKey = Read-Host 'Please set apiKey to publish to nuGet :'
	
.\NuGet push SQLite-Net.Extensions.Readers.$Assemblyversion.nupkg -Source https://www.nuget.org/api/v2/package -ApiKey $apiKey