# Posted on Wiki

function Invoke-ReadWrite
{
    param
    (
        $InformationPreference = "Continue",
        $WarningPreference = "Continue",
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

    function Write-LozLog
    {
        $LogFileOne = "$PathStatementReadWrite\PowerLozLogs\LozInfoLog.log"
        $LogFileTwo = "$PathStatementReadWrite\PowerLozLogs\LozErrorLog.log"
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
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(11)A. Parent Function: Invoke-ReadWrite | Child Function: Write-LozLog | Variable LogType: $LogType (Should equal 1, 2, or 3)"
            Exit-CaTScheduler
            Exit
        }
    }

    function Write-PathStatement
    {
        $SavedPathsPathReadWrite = "$PathStatementReadWrite\PowerLozConfigurationFiles\LozSavedPaths.json"
        $PathHashTableReadWrite = @{}

        if (Test-Path -Path $SavedPathsPathReadWrite)
        {
            $HashtableDataReadWrite = Get-Content -Path $SavedPathsPathReadWrite | ConvertFrom-Json
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule) Variable SavedPathsPathReadWrite ($SavedPathsPathReadWrite) does not exist therefore exited Write-PathStatement"

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

    function Get-PathStatement
    {
        [String]$SavedPathsPathReadWrite = "$PathStatementReadWrite\PowerLozConfigurationFiles\LozSavedPaths.json"

        if (($PrintHashTable -eq 0) -or ($null -eq $PrintHashTable))
        {
            if (Test-Path -Path $SavedPathsPathReadWrite)
            {
                $HashtableDataReadWrite = Get-Content -Path $SavedPathsPathReadWrite | ConvertFrom-Json
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule). Variable SavedPathsPathReadWrite ($SavedPathsPathReadWrite) does not exist therefore exited Get-PathStatement"
                return $false #redirect somewhere
            }

            foreach ($Entry in $HashtableDataReadWrite)
            {
                $PathHashTableReadWrite[$Entry.Name] = $Entry.Value
            }

            [Int]$TotalKeys = $PathHashTableReadWrite.Count

            [Console]::ForegroundColor = [ConsoleColor]::Cyan
            Write-Information -MessageData "Saved path statements:"
            [Console]::ResetColor()

            foreach ($Key in $PathHashTableReadWrite.Keys)
            {
                Write-Information -MessageData "$Key. $($PathHashTableReadWrite[$Key])"
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
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)A. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatement"
                Exit-CaTScheduler
                Exit
            }

            Write-Information -MessageData "Choose the $DirType"

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
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)B. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatement"
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
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)C. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatement"
                    Exit-CaTScheduler
                    Exit
                }
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)C. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatement"
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
                    Get-SomeInput -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -PathStatementInput $PathStatementReadWrite -GetPathsFromInput 1
                }
                elseif ($TotalArrayReadWrite.Count -eq 2)
                {
                    Get-SomeInput -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -TotalArrayInput $TotalArrayReadWrite -PathStatementInput $PathStatementReadWrite -GetPathsFromInput 1
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)D. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatement"
                    Exit-CaTScheduler
                    Exit
                }
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)E. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatement"
                Exit-CaTScheduler
                Exit
            }
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(52)F. Parent Function: Invoke-ReadWrite | Child Function: Get-PathStatement"
            Exit-CaTScheduler
            Exit
        }
    }

    function Get-TheScheduledTask
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

                [String]$WarningOne = "The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back."

                $UserInputX = Read-Host "Choice"
                Write-Information -MessageData ""

                if ($UserInputX -eq "")
                {
                    $WarningOne | Write-Warning
                    Write-Information -MessageData ""

                    if ($GoBackControl -eq 1)
                    {
                        Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                    }
                    else
                    {
                        Get-TheScheduledTask -HasBeenChecked 1
                    }
                }

                [Bool]$IsItAnInteger = [Int]::TryParse($UserInputX, [ref]$null)

                if (-not $IsItAnInteger)
                {
                    $WarningOne | Write-Warning
                    Write-Information -MessageData ""

                    if ($GoBackControl -eq 1)
                    {
                        Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                    }
                    else
                    {
                        Get-TheScheduledTask -HasBeenChecked 1
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
                        $WarningOne | Write-Warning
                        Write-Information -MessageData ""

                        if ($GoBackControl -eq 1)
                        {
                            Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                        }
                        else
                        {
                            Get-TheScheduledTask -HasBeenChecked 1
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
                        Get-TheScheduledTask -HasBeenChecked 1
                    }
                    else
                    {
                        Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
                    }
                }
                elseif (($UserInput -lt 0) -or ($UserInput -gt $NumberOfChoices))
                {
                    $WarningOne | Write-Warning
                    Write-Information -MessageData ""

                    if ($GoBackControl -eq 1)
                    {
                        Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                    }
                    else
                    {
                        Get-TheScheduledTask -HasBeenChecked 1
                    }
                }
                else
                {
                    $WarningOne | Write-Warning
                    Write-Information -MessageData ""

                    if ($GoBackControl -eq 1)
                    {
                        Get-UserDeleteChoice -ContinueTheLoop $ContinueTheLoop -TaskArray $TaskArray
                    }
                    else
                    {
                        Get-TheScheduledTask -HasBeenChecked 1
                    }
                }
            }

            while ($ContinueTheLoop -eq 0)
            {
                Write-Information -MessageData "Choose the backup that you want to delete"
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
                Write-Information -MessageData "There are no scheduled backups"
                Write-Information -MessageData ""
                Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(74)A. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTask | Child Function: Get-UserDeleteChoice"
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
                Write-Information -MessageData "$TheWordsThree"
                Write-Information -MessageData "1. Yes"
                Write-Information -MessageData "2. No"
                $ContinueTheLoopTwo = Get-UserInput -ContinueTheLoop $ContinueTheLoop
            }

            [Int]$UserSelectionChoiceTwo = $ContinueTheLoopTwo

            if ($UserSelectionChoiceTwo -eq 1)
            {
                Invoke-ReadWrite -OperationChoice 4 -PathStatementReadWrite $PathStatementReadWrite -NewOrSavedReadWrite $NewOrSavedReadWrite -TaskForDeletion $NameOfSelection
            }
            elseif ($UserSelectionChoiceTwo -eq 2)
            {
                Get-TheScheduledTask -HasBeenChecked 1
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(74)B. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTask | Child Function: Get-UserDeleteChoice | Variable UserSelectionChoiceTwo: $UserSelectionChoiceTwo (Should equal 1 or 2)"
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
                } | Where-Object { $_.CommandLine -like "*LozFindScheduledTasks*" } | Sort-Object -Property CommandLine

                if (($null -eq $FilteredProcesses) -or ($FilteredProcesses -eq ""))
                {
                    $ContinueLooking = 0
                }
                elseif ((-not ($null -eq $FilteredProcesses)) -or (-not ($FilteredProcesses -eq "")))
                {
                    Write-Information -MessageData "Loading Scheduled Tasks"
                    Start-Sleep -Seconds 2
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(75)A. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTask | Child Function: Test-IfFinished"
                    Exit-CaTScheduler
                    Exit
                }
            }

            if ($ContinueLooking -eq 0)
            {
                Write-Information -MessageData "Done loading"
                Write-Information -MessageData ""

                return $true
            }
        }

        function Write-ScheduledTask
        {
            [String]$GetTasksFilePath = "$PathStatementReadWrite\PowerLozConfigurationFiles\LozScheduledTasks.json"
            [String]$WarningSix = "ScheduledTasks.json cannot be found"

            if (Test-Path -Path $GetTasksFilePath)
            {
                $TasksHashTable = Get-Content -Path $GetTasksFilePath | ConvertFrom-Json
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule) Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTask | Child Function: Write-ScheduledTask | ScheduledTasks.json cannot be accessed. Variable GetTasksFilePath: $GetTasksFilePath"
                $WarningSix | Write-Warning
                Write-Information -MessageData ""
                Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
            }

            $ScheduledTasksHashTable = @{}

            foreach ($Entry in $TasksHashTable.PSObject.Properties)
            {
                $ScheduledTasksHashTable[$Entry.Name] = $Entry.Value
            }

            [Int]$BackupNumber = 1
            $TaskNameArray = @()

            Write-Information -MessageData "Scheduled backups"

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

                Write-Information -MessageData "$BackupNumber. $DetailsOne"
                Write-Information -MessageData "   $DetailsTwo"
                Write-Information -MessageData "   $DetailsThree"
                Write-Information -MessageData ""

                $TaskNameArray += $DetailsOne

                $BackupNumber = $BackupNumber + 1
            }

            return $TaskNameArray
        }

        if (($null -eq $HasBeenChecked) -or ($HasBeenChecked -eq 0))
        {
            [Bool]$IsItDone = Test-IfFinished

            if ($IsItDone -eq $true)
            {
                $TaskNamesArray = @()

                $TaskNamesArray = Write-ScheduledTask

                [Int]$TaskNamesArrayCount = $TaskNamesArray.Count

                if ($TaskNamesArrayCount -gt 0)
                {
                    Get-UserDeleteChoice -NumberOfChoices $TaskNamesArrayCount -TaskArray $TaskNamesArray
                }
                elseif (($null -eq $TaskNamesArrayCount) -or ($TaskNamesArrayCount -eq 0))
                {
                    Write-Information -MessageData "There are no scheduled backups"
                    Write-Information -MessageData ""
                    Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(77)A. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTask | Child Function:  Write-ScheduledTask"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif (-not ($IsItDone -eq $true))
            {
                [String]$WarningSeven = "Failed to verify scheduled tasks"

                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 2 -Message "(ReadWriteModule) Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTask | Function Test-IfFinished failed to return true"

                $WarningSeven | Write-Warning
                Write-Information -MessageData ""
                Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(77)B. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTask"
                Exit-CaTScheduler
                Exit
            }
        }
        elseif ($HasBeenChecked -eq 1)
        {
            $TaskNamesArray = @()

            $TaskNamesArray = Write-ScheduledTask

            [Int]$TaskNamesArrayCount = $TaskNamesArray.Count

            if ($TaskNamesArrayCount -gt 0)
            {
                Get-UserDeleteChoice -NumberOfChoices $TaskNamesArrayCount -TaskArray $TaskNamesArray
            }
            elseif (($null -eq $TaskNamesArrayCount) -or ($TaskNamesArrayCount -eq 0))
            {
                Write-Information -MessageData "There are no scheduled backups"
                Write-Information -MessageData ""
                Start-CaTScheduler -PathStatementStartup $PathStatementReadWrite -Start 1
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(77)C. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTask"
                Exit-CaTScheduler
                Exit
            }
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(77)D. Parent Function: Invoke-ReadWrite | Child Function: Get-TheScheduledTask | Variable HasBeenChecked: $HasBeenChecked (Should equal 0 or 1)"
            Exit-CaTScheduler
            Exit
        }
    }

    function Get-RemoveTask
    {
        Unregister-ScheduledTask -TaskName $NameOfSelection -Confirm:$false

        return $true
    }

    if ($OperationChoice -eq 1)
    {
        if ($LogType -eq 1)
        {
            [Bool]$WriteToLog = Write-LozLog
        }
        elseif ($LogType -eq 2)
        {
            [Bool]$WriteToLog = Write-LozLog
        }
        elseif ($LogType -eq 3)
        {
            [Bool]$WriteToLog = Write-LozLog

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
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(15)A. Parent Function: Invoke-ReadWrite | Child Function: Write-LozLog | Variable OperationChoice: $OperationChoice (Should equal 1) | Variable LogType: $LogType (Should equal 1, 2, 3)"
            Exit-CaTScheduler
            Exit
        }
    }
    elseif ($OperationChoice -eq 2)
    {
        [Bool]$WritePaths = Write-PathStatement

        if ($WritePaths -eq $true)
        {
            if (-not $TotalArrayReadWrite -or $TotalArrayReadWrite.Count -eq 0)
            {
                Get-SomeInput -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -PathStatementInput $PathStatementReadWrite
            }
            elseif ($TotalArrayReadWrite.Count -eq 2)
            {
                Get-SomeInput -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -TotalArrayInput $TotalArrayReadWrite -PathStatementInput $PathStatementReadWrite
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(15)B. Parent Function: Invoke-ReadWrite | Child Function: Write-PathStatement | Variable OperationChoice: $OperationChoice (Should equal 2) | Variable WritePaths: $WritePaths (Should equal true) | Variable TotalArrayReadWrite Count: $TheCountReadWrite (Should equal 0 or 2)"
                Exit-CaTScheduler
                Exit
            }
        }
        elseif (-not($WritePaths -eq $true))
        {
            if (-not $TotalArrayReadWrite -or $TotalArrayReadWrite.Count -eq 0)
            {
                Get-SomeInput -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -PathStatementInput $PathStatementReadWrite -NewOrSavedInput $NewOrSavedReadWrite
            }
            elseif ($TotalArrayReadWrite.Count -eq 2)
            {
                Get-SomeInput -ChooseMenuX 2 -SourceDirectory $SourcePathItem -DestinationDirectory $DestinationPathItem -TypeOfBackupX $TypeOfBackupReadWrite -TotalArrayInput $TotalArrayReadWrite -PathStatementInput $PathStatementReadWrite -NewOrSavedInput $NewOrSavedReadWrite
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(15)C. Parent Function: Invoke-ReadWrite | Child Function: Write-PathStatement | Variable OperationChoice: $OperationChoice (Should equal 2) | Variable WritePaths: $WritePaths (Should equal not true) | Variable TotalArrayReadWrite Count: $TheCountReadWrite (Should equal 0 or 2)"
                Exit-CaTScheduler
                Exit
            }
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(15)D. Parent Function: Invoke-ReadWrite | Child Function: Write-PathStatement | Variable OperationChoice: $OperationChoice (Should equal 2) | Variable WritePaths: $WritePaths (Should equal true or false)"
            Exit-CaTScheduler
            Exit
        }
    }
    elseif ($OperationChoice -eq 3)
    {
        [String]$WarningEight = "The chosen path does not exist. Please choose a valid path statement."
        [String]$WarningNine = "The chosen path is not valid. A file cannot be used as the destination path."

        if ($SourceOrDest -eq 1)
        {
            Get-PathStatement
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
                    Get-PathStatement
                }
                elseif ($IsItGoodStatement -eq $false) #Do you want to create this folder?
                {
                    $WarningEight | Write-Warning
                    Write-Information -MessageData ""

                    $SourcePathItem = ""
                    $SourceOrDest = 1
                    Get-PathStatement
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
                    Get-PathStatement
                }
                elseif ($IsItGoodStatement -eq $false) #Do you want to create this folder?
                {
                    [Bool]$IsItGoodStatementTwo = Test-Path -Path $DestinationPathItem

                    if ($IsItGoodStatementTwo -eq $false)
                    {
                        Write-Information -MessageData ""
                        $WarningEight | Write-Warning
                        Write-Information -MessageData ""

                        $DestinationPathItem = ""
                        $SourceOrDest = 2
                        Get-PathStatement
                    }
                    elseif ($IsItGoodStatementTwo -eq $true)
                    {
                        [Bool]$IsItGoodPathThree = Test-Path -Path $DestinationPathItem -PathType Container

                        if ($IsItGoodPathThree -eq $false)
                        {
                            Write-Information -MessageData ""
                            $WarningNine | Write-Warning
                            Write-Information -MessageData ""

                            $DestinationPathItem = ""
                            $SourceOrDest = 2
                            Get-PathStatement
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
        if (($TaskForDeletion -eq "") -or ($null -eq $TaskForDeletion))
        {
            Get-TheScheduledTask
        }
        elseif ((-not ($TaskForDeletion -eq "")) -or (-not ($null -eq $TaskForDeletion)))
        {
            [Bool]$GoodRemove = Get-RemoveTask

            if ($GoodRemove -eq $true)
            {
                [Console]::ForegroundColor = [ConsoleColor]::Cyan
                Write-Information -MessageData "Taskname $NameOfSelection deleted sucessfully"
                [Console]::ResetColor()

                Write-Information -MessageData ""
            }
            elseif (-not ($GoodRemove -eq $true))
            {
                [Console]::ForegroundColor = [ConsoleColor]::Red
                Write-Information -MessageData "Taskname $NameOfSelection was not deleted sucessfully"
                [Console]::ResetColor()

                Write-Information -MessageData ""
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementReadWrite -LogType 3 -Message "(78)A. Parent Function: Invoke-ReadWrite | Variable GoodRemove: $GoodRemove (Should be true or not true)"
                Exit-CaTScheduler
                Exit
            }

            [String]$GetTasksScriptPath = "$PathStatementReadWrite\LozFindScheduledTasks.ps1"

            Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -WindowStyle Hidden -File `"$GetTasksScriptPath`"" -WindowStyle Hidden -Verb RunAs

            Get-TheScheduledTask -HasBeenChecked 0
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
