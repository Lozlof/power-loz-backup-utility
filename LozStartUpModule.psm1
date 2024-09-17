# Posted on wiki

function Start-CaTScheduler
{
    param
    (
        $ErrorActionPreference = "Stop",
        $InformationPreference = "Continue",
        [String]$PathStatementStartup = "",
        [Int]$Start = $null
    )

    function Start-Logs
    {
        [String]$LogDirectoryPath = "$PathStatementStartup\PowerLozLogs"
        [Bool]$LogDirectoryTest = Test-Path -Path $LogDirectoryPath -PathType Container

        if ($LogDirectoryTest -eq $false)
        {
            New-Item -Path $LogDirectoryPath -ItemType "directory" -Force
            [Int]$LogDirCreate = 1
        }
        else
        {
            [Int]$LogDirCreate = 0
        }

        [String]$ErrorLogPath = "$PathStatementStartup\PowerLozLogs\LozErrorLog.log"
        [Bool]$ErrorLogTest = Test-Path -Path $ErrorLogPath -PathType Leaf

        if ($ErrorLogTest -eq $false)
        {
            New-Item -Path $ErrorLogPath -ItemType "File" -Force
            [Int]$ErrorLogCreate = 1
        }
        else
        {
            [Int]$ErrorLogCreate = 0
        }

        [String]$InfoLogPath = "$PathStatementStartup\PowerLozLogs\LozInfoLog.log"
        [Bool]$InfoLogTest = Test-Path -Path $InfoLogPath -PathType Leaf

        if ($InfoLogTest -eq $false)
        {
            New-Item -Path $InfoLogPath -ItemType "File" -Force
            [Int]$InfoLogCreate = 1
        }
        else
        {
            [Int]$InfoLogCreate = 0
        }

        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) Function Get-StartupItems executed sucessfully. Startup script successful."

        if (($LogDirCreate -eq 1) -or ($LogDirCreate -eq 0))
        {
            if ($LogDirCreate -eq 1)
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 2 -Message "(Startup) Created $LogDirectoryPath because the path did not exist on start up. Function: Start-CaTScheduler"
            }
            elseif ($LogDirCreate -eq 0)
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) $LogDirectoryPath good. Function: Start-CaTScheduler"
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 3 -Message "(82)A. Parent Function: Start-CaTScheduler | Variable LogDirCreate: $LogDirCreate (Should equal 0 or 1)"
                Exit-CaTScheduler
                Exit
            }
        }

        if (($ErrorLogCreate -eq 1) -or ($ErrorLogCreate -eq 0))
        {
            if ($ErrorLogCreate -eq 1)
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 2 -Message "(Startup) Created $ErrorLogPath because the path did not exist on start up. Function: Start-CaTScheduler"
            }
            elseif ($ErrorLogCreate -eq 0)
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) $ErrorLogPath good. Function: Start-CaTScheduler"
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 3 -Message "(82)B. Parent Function: Start-CaTScheduler | Variable ErrorLogCreate: $ErrorLogCreate (Should equal 0 or 1)"
                Exit-CaTScheduler
                Exit
            }
        }

        if (($InfoLogCreate -eq 1) -or ($InfoLogCreate -eq 0))
        {
            if ($InfoLogCreate -eq 1)
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 2 -Message "(Startup) Created $InfoLogPath because the path did not exist on start up. Function: Start-CaTScheduler"
            }
            elseif ($InfoLogCreate -eq 0)
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) $InfoLogPath good. Function: Start-CaTScheduler"
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 3 -Message "(82)C. Parent Function: Start-CaTScheduler | Variable InfoLogCreate: $InfoLogCreate (Should equal 0 or 1)"
                Exit-CaTScheduler
                Exit
            }
        }

        return $true
    }

    function Start-ConfigurationFiles
    {
        [String]$ConfigDirectoryPath = "$PathStatementStartup\PowerLozConfigurationFiles"
        [Bool]$ConfigDirectoryTest = Test-Path -Path $ConfigDirectoryPath -PathType Container

        if ($ConfigDirectoryTest -eq $false)
        {
            New-Item -Path $ConfigDirectoryPath -ItemType "directory" -Force

            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 2 -Message "(Startup) Created $ConfigDirectoryPath because the path did not exist on start up. Function: Start-CaTScheduler"
        }
        elseif ($ConfigDirectoryTest -eq $true)
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) $ConfigDirectoryPath good. Function: Start-CaTScheduler"
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 3 -Message "(83)A. Parent Function: Start-CaTScheduler | Variable ConfigDirectoryTest: $ConfigDirectoryTest (Should equal true or false)"
            Exit-CaTScheduler
            Exit
        }

        [String]$SavedPathsPath = "$PathStatementStartup\PowerLozConfigurationFiles\LozSavedPaths.json"
        [Bool]$SavedPathsTest = Test-Path -Path $SavedPathsPath -PathType Leaf

        if ($SavedPathsTest -eq $false)
        {
            New-Item -Path $SavedPathsPath -ItemType "File" -Force

            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 2 -Message "(Startup) Created $SavedPathsPath because the path did not exist on start up. Function: Start-CaTScheduler"
        }
        elseif ($SavedPathsTest -eq $true)
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) $SavedPathsPath good. Function: Start-CaTScheduler"
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 3 -Message "(83)B. Parent Function: Start-CaTScheduler | Variable SavedPathsTest: $SavedPathsTest (Should equal true or false)"
            Exit-CaTScheduler
            Exit
        }

        [String]$TaskNumberPath = "$PathStatementStartup\PowerLozConfigurationFiles\LozTaskNumber.txt"
        [Bool]$TaskNumberTest = Test-Path -Path $TaskNumberPath -PathType Leaf

        if ($TaskNumberTest -eq $false)
        {
            New-Item -Path $TaskNumberPath -ItemType "File" -Force

            0 | Out-File -FilePath $TaskNumberPath

            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 2 -Message "(Startup) Created $TaskNumberPath because the path did not exist on start up. Function: Start-CaTScheduler"
        }
        elseif ($TaskNumberTest -eq $true)
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) $TaskNumberPath good. Function: Start-CaTScheduler"
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 3 -Message "(83)C. Parent Function: Start-CaTScheduler | Variable TaskNumberTest: $TaskNumberTest (Should equal true or false)"
            Exit-CaTScheduler
            Exit
        }

        [String]$ScheduledTasksPath = "$PathStatementStartup\PowerLozConfigurationFiles\LozScheduledTasks.json"
        [Bool]$ScheduledTasksTest = Test-Path -Path $ScheduledTasksPath -PathType Leaf

        if ($ScheduledTasksTest -eq $false)
        {
            New-Item -Path $ScheduledTasksPath -ItemType "File" -Force

            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 2 -Message "(Startup) Created $ScheduledTasksPath because the path did not exist on start up. Function: Start-CaTScheduler"
        }
        elseif ($ScheduledTasksTest -eq $true)
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) $ScheduledTasksPath good. Function: Start-CaTScheduler"
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 3 -Message "(83)D. Parent Function: Start-CaTScheduler | Variable ScheduledTasksTest: $ScheduledTasksTest (Should equal true or false)"
            Exit-CaTScheduler
            Exit
        }

        return $true
    }

    function Start-ScheduledTaskScript
    {
        [String]$GetTasksScriptPath = "$PathStatementStartup\LozFindScheduledTasks.ps1"
        Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -WindowStyle Hidden -File `"$GetTasksScriptPath`"" -WindowStyle Hidden -Verb RunAs

        return $true
    }

    function Get-NewOrSaved
    {
        [String]$SavedPathsPath = "$PathStatementStartup\PowerLozConfigurationFiles\LozSavedPaths.json"
        $HashtableDataStartup = Get-Content -Path $SavedPathsPath | ConvertFrom-Json
        $PathHashTableStartup = @{}

        foreach ($Item in $HashtableDataStartup)
        {
            $PathHashTableStartup[$Item.Name] = $Item.Value
        }

        if ($PathHashTableStartup.Count -eq 0)
        {
            [Int]$NewOrSavedStartup = 1
        }
        elseif ($PathHashTableStartup.Count -gt 0)
        {
            [Int]$NewOrSavedStartup = 0
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 2 -Message "(Startup) General error. Function: Start-CaTScheduler | Variable PathHashTableStartup ($PathHashTableStartup) is not equal to 0 or greater than 0."
        }

        return $NewOrSavedStartup
    }

    [String]$ErrorTwo = "Startup failed"

    if ($Start -eq 1)
    {
        [Bool]$LogsGood = Start-Logs

        if ($LogsGood -eq $true)
        {
            [Bool]$ConfigGood = Start-ConfigurationFiles

            if ($ConfigGood -eq $true)
            {
                [Bool]$ScriptGood = Start-ScheduledTaskScript

                if ($ScriptGood -eq $true)
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) Script GetScheduledTasks.ps1 started sucessfully"

                    [Int]$NewOrSavedStartup = Get-NewOrSaved

                    if (($NewOrSavedStartup -eq 1) -or ($NewOrSavedStartup -eq 0))
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementStartup -LogType 1 -Message "(Startup) Function Start-CaTScheduler executed sucessfully. Startup module successful."

                        Get-Menu -ChooseMenu 1 -PathStatementMenu $PathStatementStartup -NewOrSavedMenu $NewOrSavedStartup
                    }
                    else
                    {
                        Write-Error -Message "$ErrorTwo"
                        Exit
                    }
                }
                else
                {
                    Write-Error -Message "$ErrorTwo"
                    Exit
                }
            }
            else
            {
                Write-Error -Message "$ErrorTwo"
                Exit
            }
        }
        else
        {
            Write-Error -Message "$ErrorTwo"
            Exit
        }
    }
    else
    {
        Write-Error -Message "$ErrorTwo"
        Exit
    }
}

Function Exit-CaTScheduler
{
    Write-Information -MessageData ""

    [Console]::ForegroundColor = [ConsoleColor]::Cyan
    Write-Information -MessageData "Thank you for using Power-Loz as your backup utility."
    Write-Information -MessageData "Have a nice day!"
    [Console]::ResetColor()

    Start-Sleep -Seconds 3

    Exit
}

Export-ModuleMember -Function Start-CaTScheduler, Exit-CaTScheduler
