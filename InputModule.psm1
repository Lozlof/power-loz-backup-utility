

function Set-Input
{
    param
    (
        [Int]$ChooseMenuX = $null,
        [Int]$TypeOfBackupX = $null,
        [Object[][]]$TotalArrayInput = @(),
        [Int]$GoBack = $null,
        [Int]$ContinueLoopOne = $null,
        [Int]$ContinueLoopTwo = $null,
        [String]$SourceDirectory = "",
        [String]$DestinationDirectory = "",
        [String]$PathStatementInput = "",
        [Int]$NewOrSavedInput = $null,
        [Int]$GetPathsFromInput = $null
    )

    [Int]$TheCountInput = $TotalArrayInput.Count
    #Write-Host "Debug: Function: Set-Input | ChooseMenuX: $ChooseMenuX | TypeOfBackupX: $TypeOfBackupX | TotalArrayInput: $($TotalArrayInput | ForEach-Object { $_ -join ', ' }) | GoBack: $GoBack | ContinueLoopOne: $ContinueLoopOne | ContinueLoopTwo: $ContinueLoopTwo | SourceDirectory: $SourceDirectory | DestinationDirectory: $DestinationDirectory | TotalArrayInput Count: $TheCountInput | PathStatementInput: $PathStatementInput | NewOrSavedInput: $NewOrSavedInput" -ForegroundColor Green

    function Get-Path
    {
        while ($ContinueLoopOne -eq 0)
        {
            Write-Host "Enter the source directory or file"

            $SourceDirX = Read-Host "Your path"
            Write-Host

            if ($SourceDirX -eq "")
            {
                Write-Host "Error: The input given was not valid. Please enter a valid path statement or 0 to go back." -ForegroundColor Red
                Write-Host

                if (-not $TotalArrayInput -or $TotalArrayInput.Count -eq 0)
                {
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 0 -ContinueLoopTwo 0 -TypeOfBackupX $TypeOfBackupX -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                elseif ($TotalArrayInput.Count -eq 2)
                {
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 0 -ContinueLoopTwo 0 -TypeOfBackupX $TypeOfBackupX -TotalArrayInput $TotalArrayInput -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(4)A. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopOne: $ContinueLoopOne (Should equal 0) | Variable TotalArrayInput Count: $TheCountInput (Should equal 0 or 2) | Variable SourceDirX: $SourceDirX (Should equal null)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($SourceDirX -eq 0)
            {
                if ($GoBack -eq 1)
                {
                    if (-not $TotalArrayInput -or $TotalArrayInput.Count -eq 0)
                    {
                        if ($NewOrSavedInput -eq 1)
                        {
                            Get-Menu -ChooseMenu 1 -TypeOfBackup $TypeOfBackupX -PathStatementMenu $PathStatementInput -NewOrSavedMenu $NewOrSavedInput
                        }
                        elseif ($NewOrSavedInput -eq 0)
                        {
                            Get-Menu -ChooseMenu 2 -TypeOfBackup $TypeOfBackupX -PathStatementMenu $PathStatementInput
                        }
                        else
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(17)A. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopOne: $ContinueLoopOne (Should equal 0) | Variable TotalArrayInput Count: $TheCountInput (Should equal 0) | Variable GoBack: $GoBack (Should equal 1) | Variable SourceDirX: $SourceDirX (Should equal 0) | Variable: NewOrSavedInput: $NewOrSavedInput (Should equal 0 or 1)"
                            Exit-CaTScheduler
                            Exit
                        }
                    }
                    elseif ($TotalArrayInput.Count -eq 2)
                    {
                        Get-Menu -ChooseMenu 2 -TypeOfBackup $TypeOfBackupX -TotalArrayMenu $TotalArrayInput -PathStatementMenu $PathStatementInput
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(4)B. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopOne: $ContinueLoopOne (Should equal 0) | Variable TotalArrayInput Count: $TheCountInput (Should equal 0 or 2) | Variable GoBack: $GoBack (Should equal 1) | Variable SourceDirX: $SourceDirX (Should equal 0)"
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($GoBack -eq 2)
                {
                    if (-not $TotalArrayInput -or $TotalArrayInput.Count -eq 0)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackupX -PathStatementMenu $PathStatementInput -NewOrSavedMenu $NewOrSavedInput
                    }
                    elseif ($TotalArrayInput.Count -eq 2)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackupX -TotalArrayMenu $TotalArrayInput -PathStatementMenu $PathStatementInput -NewOrSavedMenu $NewOrSavedInput
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(4)C. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopOne: $ContinueLoopOne (Should equal 0) | Variable TotalArrayInput Count: $TheCountInput (Should equal 0 or 2) | Variable GoBack: $GoBack (Should equal 2) | Variable SourceDirX: $SourceDirX (Should equal 0)"
                        Exit-CaTScheduler
                        Exit
                    }
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(4)D. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopOne: $ContinueLoopOne (Should equal 0) | Variable SourceDirX: $SourceDirX (Should equal 0) | Variable GoBack: $GoBack (Should equal 1 or 2)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif (((($SourceDirX.StartsWith('"') -and $SourceDirX.EndsWith('"')) -or (($SourceDirX.StartsWith('"')) -or ($SourceDirX.EndsWith('"')))) -or ($SourceDirX.StartsWith("'") -and $SourceDirX.EndsWith("'"))) -or (($SourceDirX.StartsWith("'")) -or ($SourceDirX.EndsWith("'"))))
            {
                [String]$SourceDir = $SourceDirX.Trim('"', "'" )
            }
            else
            {
                [String]$SourceDir = [String]$SourceDirX
            }

            [Bool]$IsItGoodPath = Test-Path -Path $SourceDir

            if ($IsItGoodPath -eq $true)
            {
                if (-not $TotalArrayInput -or $TotalArrayInput.Count -eq 0)
                {
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 1 -ContinueLoopTwo 0 -SourceDirectory `"$SourceDir`" -TypeOfBackupX $TypeOfBackupX -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                elseif ($TotalArrayInput.Count -eq 2)
                {
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 1 -ContinueLoopTwo 0 -SourceDirectory `"$SourceDir`" -TypeOfBackupX $TypeOfBackupX -TotalArrayInput $TotalArrayInput -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(5)A. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopOne: $ContinueLoopOne (Should equal 0) | Variable IsItGoodPath: $IsItGoodPath (Should equal true) | Variable TotalArrayInput Count: $TheCountInput (Should equal 0 or 2)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($IsItGoodPath -eq $false)
            {
                Write-Host "Error: The input given was not valid. Please enter a valid path statement or 0 to go back." -ForegroundColor Red
                Write-Host
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(5)B. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopOne: $ContinueLoopOne (Should equal 0) | Variable IsItGoodPath: $IsItGoodPath (Should equal true or false)"
                Exit-CaTScheduler
                Exit
            }
        }

        while ($ContinueLoopTwo -eq 0)
        {
            Write-Host "Enter the destination directory"
            $DestDirX = Read-Host "Your path"

            if ($DestDirX -eq "")
            {
                Write-Host
                Write-Host "Error: The input given was not valid. Please enter a valid path statement or 0 to go back." -ForegroundColor Red
                Write-Host

                if (-not $TotalArrayInput -or $TotalArrayInput.Count -eq 0)
                {
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 1 -ContinueLoopTwo 0 -TypeOfBackupX $TypeOfBackupX -SourceDirectory `"$SourceDir`" -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                elseif ($TotalArrayInput.Count -eq 2)
                {
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 1 -ContinueLoopTwo 0 -TypeOfBackupX $TypeOfBackupX -SourceDirectory `"$SourceDir`" -TotalArrayInput $TotalArrayInput -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(6)A. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopTwo: $ContinueLoopTwo (Should equal 0) | Variable TotalArrayInput Count: $TheCountInput (Should equal 0 or 2) | Variable DestDirX: $DestDirX (Should equal null)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($DestDirX -eq 0)
            {
                if (-not $TotalArrayInput -or $TotalArrayInput.Count -eq 0)
                {
                    Write-Host
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 0 -ContinueLoopTwo 0 -TypeOfBackupX $TypeOfBackupX -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                elseif ($TotalArrayInput.Count -eq 2)
                {
                    Write-Host
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 0 -ContinueLoopTwo 0 -TypeOfBackupX $TypeOfBackupX -TotalArrayInput $TotalArrayInput -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(6)B. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopTwo: $ContinueLoopTwo (Should equal 0) | Variable TotalArrayInput Count: $TheCountInput (Should equal 0 or 2) | Variable DestDirX: $SourceDirX (Should equal 0)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif (((($DestDirX.StartsWith('"') -and $DestDirX.EndsWith('"')) -or (($DestDirX.StartsWith('"')) -or ($DestDirX.EndsWith('"')))) -or ($DestDirX.StartsWith("'") -and $DestDirX.EndsWith("'"))) -or (($DestDirX.StartsWith("'")) -or ($DestDirX.EndsWith("'"))))
            {
                [String]$DestDir = $DestDirX.Trim('"', "'" )
            }
            else
            {
                [String]$DestDir = [String]$DestDirX
            }

            [Bool]$IsItGoodPath = Test-Path -Path $DestDir -PathType Container

            if ($IsItGoodPath -eq $true)
            {
                if (-not $TotalArrayInput -or $TotalArrayInput.Count -eq 0)
                {
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 1 -ContinueLoopTwo 1 -SourceDirectory `"$SourceDir`" -DestinationDirectory `"$DestDir`" -TypeOfBackupX $TypeOfBackupX -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                elseif ($TotalArrayInput.Count -eq 2)
                {
                    Set-Input -ChooseMenuX 1 -GoBack $GoBack -ContinueLoopOne 1 -ContinueLoopTwo 1 -SourceDirectory `"$SourceDir`" -DestinationDirectory `"$DestDir`" -TypeOfBackupX $TypeOfBackupX -TotalArrayInput $TotalArrayInput -PathStatementInput $PathStatementInput -NewOrSavedInput $NewOrSavedInput
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(7)A. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopTwo: $ContinueLoopTwo (Should equal 0) | Variable IsItGoodPath: $IsItGoodPath (Should equal true) | Variable TotalArrayInput Count: $TheCountInput (Should equal 0 or 2)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($IsItGoodPath -eq $false)
            {
                [Bool]$IsItGoodPathTwo = Test-Path -Path $DestDir

                if ($IsItGoodPathTwo -eq $false)
                {
                    Write-Host
                    Write-Host "Error: The input given was not valid. Please enter a valid path statement or 0 to go back." -ForegroundColor Red
                    Write-Host
                }
                elseif ($IsItGoodPathTwo -eq $true)
                {
                    [Bool]$IsItGoodPathThree = Test-Path -Path $DestDir -PathType Container

                    if ($IsItGoodPathThree -eq $false)
                    {
                        Write-Host
                        Write-Host "Error: The input given was not valid. A file cannot be used as the destination path." -ForegroundColor Red
                        Write-Host
                    }
                    elseif ($IsItGoodPathThree -eq $true)
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(79)A. Parent Function: Set-Input | Child Function: Get-Path"
                        Exit-CaTScheduler
                        Exit
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(79)B. Parent Function: Set-Input | Child Function: Get-Path"
                        Exit-CaTScheduler
                        Exit
                    }
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(79)C. Parent Function: Set-Input | Child Function: Get-Path"
                    Exit-CaTScheduler
                    Exit
                }
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(7)B. Parent Function: Set-Input | Child Function: Get-Path | Variable ContinueLoopTwo: $ContinueLoopTwo (Should equal 0) | Variable IsItGoodPath: $IsItGoodPath (Should equal true or false)"
                Exit-CaTScheduler
                Exit
            }
        }

        return $true
    }

    function Set-SourceDestArray
    {
        if ($TotalArrayInput.Count -eq 2)
        {
            $SourceArray = $TotalArrayInput[0]
            $DestArray = $TotalArrayInput[1]

            if (((($SourceDirectory.StartsWith('"') -and $SourceDirectory.EndsWith('"')) -or (($SourceDirectory.StartsWith('"')) -or ($SourceDirectory.EndsWith('"')))) -or ($SourceDirectory.StartsWith("'") -and $SourceDirectory.EndsWith("'"))) -or (($SourceDirectory.StartsWith("'")) -or ($SourceDirectory.EndsWith("'"))))
            {
                [String]$SourceDirectory = $SourceDirectory.Trim('"', "'" )
            }

            if (((($DestinationDirectory.StartsWith('"') -and $DestinationDirectory.EndsWith('"')) -or (($DestinationDirectory.StartsWith('"')) -or ($DestinationDirectory.EndsWith('"')))) -or ($DestinationDirectory.StartsWith("'") -and $DestinationDirectory.EndsWith("'"))) -or (($DestinationDirectory.StartsWith("'")) -or ($DestinationDirectory.EndsWith("'"))))
            {
                [String]$DestinationDirectory = $DestinationDirectory.Trim('"', "'" )
            }

            $SourceArray += $SourceDirectory
            $DestArray += $DestinationDirectory

            [Object[][]]$TheTotalArrayX = @($SourceArray, $DestArray)
        }
        elseif ($TotalArrayInput.Count -eq 0)
        {
            $SourceArray = @()
            $DestArray = @()

            if (((($SourceDirectory.StartsWith('"') -and $SourceDirectory.EndsWith('"')) -or (($SourceDirectory.StartsWith('"')) -or ($SourceDirectory.EndsWith('"')))) -or ($SourceDirectory.StartsWith("'") -and $SourceDirectory.EndsWith("'"))) -or (($SourceDirectory.StartsWith("'")) -or ($SourceDirectory.EndsWith("'"))))
            {
                [String]$SourceDirectory = $SourceDirectory.Trim('"', "'" )
            }

            if (((($DestinationDirectory.StartsWith('"') -and $DestinationDirectory.EndsWith('"')) -or (($DestinationDirectory.StartsWith('"')) -or ($DestinationDirectory.EndsWith('"')))) -or ($DestinationDirectory.StartsWith("'") -and $DestinationDirectory.EndsWith("'"))) -or (($DestinationDirectory.StartsWith("'")) -or ($DestinationDirectory.EndsWith("'"))))
            {
                [String]$DestinationDirectory = $DestinationDirectory.Trim('"', "'" )
            }

            $SourceArray += $SourceDirectory
            $DestArray += $DestinationDirectory

            [Object[][]]$TheTotalArrayX = @($SourceArray, $DestArray)
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(8)A. Parent Function: Set-Input | Child Function: Set-SourceDestArray | Variable TotalArrayInput Count: $TheCountInput (Should equal 0 or 2)"
            Exit-CaTScheduler
            Exit
        }

        Write-Host
        return $TheTotalArrayX
    }

    if ($ChooseMenuX -eq 1)
    {
        [Bool]$GetPathGood = Get-Path

        if ($GetPathGood -eq $true)
        {
            if (-not $TotalArrayInput -or $TotalArrayInput.Count -eq 0)
            {
                Invoke-ReadWrite -OperationChoice 2 -PathStatementReadWrite $PathStatementInput -SourcePathItem $SourceDirectory -DestinationPathItem $DestinationDirectory -TypeOfBackupReadWrite $TypeOfBackupX -NewOrSavedReadWrite $NewOrSavedInput
            }
            elseif ($TotalArrayInput.Count -eq 2)
            {
                Invoke-ReadWrite -OperationChoice 2 -PathStatementReadWrite $PathStatementInput -SourcePathItem $SourceDirectory -DestinationPathItem $DestinationDirectory -TypeOfBackupReadWrite $TypeOfBackupX -TotalArrayReadWrite $TotalArrayInput -NewOrSavedReadWrite $NewOrSavedInput
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(9)A. Parent Function: Set-Input | Variable ChooseMenuX: $ChooseMenuX (Should equal 1) | Variable GetPathGood: $GetPathGood (Should equal true) | TotalArrayInput Count: $TheCountInput (Should equal 0 or 2)"
                Exit-CaTScheduler
                Exit
            }
        }
        elseif (-not ($GetPathGood -eq $true))
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(9)B. Parent Function: Set-Input | Variable ChooseMenuX: $ChooseMenuX (Should equal 1) | Variable GetPathGood: $GetPathGood (Should equal not true) | Function Get-Path failed"
            Exit-CaTScheduler
            Exit
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(9)C. Parent Function: Set-Input | Variable ChooseMenuX: $ChooseMenuX (Should equal 1) | Variable GetPathGood: $GetPathGood (Should equal true or false)"
            Exit-CaTScheduler
            Exit
        }
    }
    elseif ($ChooseMenuX -eq 2)
    {
        $TotalArrayInput = Set-SourceDestArray

        if (($GetPathsFromInput -eq 0) -or ($GetPathsFromInput -eq $null))
        {
            Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackupX -TotalArrayMenu $TotalArrayInput -PathStatementMenu $PathStatementInput -NewOrSavedMenu $NewOrSavedInput
        }
        elseif ($GetPathsFromInput -eq 1)
        {
            Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackupX -TotalArrayMenu $TotalArrayInput -PathStatementMenu $PathStatementInput -SourceOrDestMenu 1
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(51)A. Parent Function: Set-Input | Variable ChooseMenuX: $ChooseMenuX (Should equal 2)"
            Exit-CaTScheduler
            Exit
        }
    }
    else
    {
        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementInput -LogType 3 -Message "(10)A. Parent Function: Set-Input | Variable ChooseMenuX: $ChooseMenuX (Should equal 2)"
        Exit-CaTScheduler
        Exit
    }
}

Export-ModuleMember -Function Set-Input
