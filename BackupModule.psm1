

function Start-Backup
{
    param
    (
        [Int]$BackupOperation = $null,
        [String]$PathStatementBackup = "",
        [Object[][]]$TotalArrayBackup = @(),
        $SourceArrayBackup = @(),
        $DestinationArrayBackup = @(),
        [Int]$FinalCount = $null
    )

    #Write-Host "Function: Start-Backup | BackupOperation: $BackupOperation | PathStatementBackup: $PathStatementBackup | TotalArrayBackup: $($TotalArrayBackup | ForEach-Object { $_ -join ', ' }) | SourceArrayBackup: $SourceArrayBackup | DestinationArrayBackup: $DestinationArrayBackup | FinalCount: $FinalCount" -ForegroundColor Green      

    function Backup-DataOne
    {
        [Int]$BaseCount = 0
        [Int]$UserInputLoop = 0
        [Int]$WriteOutCount = $BaseCount + 1

        while ($BaseCount -lt $FinalCount)
        {
            $FinalSourceDir = $SourceArrayBackup[$BaseCount]
            $FinalDestDir = $DestinationArrayBackup[$BaseCount]

            if (((($FinalSourceDir.StartsWith('"') -and $FinalSourceDir.EndsWith('"')) -or (($FinalSourceDir.StartsWith('"')) -or ($FinalSourceDir.EndsWith('"')))) -or ($FinalSourceDir.StartsWith("'") -and $FinalSourceDir.EndsWith("'"))) -or (($FinalSourceDir.StartsWith("'")) -or ($FinalSourceDir.EndsWith("'"))))  
            {
                $FinalSourceDir = $FinalSourceDir.Trim('"', "'" )
            }

            if (((($FinalDestDir.StartsWith('"') -and $FinalDestDir.EndsWith('"')) -or (($FinalDestDir.StartsWith('"')) -or ($FinalDestDir.EndsWith('"')))) -or ($FinalDestDir.StartsWith("'") -and $FinalDestDir.EndsWith("'"))) -or (($FinalDestDir.StartsWith("'")) -or ($FinalDestDir.EndsWith("'"))))  
            {
                $FinalDestDir = $FinalDestDir.Trim('"', "'" )
            }

            [Bool]$TestTheSource = Test-Path -Path $FinalSourceDir
            
            if ($TestTheSource -eq $false)
            {
                [Int]$UserInputLoop = 0

                while ($UserInputLoop -eq 0)
                { 
                    Write-Host "Backup $WriteOutCount. $FinalSourceDir does not exist!" -ForegroundColor Red
                    Write-Host "Do you want to create this directory?" -ForegroundColor Red
                    Write-Host "1. Yes"
                    Write-Host "2. No"
                
                    $UserInputLoop = Get-UserInputBackup 
                }

                [Int]$MakeDirChoice = $UserInputLoop

                if ($MakeDirChoice -eq 1)
                {
                    New-Item -Path $FinalSourceDir -ItemType Directory -Force
                }
                elseif ($MakeDirChoice -eq 2)
                {
                    Write-Host "Backup $WriteOutCount. $FinalSourceDir to $FinalDestDir failed!" -ForegroundColor Red
                    Write-Host

                    $BaseCount = $BaseCount + 1
                    $WriteOutCount = $WriteOutCount + 1 
                    continue 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementBackup -LogType 3 -Message "(54)A. Parent Function: Start-Backup | Child Function: Backup-DataOne | Variable MakeDirChoice: $MakeDirChoice (Should equal 1 or 2)" 
                    Exit-CaTScheduler
                    Exit
                }
            }

            [Bool]$TestTheDestination = Test-Path -Path $FinalDestDir

            if ($TestTheDestination -eq $false)
            {
                [Int]$UserInputLoop = 0

                while ($UserInputLoop -eq 0)
                {
                    Write-Host "Backup $WriteOutCount. $FinalDestDir does not exist!" -ForegroundColor Yellow
                    Write-Host "Do you want to create this directory?" -ForegroundColor Yellow
                    Write-Host "1. Yes" 
                    Write-Host "2. No"

                    $UserInputLoop = Get-UserInputBackup
                }
                
                [Int]$MakeDirChoice = $UserInputLoop
                
                if ($MakeDirChoice -eq 1)
                {
                    New-Item -Path $FinalDestDir -ItemType Directory -Force
                }
                elseif ($MakeDirChoice -eq 2)
                {
                    Write-Host "Backup $WriteOutCount. $FinalSourceDir to $FinalDestDir failed!" -ForegroundColor Red
                    Write-Host

                    $BaseCount = $BaseCount + 1
                    $WriteOutCount = $WriteOutCount + 1 
                    continue 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementBackup -LogType 3 -Message "(54)B. Parent Function: Start-Backup | Child Function: Backup-DataOne | Variable MakeDirChoice: $MakeDirChoice (Should equal 1 or 2)" 
                    Exit-CaTScheduler
                    Exit
                }   
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
                        Write-BackupLog -LogTypeX 1 -MessageX "(One time backup) The directory $DestinationPath was created within $FinalDestDir in order to complete the backup of $FinalSourceDir to $FinalDestDir" 
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
                            Write-BackupLog -LogTypeX 1 -MessageX "(One time backup) The file $($SourceItem.FullName) was copied to $($DestItem.FullName) in order to complete the backup of $FinalSourceDir to $FinalDestDir" 
                        }
                    }
                    else 
                    {
                        $DestinationPath = Join-Path -Path $FinalDestDir -ChildPath $RelativePath
                        $DestinationDir = Split-Path -Path $DestinationPath -Parent

                        if (-not (Test-Path -Path $DestinationDir)) 
                        {
                            New-Item -Path $DestinationDir -ItemType Directory -Force
                            Write-BackupLog -LogTypeX 1 -MessageX "(One time backup) The directory $DestinationDir was created in order to complete the backup of $FinalSourceDir to $FinalDestDir"
                        }

                        Copy-Item -Path $SourceItem.FullName -Destination $DestinationPath -Force
                        Write-BackupLog -LogTypeX 1 -MessageX "(One time backup) The file $($SourceItem.FullName) was copied to $DestinationPath in order to complete the backup of $FinalSourceDir to $FinalDestDir"
                    }
                }
            }

            Write-Host "Backup $WriteOutCount. $FinalSourceDir to $FinalDestDir complete!" -ForegroundColor Yellow
            Write-Host

            $BaseCount = $BaseCount + 1
            $WriteOutCount = $WriteOutCount + 1 
        }

        return $true
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

    function Write-BackupLog
    {
        param
        (
            [String]$MessageX = "",
            [Int]$LogTypeX = $null
        )

        $LogFileOneX = "$PathStatementBackup\Logs\InfoLog.log"
        $TimestampX = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        if ($LogTypeX -eq 1) 
        {
            Add-Content -Path $LogFileOneX -Value "INFO: $TimestampX"
            Add-Content -Path $LogFileOneX -Value "$MessageX"
            Add-Content -Path $LogFileOneX -Value " "

            return $true
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementBackup -LogType 3 -Message "(55)A. Parent Function: Start-Backup | Child Function: Write-BackupLog | Variable LogTypeX: $LogTypeX (Should equal 1)"
            Exit-CaTScheduler
            Exit
        }
    }

    function Get-UserInputBackup 
    {
        $UserChoiceXX = Read-Host "Choice" 
        Write-Host

        if ($UserChoiceXX -eq "")
        {
            Write-Host "Error: The input given was not valid. The options are 1 or 2" -ForegroundColor Red
            Write-Host
            
            return 0
        }

        [Bool]$IsItAnIntegerBackup = [Int]::TryParse($UserChoiceXX, [ref]$null) 

        if (-not $IsItAnIntegerBackup)
        {
            Write-Host "Error: The input given was not valid. The options are 1 or 2" -ForegroundColor Red
            Write-Host
            
            return 0
        }

        try
        {
            [Int]$UserChoiceX = [Int]$UserChoiceXX
        }
        catch [System.Management.Automation.RuntimeException]
        {
            if ($_.Exception.Message -like "*Input string was not in a correct format.*")
            {
                Write-Host "Error: The input given was not valid. The options are 1 or 2" -ForegroundColor Red
                Write-Host
            
                return 0
            }
        }

        if (($UserChoiceX -eq 1) -or ($UserChoiceX -eq 2))
        {
            [Int]$ChosenUserChoice = $UserChoiceX 
            
            return $ChosenUserChoice  
        }
        elseif ($UserInputX -eq 0)
        {
            Write-Host "Error: The input given was not valid. The options are 1 or 2" -ForegroundColor Red
            Write-Host
            
            return 0
        }
        elseif (($UserChoiceX -lt 0) -or ($UserChoiceX -gt 2))
        {
            Write-Host "Error: The input given was not valid. The options are 1 or 2" -ForegroundColor Red
            Write-Host
            
            return 0
        }
        else
        {
            Write-Host "Error: The input given was not valid. The options are 1 or 2" -ForegroundColor Red
            Write-Host
            
            return 0
        }
    }

    if ($BackupOperation -eq 1)
    {
        $SourceArrayBackup = $TotalArrayBackup[0]
        $DestinationArrayBackup = $TotalArrayBackup[1]

        [Int]$SourceCount = $SourceArrayBackup.Count
        [Int]$DestCount = $DestinationArrayBackup.Count

        if ($SourceCount -ne $DestCount)
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementBackup -LogType 3 -Message "(58)A. Parent Function: Start-Backup | Variable BackupOperation: $BackupOperation (Should equal 1)"
            Exit-CaTScheduler
            Exit
        }
        elseif ($SourceCount -eq $DestCount)
        {
            $FinalCount = $SourceCount
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementBackup -LogType 3 -Message "(58)B. Parent Function: Start-Backup | Variable BackupOperation: $BackupOperation (Should equal 1)"
            Exit-CaTScheduler
            Exit
        }
        
        [Bool]$IsBackupGood = Backup-DataOne

        if ($IsBackupGood -eq $true)
        {
            Write-Host "All backups complete!" -ForegroundColor Yellow
            Write-Host
            Start-CaTScheduler -PathStatementStartup $PathStatementBackup -Start 1
        }
        elseif (-not ($IsBackupGood -eq $true))
        {
            Write-Host "Backup(s) failed!" -ForegroundColor Red
            Write-Host
            Start-CaTScheduler -PathStatementStartup $PathStatementBackup -Start 1
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementBackup -LogType 3 -Message "(56)A. Parent Function: Start-Backup | Variable BackupOperation: $BackupOperation (Should equal 1)"
            Exit-CaTScheduler
            Exit
        }
    }
    else
    {
        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementBackup -LogType 3 -Message "(57)A. Parent Function: Start-Backup | Variable BackupOperation: $BackupOperation (Should not equal 1)"
        Exit-CaTScheduler
        Exit
    }
}

Export-ModuleMember -Function Start-Backup 