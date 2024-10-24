
param
(
    [string]$SourceDir,
    [string]$DestDir
)

$PathStatement = $PSScriptRoot

$MainScript = "$PathStatement\LozBackupScript.ps1"
$Arguments = "-SourceDir `"$SourceDir`" -DestDir `"$DestDir`""
Start-Process powershell -ArgumentList "-NoProfile -WindowStyle Hidden -File `"$MainScript`" $Arguments" -NoNewWindow -Wait
