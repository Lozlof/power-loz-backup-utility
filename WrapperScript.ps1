

param
(
    [string]$SourceDir,
    [string]$DestDir
)

$PathStatement = $PSScriptRoot

$MainScript = "$PathStatement\BackupScript.ps1"
$Arguments = "-SourceDir `"$SourceDir`" -DestDir `"$DestDir`""
Start-Process powershell -ArgumentList "-NoProfile -WindowStyle Hidden -File `"$MainScript`" $Arguments" -NoNewWindow -Wait
