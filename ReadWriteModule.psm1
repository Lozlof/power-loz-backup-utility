

function Invoke-ReadWrite
{
    param
    (
        [Int]$OperationChoice = $null,
        [String]$Message = $null,
        [Int]$LogType = $null,
        [String]$SourcePathItem = $null,
        [String]$DestinationPathItem = $null,
        [Object[][]]$TotalArrayReadWrite = @(),
        [Int]$TypeOfBackupReadWrite = $null,
        [Int]$SourceOrDest = $null,
        [String]$PathStatementReadWrite = "",
        [Int]$NewOrSavedReadWrite = $null,
        [Int]$UserInputReadWrite = $null,
        $PathHashTableReadWrite = @{},
        [Int]$TotalKeys = $null,
        [Int]$PrintHashTable = $null,
        [String]$TaskForDeletion = ""
    )

    [Int]$TheCountReadWrite = $TotalArrayReadWrite.Count
    #Write-Host "Debug: Function: Invoke-ReadWrite | OperationChoice: $OperationChoice | Message: | LogType: $LogType | SourcePathItem: $SourcePathItem | DestinationPathItem: $DestinationPathItem | TotalArrayReadWrite: $($TotalArrayReadWrite | ForEach-Object { $_ -join ', ' }) | TypeOfBackupReadWrite: $TypeOfBackupReadWrite | TotalArrayReadWrite Count: $TheCountReadWrite | SourceOrDest: $SourceOrDest | PathStatementReadWrite: $PathStatementReadWrite | NewOrSavedReadWrite: $NewOrSavedReadWrite | UserInputReadWrite: $UserInputReadWrite | TotalKeys: $TotalKeys" -ForegroundColor Green

    function Write-Log
    {
        $LogFileOne = "$PathStatementReadWrite\Logs\InfoLog.log"
        $LogFileTwo = "$PathStatementReadWrite\Logs\ErrorLog.log"
        $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        if ($LogType -eq 1)
        {
            Add-Content -Path $LogFileOne -Value "INFO: $Timestamp"
            Add-Content -Path $LogFileOne -Value "$Message"
            Add-Content -Path $LogFileOne -Value " "

            return $true
        }
        elseif ($LogType -eq 2)
        {
            Add-Content -Path $LogFileTwo -Value "ERROR: No Exit: $Timestamp"
            Add-Content -Path $LogFileTwo -Value "$Message"
            Add-Content -Path $LogFileTwo -Value " "

            return $true
        }
        elseif ($LogType -eq 3)
        {
            Add-Content -Path $LogFileTwo -Value "CRITICAL ERROR: Invoked Exit: $Timestamp"
            Add-Content -Path $LogFileTwo -Value "$Message"
            Add-Content -Path $LogFileTwo -Value " "
            Exit-CaTScheduler
            Exit

            return $true
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(11)A. Parent Function: Invoke-ReadWrite | Child Function: Write-Log | Variable LogType: $LogType (Should equal 1, 2, or 3)"
            Exit-CaTScheduler
            Exit
        }
    }

    function Write-PathStatements
    {
        $SavedPathsPathReadWrite = "$PathStatementReadWrite\ConfigurationFiles\SavedPaths.json"
        $PathHashTableReadWrite = @{}

        if (Test-Path -Path $SavedPathsPathReadWrite)
        {
            $HashtableDataReadWrite = Get-Content -Path $SavedPathsPathReadWrite | ConvertFrom-Json
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule) Variable SavedPathsPathReadWrite ($SavedPathsPathReadWrite) does not exist therefore exited Write-PathStatements"

            return $false
        }

        foreach ($Item in $HashtableDataReadWrite)
        {
            $PathHashTableReadWrite[$Item.Name] = $Item.Value
        }

        if (-not ($PathHashtableReadWrite.Values -contains $SourcePathItem))
        {
            [Int]$TotalKeys = $PathHashtableReadWrite.Count
            [Int]$Key = $TotalKeys + 1

            $PathHashtableReadWrite[$Key] = $SourcePathItem

            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 1 -Message "(ReadWriteModule) $SourcePathItem written to $SavedPathsPathReadWrite"
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 1 -Message "(ReadWriteModule) $SourcePathItem is already within $SavedPathsPathReadWrite and therefore was not written"
        }

        if (-not ($PathHashtableReadWrite.Values -contains $DestinationPathItem))
        {
            [Int]$TotalKeys = $PathHashtableReadWrite.Count
            [Int]$Key = $TotalKeys + 1

            $PathHashtableReadWrite[$Key] = $DestinationPathItem

            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 1 -Message "(ReadWriteModule) $DestinationPathItem written to $SavedPathsPathReadWrite"
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 1 -Message "(ReadWriteModule) $DestinationPathItem is already within $SavedPathsPathReadWrite and therefore was not written"
        }

        try
        {
            $PathHashTableReadWrite.GetEnumerator() | ConvertTo-Json | Set-Content -Path $SavedPathsPathReadWrite

            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 1 -Message "(ReadWriteModule) Variable PathHashTableReadWrite ($PathHashTableReadWrite) sucessfully written to $SavedPathsPathReadWrite"

            return $true
        }
        catch
        {
            if ($_.Exception.Message -match "You cannot call a method on a null-valued expression")
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule) Variable PathHashTableReadWrite ($PathHashTableReadWrite) does not exist and therefore was not written to $SavedPathsPathReadWrite"

                return $false
            }
            elseif ($_.Exception.Message -match "Cannot bind argument to parameter 'Path' because it is null")
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule) Variable PathHashTableReadWrite ($PathHashTableReadWrite) was not written to variable SavedPathsPathReadWrite ($SavedPathsPathReadWrite) because SavedPathsPathReadWrite does not exist"

                return $false
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule) General error, variable PathHashTableReadWrite ($PathHashTableReadWrite) was not able to write to variable SavedPathsPathReadWrite ($SavedPathsPathReadWrite)"

                return $false
            }
        }
    }

    function Get-PathStatements
    {
        [String]$SavedPathsPathReadWrite = "$PathStatementReadWrite\ConfigurationFiles\SavedPaths.json"

        if (($PrintHashTable -eq 0) -or ($PrintHashTable -eq $null))
        {
            if (Test-Path -Path $SavedPathsPathReadWrite)
            {
                $HashtableDataReadWrite = Get-Content -Path $SavedPathsPathReadWrite | ConvertFrom-Json
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule). Variable SavedPathsPathReadWrite ($SavedPathsPathReadWrite) does not exist therefore exited Get-PathStatements"
                return $false #redirect somewhere
            }

            foreach ($Entry in $HashtableDataReadWrite)
            {
                $PathHashTableReadWrite[$Entry.Name] = $Entry.Value
            }

            [Int]$TotalKeys = $PathHashTableReadWrite.Count

            Write-Host "Saved path statements:" -ForegroundColor Yellow

            foreach ($Key in $PathHashTableReadWrite.Keys)
            {
                Write-Host "$Key. $($PathHashTableReadWrite[$Key])"
            }

             if ($SourceOrDest -eq 1)
            {
                [String]$DirType = "source directory or file"
            }
            elseif ($SourceOrDest -eq 2)
            {
                [String]$DirType = "destination directory"
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)A. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatements"
                Exit-CaTScheduler
                Exit
            }

            Write-Host "Choose the $DirType"

            if ($SourceOrDest -eq 1)
            {
                if (-not $TotalArrayReadWrite -or $TotalArrayReadWrite.Count -eq 0)
                {
                    Get-Menu -ChooseMenu 5 -TypeOfBackup $TypeOfBackupReadWrite -NumberOfChoices $TotalKeys -PathStatementMenu $PathStatementReadWrite -SourceOrDestMenu $SourceOrDest
                }
                elseif ($TotalArrayReadWrite.Count -eq 2)
                {
                    Get-Menu -ChooseMenu 5 -TypeOfBackup $TypeOfBackupReadWrite -NumberOfChoices $TotalKeys -PathStatementMenu $PathStatementReadWrite -SourceOrDestMenu $SourceOrDest -TotalArrayMenu $TotalArrayReadWrite
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)B. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatements"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($SourceOrDest -eq 2)
            {
                if (-not $TotalArrayReadWrite -or $TotalArrayReadWrite.Count -eq 0)
                {
                    Get-Menu -ChooseMenu 5 -TypeOfBackup $TypeOfBackupReadWrite -NumberOfChoices $TotalKeys -PathStatementMenu $PathStatementReadWrite -SourceOrDestMenu $SourceOrDest -SourcePathItemMenu $SourcePathItem
                }
                elseif ($TotalArrayReadWrite.Count -eq 2)
                {
                    Get-Menu -ChooseMenu 5 -TypeOfBackup $TypeOfBackupReadWrite -NumberOfChoices $TotalKeys -PathStatementMenu $PathStatementReadWrite -SourceOrDestMenu $SourceOrDest -TotalArrayMenu $TotalArrayReadWrite -SourcePathItemMenu $SourcePathItem
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)C. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatements"
                    Exit-CaTScheduler
                    Exit
                }
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)C. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatements"
                Exit-CaTScheduler
                Exit
            }
        }
        elseif ($PrintHashTable -eq 1)
        {
            if ($SourceOrDest -eq 0)
            {
                if (-not $TotalArrayReadWrite -or $TotalArrayReadWrite.Count -eq 0)
                {
                    Set-Input -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -PathStatementInput $PathStatementReadWrite -GetPathsFromInput 1
                }
                elseif ($TotalArrayReadWrite.Count -eq 2)
                {
                    Set-Input -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -TotalArrayInput $TotalArrayReadWrite -PathStatementInput $PathStatementReadWrite -GetPathsFromInput 1
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)D. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatements"
                    Exit-CaTScheduler
                    Exit
                }
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)E. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatements"
                Exit-CaTScheduler
                Exit
            }
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)F. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatements"
            Exit-CaTScheduler
            Exit
        }
    }

    function Get-TheScheduledTasks
    {
        param
        (
            [Int]$HasBeenChecked = $null
        )

        function Get-UserDeleteChoice
        {
            param
            (
                [Int]$NumberOfChoices,
                $TaskArray = @(),
                [Int]$GoBackControl = $null,
                $ContinueTheLoop = 0
            )

            function Get-UserInput
            {
                param
                (
                    $ContinueTheLoop = $null
                )

                $UserInputX = Read-Host "Choice"
                Write-Host

                if ($UserInputX -eq "")
                {
                    Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                    Write-Host

                    if ($GoBackControl -eq 1)
                    {
                        Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                    }
                    else
                    {
                        Get-TheScheduledTasks -HasBeenChecked 1
                    }
                }

                [Bool]$IsItAnInteger = [Int]::TryParse($UserInputX, [ref]$null)

                if (-not $IsItAnInteger)
                {
                    Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                    Write-Host

                    if ($GoBackControl -eq 1)
                    {
                        Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                    }
                    else
                    {
                        Get-TheScheduledTasks -HasBeenChecked 1
                    }
                }

                try
                {
                    [Int]$UserInput = [Int]$UserInputX
                }
                catch [System.Management.Automation.RuntimeException]
                {
                    if ($_.Exception.Message -like "*Input string was not in a correct format.*")
                    {
                        Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                        Write-Host

                        if ($GoBackControl -eq 1)
                        {
                            Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                        }
                        else
                        {
                            Get-TheScheduledTasks -HasBeenChecked 1
                        }
                    }
                }

                if (($UserInput -ge 1) -and ($UserInput -le $NumberOfChoices))
                {
                    [Int]$ChosenUserInput = $UserInput
                    return $ChosenUserInput
                }
                elseif ($UserInput -eq 0)
                {
                    if ($GoBackControl -eq 1)
                    {
                        Get-TheScheduledTasks -HasBeenChecked 1
                    }
                    else
                    {
                        Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
                    }
                }
                elseif (($UserInput -lt 0) -or ($UserInput -gt $NumberOfChoices))
                {
                    Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                    Write-Host

                    if ($GoBackControl -eq 1)
                    {
                        Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                    }
                    else
                    {
                        Get-TheScheduledTasks -HasBeenChecked 1
                    }
                }
                else
                {
                    Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                    Write-Host

                    if ($GoBackControl -eq 1)
                    {
                        Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                    }
                    else
                    {
                        Get-TheScheduledTasks -HasBeenChecked 1
                    }
                }
            }

            while ($ContinueTheLoop -eq 0)
            {
                Write-Host "Choose the backup that you want to delete"
                $ContinueTheLoop = Get-UserInput
            }

            [Int]$UserSelectionChoice = $ContinueTheLoop
            [Int]$UserTaskSelection = $UserSelectionChoice - 1

            if ($TaskArray.Count -gt 1)
            {
                [String]$NameOfSelection = $TaskArray[$UserTaskSelection]
            }
            elseif ($TaskArray.Count -eq 1)
            {
                [String]$NameOfSelection = $TaskArray
            }
            elseif ($TaskArray.Count -eq 0)
            {
                Write-Host "There are no scheduled backups"
                Write-Host
                Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(74)A. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTasks | Child Function: Get-UserDeleteChoice"
                Exit-CaTScheduler
                Exit
            }

            [String]$TheWordsOne = "Are you sure you want to delete "
            [String]$TheWordsTwo = "?"
            [String]$TheWordsThree = "$($TheWordsOne)$($NameOfSelection)$($TheWordsTwo)"

            [Int]$ContinueTheLoopTwo = 0
            $NumberOfChoices = 2
            $GoBackControl = 1

            while ($ContinueTheLoopTwo -eq 0)
            {
                Write-Host "$TheWordsThree"
                Write-Host "1. Yes"
                Write-Host "2. No"
                $ContinueTheLoopTwo = Get-UserInput -ContinueTheLoop $ContinueTheLoop
            }

            [Int]$UserSelectionChoiceTwo = $ContinueTheLoopTwo

            if ($UserSelectionChoiceTwo -eq 1)
            {
                Invoke-ReadWrite -OperationChoice 4 -PathStatementReadWrite $PathStatementReadWrite -NewOrSavedReadWrite $NewOrSavedReadWrite -TaskForDeletion $NameOfSelection
            }
            elseif ($UserSelectionChoiceTwo -eq 2)
            {
                Get-TheScheduledTasks -HasBeenChecked 1
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(74)B. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTasks | Child Function: Get-UserDeleteChoice | Variable UserSelectionChoiceTwo: $UserSelectionChoiceTwo (Should equal 1 or 2)"
                Exit-CaTScheduler
                Exit
            }
        }

        function Test-IfFinished
        {
            [Int]$ContinueLooking = 1

            while ($ContinueLooking -eq 1)
            {
                $Processes = Get-Process -Name "*powershell*"

                $FilteredProcesses = $Processes | ForEach-Object {
                    $ProcessDetails = Get-CimInstance Win32_Process -Filter "ProcessId = $($_.Id)"
                    [PSCustomObject]@{
                        Id          = $_.Id
                        Name        = $_.Name
                        CPU         = $_.CPU
                        Memory      = $_.WorkingSet64
                        CommandLine = $ProcessDetails.CommandLine}
                } | Where-Object { $_.CommandLine -like "*GetScheduledTasks*" } | Sort-Object -Property CommandLine

                if (($FilteredProcesses -eq $null) -or ($FilteredProcesses -eq ""))
                {
                    $ContinueLooking = 0
                }
                elseif ((-not ($FilteredProcesses -eq $null)) -or (-not ($FilteredProcesses -eq "")))
                {
                    Write-Host "Loading Scheduled Tasks"
                    Start-Sleep -Seconds 2
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(75)A. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTasks | Child Function: Test-IfFinished"
                    Exit-CaTScheduler
                    Exit
                }
            }

            if ($ContinueLooking -eq 0)
            {
                Write-Host "Done loading"
                Write-Host

                return $true
            }
        }

        function Write-ScheduledTasks
        {
            [String]$GetTasksFilePath = "$PathStatementReadWrite\ConfigurationFiles\ScheduledTasks.json"

            if (Test-Path -Path $GetTasksFilePath)
            {
                $TasksHashTable = Get-Content -Path $GetTasksFilePath | ConvertFrom-Json
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule) Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTasks | Child Function: Write-ScheduledTasks | ScheduledTasks.json cannot be accessed. Variable GetTasksFilePath: $GetTasksFilePath"
                Write-Host "Error: ScheduledTasks.json cannot be found" -ForegroundColor Red
                Write-Host
                Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
            }

            $ScheduledTasksHashTable = @{}

            foreach ($Entry in $TasksHashTable.PSObject.Properties)
            {
                $ScheduledTasksHashTable[$Entry.Name] = $Entry.Value
            }

            [Int]$BackupNumber = 1
            $TaskNameArray = @()

            Write-Host "Scheduled backups" -ForegroundColor Yellow

            foreach ($Key in $ScheduledTasksHashTable.Keys)
            {
                $TaskDetails = $ScheduledTasksHashTable[$Key]
                [Int]$ControlDetails = 0
                [String]$DetailsOne = ""
                [String]$DetailsTwo = ""
                [String]$DetailsThree = ""

                foreach ($Detail in $TaskDetails)
                {
                    if ($ControlDetails -eq 0)
                    {
                        $DetailsOne = $Detail
                    }

                    if ($ControlDetails -eq 1)
                    {
                        $DetailsTwo = $Detail
                    }

                    if ($ControlDetails -eq 2)
                    {
                        $DetailsThree = $Detail
                    }

                    $ControlDetails = $ControlDetails + 1
                }

                Write-Host "$BackupNumber. $DetailsOne"
                Write-Host "   $DetailsTwo"
                Write-Host "   $DetailsThree"
                Write-Host

                $TaskNameArray += $DetailsOne

                $BackupNumber = $BackupNumber + 1
            }

            return $TaskNameArray
        }

        if (($HasBeenChecked -eq $null) -or ($HasBeenChecked -eq 0))
        {
            [Bool]$IsItDone = Test-IfFinished

            if ($IsItDone -eq $true)
            {
                $TaskNamesArray = @()

                $TaskNamesArray = Write-ScheduledTasks

                [Int]$TaskNamesArrayCount = $TaskNamesArray.Count

                if ($TaskNamesArrayCount -gt 0)
                {
                    Get-UserDeleteChoice -NumberOfChoices $TaskNamesArrayCount -TaskArray $TaskNamesArray
                }
                elseif (($TaskNamesArrayCount -eq $null) -or ($TaskNamesArrayCount -eq 0))
                {
                    Write-Host "There are no scheduled backups"
                    Write-Host
                    Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(77)A. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTasks | Child Function:  Write-ScheduledTasks"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif (-not ($IsItDone -eq $true))
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule) Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTasks | Function Test-IfFinished failed to return true"
                Write-Host "Error: Failed to verify scheduled tasks" -ForegroundColor Red
                Write-Host
                Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(77)B. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTasks"
                Exit-CaTScheduler
                Exit
            }
        }
        elseif ($HasBeenChecked -eq 1)
        {
            $TaskNamesArray = @()

            $TaskNamesArray = Write-ScheduledTasks

            [Int]$TaskNamesArrayCount = $TaskNamesArray.Count

            if ($TaskNamesArrayCount -gt 0)
            {
                Get-UserDeleteChoice -NumberOfChoices $TaskNamesArrayCount -TaskArray $TaskNamesArray
            }
            elseif (($TaskNamesArrayCount -eq $null) -or ($TaskNamesArrayCount -eq 0))
            {
                Write-Host "There are no scheduled backups"
                Write-Host
                Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(77)C. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTasks"
                Exit-CaTScheduler
                Exit
            }
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(77)D. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTasks | Variable HasBeenChecked: $HasBeenChecked (Should equal 0 or 1)"
            Exit-CaTScheduler
            Exit
        }
    }

    function Remove-Task
    {
        Unregister-ScheduledTask -TaskName $NameOfSelection -Confirm:$false

        return $true
    }

    if ($OperationChoice -eq 1)
    {
        if ($LogType -eq 1)
        {
            [Bool]$WriteToLog = Write-Log
        }
        elseif ($LogType -eq 2)
        {
            [Bool]$WriteToLog = Write-Log
        }
        elseif ($LogType -eq 3)
        {
            [Bool]$WriteToLog = Write-Log

            if ($WriteToLog)
            {
                Exit-CaTScheduler
                Exit
            }
            else
            {
                Exit-CaTScheduler
                Exit
            }
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(15)A. Parent Function: Invoke-ReadWrite | Child Function: Write-Log | Variable OperationChoice: $OperationChoice (Should equal 1) | Variable LogType: $LogType (Should equal 1, 2, 3)"
            Exit-CaTScheduler
            Exit
        }
    }
    elseif ($OperationChoice -eq 2)
    {
        [Bool]$WritePaths = Write-PathStatements

        if ($WritePaths -eq $true)
        {
            if (-not $TotalArrayReadWrite -or $TotalArrayReadWrite.Count -eq 0)
            {
                Set-Input -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -PathStatementInput $PathStatementReadWrite
            }
            elseif ($TotalArrayReadWrite.Count -eq 2)
            {
                Set-Input -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -TotalArrayInput $TotalArrayReadWrite -PathStatementInput $PathStatementReadWrite
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(15)B. Parent Function: Invoke-ReadWrite | Child Function: Write-PathStatements | Variable OperationChoice: $OperationChoice (Should equal 2) | Variable WritePaths: $WritePaths (Should equal true) | Variable TotalArrayReadWrite Count: $TheCountReadWrite (Should equal 0 or 2)"
                Exit-CaTScheduler
                Exit
            }
        }
        elseif (-not($WritePaths -eq $true))
        {
            if (-not $TotalArrayReadWrite -or $TotalArrayReadWrite.Count -eq 0)
            {
                Set-Input -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -PathStatementInput $PathStatementReadWrite -NewOrSavedInput $NewOrSavedReadWrite
            }
            elseif ($TotalArrayReadWrite.Count -eq 2)
            {
                Set-Input -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -TotalArrayInput $TotalArrayReadWrite -PathStatementInput $PathStatementReadWrite -NewOrSavedInput $NewOrSavedReadWrite
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(15)C. Parent Function: Invoke-ReadWrite | Child Function: Write-PathStatements | Variable OperationChoice: $OperationChoice (Should equal 2) | Variable WritePaths: $WritePaths (Should equal not true) | Variable TotalArrayReadWrite Count: $TheCountReadWrite (Should equal 0 or 2)"
                Exit-CaTScheduler
                Exit
            }
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(15)D. Parent Function: Invoke-ReadWrite | Child Function: Write-PathStatements | Variable OperationChoice: $OperationChoice (Should equal 2) | Variable WritePaths: $WritePaths (Should equal true or false)"
            Exit-CaTScheduler
            Exit
        }
    }
    elseif ($OperationChoice -eq 3)
    {
        if ($SourceOrDest -eq 1)
        {
            Get-PathStatements
        }
        elseif (($SourceOrDest -eq 2) -or ($SourceOrDest -eq 3))
        {
            $HashtableDataReadWrite = Get-Content -Path $SavedPathsPathReadWrite | ConvertFrom-Json

            foreach ($Entry in $HashtableDataReadWrite)
            {
                $PathHashTableReadWrite[$Entry.Name] = $Entry.Value
            }

            if ($SourceOrDest -eq 2) #Needs to check if the path statement is good, and send back if not. also it will not go backward. and "do you want to make another" goes to type in path.
            {
                [String]$XSourcePathItemX = $PathHashTableReadWrite[$UserInputReadWrite]

                if (((($XSourcePathItemX.StartsWith('"') -and $XSourcePathItemX.EndsWith('"')) -or (($XSourcePathItemX.StartsWith('"')) -or ($XSourcePathItemX.EndsWith('"')))) -or ($XSourcePathItemX.StartsWith("'") -and $XSourcePathItemX.EndsWith("'"))) -or (($XSourcePathItemX.StartsWith("'")) -or ($XSourcePathItemX.EndsWith("'"))))
                {
                    $SourcePathItem = $XSourcePathItemX.Trim('"', "'" )
                }

                [Bool]$IsItGoodStatement = Test-Path -Path $SourcePathItem

                if ($IsItGoodStatement -eq $true)
                {
                    Get-PathStatements
                }
                elseif ($IsItGoodStatement -eq $false) #Do you want to create this folder?
                {
                    Write-Host "Error: The chosen path does not exist. Please choose a valid path statement." -ForegroundColor Red
                    Write-Host
                    $SourcePathItem = ""
                    $SourceOrDest = 1
                    Get-PathStatements
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(53)A. Parent Function: Invoke-ReadWrite | Variable OperationChoice: $OperationChoice (Should equal 3)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($SourceOrDest -eq 3)
            {
                [String]$XDestinationPathItemX = $PathHashTableReadWrite[$UserInputReadWrite]

                if (((($XDestinationPathItemX.StartsWith('"') -and $XDestinationPathItemX.EndsWith('"')) -or (($XDestinationPathItemX.StartsWith('"')) -or ($XDestinationPathItemX.EndsWith('"')))) -or ($XDestinationPathItemX.StartsWith("'") -and $XDestinationPathItemX.EndsWith("'"))) -or (($XDestinationPathItemX.StartsWith("'")) -or ($XDestinationPathItemX.EndsWith("'"))))
                {
                    $DestinationPathItem = $XDestinationPathItemX.Trim('"', "'" )
                }

                [Bool]$IsItGoodStatement = Test-Path -Path $DestinationPathItem -PathType Container

                if ($IsItGoodStatement -eq $true)
                {
                    $SourceOrDest = 0
                    $PrintHashTable = 1
                    Get-PathStatements
                }
                elseif ($IsItGoodStatement -eq $false) #Do you want to create this folder?
                {
                    [Bool]$IsItGoodStatementTwo = Test-Path -Path $DestinationPathItem

                    if ($IsItGoodStatementTwo -eq $false)
                    {
                        Write-Host
                        Write-Host "Error: The chosen path does not exist. Please choose a valid path statement." -ForegroundColor Red
                        Write-Host
                        $DestinationPathItem = ""
                        $SourceOrDest = 2
                        Get-PathStatements
                    }
                    elseif ($IsItGoodStatementTwo -eq $true)
                    {
                        [Bool]$IsItGoodPathThree = Test-Path -Path $DestinationPathItem -PathType Container

                        if ($IsItGoodPathThree -eq $false)
                        {
                            Write-Host
                            Write-Host "Error: The chosen path is not valid. A file cannot be used as the destination path." -ForegroundColor Red
                            Write-Host
                            $DestinationPathItem = ""
                            $SourceOrDest = 2
                            Get-PathStatements
                        }
                        elseif ($IsItGoodPathThree -eq $true)
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(80)A. Parent Function Invoke-ReadWrite"
                            Exit-CaTScheduler
                            Exit
                        }
                        else
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(80)B. Parent Function Invoke-ReadWrite"
                            Exit-CaTScheduler
                            Exit
                        }
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(80)C. Parent Function Invoke-ReadWrite"
                        Exit-CaTScheduler
                        Exit
                    }
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(53)B. Parent Function: Invoke-ReadWrite | Variable OperationChoice: $OperationChoice (Should equal 3)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(53)C. Parent Function: Invoke-ReadWrite | Variable OperationChoice: $OperationChoice (Should equal 3)"
                Exit-CaTScheduler
                Exit
            }
        }
    }
    elseif ($OperationChoice -eq 4)
    {
        if (($TaskForDeletion -eq "") -or ($TaskForDeletion -eq $null))
        {
            Get-TheScheduledTasks
        }
        elseif ((-not ($TaskForDeletion -eq "")) -or (-not ($TaskForDeletion -eq $null)))
        {
            [Bool]$GoodRemove = Remove-Task

            if ($GoodRemove -eq $true)
            {
                Write-Host "Taskname $NameOfSelection deleted sucessfully" -ForegroundColor Yellow
                Write-Host
            }
            elseif (-not ($GoodRemove -eq $true))
            {
                Write-Host "Taskname $NameOfSelection was not deleted sucessfully" -ForegroundColor Yellow
                Write-Host
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(78)A. Parent Function: Invoke-ReadWrite | Variable GoodRemove: $GoodRemove (Should be true or not true)"
                Exit-CaTScheduler
                Exit
            }

            [String]$GetTasksScriptPath = "$PathStatementReadWrite\GetScheduledTasks.ps1"
            Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -WindowStyle Hidden -File `"$GetTasksScriptPath`"" -WindowStyle Hidden -Verb RunAs

            Get-TheScheduledTasks
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(78)A. Parent Function: Invoke-ReadWrite | Variable TaskForDeletion: $TaskForDeletion (Should equal null or not null)"
            Exit-CaTScheduler
            Exit
        }
    }
    else
    {
        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(53)A. Parent Function: Invoke-ReadWrite | Variable OperationChoice: $OperationChoice (Should not equal 1 - 3)"
        Exit-CaTScheduler
        Exit
    }
}

Export-ModuleMember -Function Invoke-ReadWrite
