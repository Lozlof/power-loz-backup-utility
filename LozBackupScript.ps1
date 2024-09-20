# Posted on Wiki

param
(
    $SourceDir,
    $DestDir
)

function Invoke-BackupScript
{
    param
    (
        [String]$SourceDir = "",
        [String]$DestDir = "",
        $StartRun = $null
    )

    function Write-LogInformation
    {
        param
        (
            [String]$MessageX = "",
            [Int]$LogTypeX = $null
        )

        $PathStatementX = $PSScriptRoot
        Set-Location $PathStatementX
        $PathStatement = Get-Location

        $CompareAndTransferLogFile = "$PathStatement\PowerLozLogs\LozInfoLog.log"
        $CompareAndTransferLogFileOne = "$PathStatement\PowerLozLogs\LozErrorLog.log"
        $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        if ($LogTypeX -eq 1)
        {
            Add-Content -Path $CompareAndTransferLogFile -Value "INFO: $Timestamp"
            Add-Content -Path $CompareAndTransferLogFile -Value "$MessageX"
            Add-Content -Path $CompareAndTransferLogFile -Value " "

            return $true
        }
        elseif ($LogTypeX -eq 3)
        {
            Add-Content -Path $CompareAndTransferLogFileOne -Value "CRITICAL ERROR: Invoked Exit: $Timestamp"
            Add-Content -Path $CompareAndTransferLogFileOne -Value "$MessageX"
            Add-Content -Path $CompareAndTransferLogFileOne -Value " "

            Exit
        }
        else
        {
            Exit
        }
    }

    function Get-RelativePath
    {
        param
        (
            [string]$BasePath,
            [string]$FullPath
        )

        return $FullPath.Substring($BasePath.Length).TrimStart("\")
    }

    function Get-TheComparison
    {
        param
        (
            $FinalSourceDir,
            $FinalDestDir
        )

        if (((($FinalSourceDir.StartsWith('"') -and $FinalSourceDir.EndsWith('"')) -or (($FinalSourceDir.StartsWith('"')) -or ($FinalSourceDir.EndsWith('"')))) -or ($FinalSourceDir.StartsWith("'") -and $FinalSourceDir.EndsWith("'"))) -or (($FinalSourceDir.StartsWith("'")) -or ($FinalSourceDir.EndsWith("'"))))
        {
            $FinalSourceDir = $FinalSourceDir.Trim('"', "'" )
        }

        if (((($FinalDestDir.StartsWith('"') -and $FinalDestDir.EndsWith('"')) -or (($FinalDestDir.StartsWith('"')) -or ($FinalDestDir.EndsWith('"')))) -or ($FinalDestDir.StartsWith("'") -and $FinalDestDir.EndsWith("'"))) -or (($FinalDestDir.StartsWith("'")) -or ($FinalDestDir.EndsWith("'"))))
        {
            $FinalDestDir = $FinalDestDir.Trim('"', "'" )
        }

        if (-not (Test-Path -Path $FinalDestDir))
        {
            New-Item -Path $FinalDestDir -ItemType Directory -Force
            Write-LogInformation -LogTypeX 1 -MessageX "(Scheduled backup) $FinalDestDir was moved or deleted since last checked. CaT re-created $FinalDestDir in order to complete the backup of $FinalSourceDir"
        }

        $SourceItems = Get-ChildItem -Path $FinalSourceDir -Recurse
        $DestItems = Get-ChildItem -Path $FinalDestDir -Recurse

        $DestItemLookup = @{}

        foreach ($Item in $DestItems)
        {
            $RelativePath = Get-RelativePath -BasePath $FinalDestDir -FullPath $Item.FullName
            $DestItemLookup[$RelativePath] = $Item
        }

        foreach ($SourceItem in $SourceItems)
        {
            $RelativePath = Get-RelativePath -BasePath $FinalSourceDir -FullPath $SourceItem.FullName

            if ($SourceItem.PSIsContainer)
            {
                if (-not $DestItemLookup.ContainsKey($RelativePath))
                {
                    $DestinationPath = Join-Path -Path $FinalDestDir -ChildPath $RelativePath
                    New-Item -Path $DestinationPath -ItemType Directory -Force
                    Write-LogInformation -LogTypeX 1 -MessageX "(Scheduled backup) The directory $DestinationPath was created within $FinalDestDir in order to complete the backup of $FinalSourceDir to $FinalDestDir"
                }
            }
            else
            {
                if ($DestItemLookup.ContainsKey($RelativePath))
                {
                    $DestItem = $DestItemLookup[$RelativePath]

                    $SourceHash = Get-FileHash -Path $SourceItem.FullName
                    $DestHash = Get-FileHash -Path $DestItem.FullName

                    if ($SourceHash.Hash -ne $DestHash.Hash)
                    {
                        Copy-Item -Path $SourceItem.FullName -Destination $DestItem.FullName -Force
                        Write-LogInformation -LogTypeX 1 -MessageX "(Scheduled backup) The file $($SourceItem.FullName) was copied to $($DestItem.FullName) in order to complete the backup of $FinalSourceDir to $FinalDestDir"
                    }
                }
                else
                {
                    $DestinationPath = Join-Path -Path $FinalDestDir -ChildPath $RelativePath
                    $DestinationDir = Split-Path -Path $DestinationPath -Parent

                    if (-not (Test-Path -Path $DestinationDir))
                    {
                        New-Item -Path $DestinationDir -ItemType Directory -Force
                        Write-BackupLog -LogTypeX 1 -MessageX "(Scheduled backup) The directory $DestinationDir was created in order to complete the backup of $FinalSourceDir to $FinalDestDir"
                    }

                    Copy-Item -Path $SourceItem.FullName -Destination $DestinationPath -Force
                    Write-LogInformation -LogTypeX 1 -MessageX "(Scheduled backup) The file $($SourceItem.FullName) was copied to $DestinationPath in order to complete the backup of $FinalSourceDir to $FinalDestDir"
                }
            }
        }

        return $true
    }

    if ($StartRun -eq 1)
    {
        [Bool]$IsGoodBackup = Get-TheComparison -FinalSourceDir $SourceDir -FinalDestDir $DestDir

        if ($IsGoodBackup -eq $true)
        {
            Write-LogInformation -LogTypeX 1 -MessageX "(Scheduled backup) BackupScript.ps1 was successful"
            Exit
        }
        elseif (-not ($IsGoodBackup -eq $true))
        {
            Write-LogInformation -LogTypeX 3 -MessageX "(84)A. BackupScript.ps1 was not successful. Variable IsGoodBackup: $IsGoodBackup (Should equal true)"
            Exit
        }
    }
    else
    {
        Write-LogInformation -LogTypeX 3 -MessageX "(84)B. Variable StartRun: $StartRun (Should equal 1)"
        Exit
    }
}

Invoke-BackupScript -SourceDir $SourceDir -DestDir $DestDir -StartRun 1
