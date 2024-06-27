

function Get-Menu 
{
    param
    (
        [Int]$ChooseMenu = $null, 
        [Int]$TypeOfBackup = $null, 
        [Object[][]]$TotalArrayMenu = @(),
        [String]$CallBackExpression = "",
        [String]$GoPreviousExpression = "",
        [Int]$NumberOfChoices = $null,
        [String]$PathStatementMenu = "",
        [Int]$NewOrSavedMenu = $null,
        [Int]$PreserveArray = $null,
        [Int]$SourceOrDestMenu = $null,
        [String]$SourcePathItemMenu = $null,
        [String]$DestinationPathItemMenu = $null,
        [Int]$MenuThreeOptions = $null
    )

    [Int]$TheCountMenu = $TotalArrayMenu.Count
    #Write-Host "Debug: Function: Get-Menu | ChooseMenu: $ChooseMenu | TypeOfBackup: $TypeOfBackup | TotalArrayMenu: $($TotalArrayMenu | ForEach-Object { $_ -join ', ' }) | TotalArrayMenu Count: $TheCountMenu | CallBackExpression: $CallBackExpression | GoPreviousExpression: $GoPreviousExpression | NumberOfChoices: $NumberOfChoices | PathStatementMenu: $PathStatementMenu | NewOrSavedMenu: $NewOrSavedMenu | PreserveArray: $PreserveArray | SourceOrDestMenu: $SourceOrDestMenu | SourcePathItemMenu: $SourcePathItemMenu | DestinationPathItemMenu: $DestinationPathItemMenu | MenuThreeOptions: $MenuThreeOptions"   -ForegroundColor Green

    function Get-UserInput
    {
        $UserInputXX = Read-Host "Choice"

        if (-not($SourceOrDestMenu -eq 2))
        {
            Write-Host
        }

        if ($UserInputXX -eq "")
        {
            if (-not($PreserveArray -eq 5))
            {
                if ($SourceOrDestMenu -eq 2)
                {
                    Write-Host
                }

                Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                Write-Host
            }
            else
            {
                Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices." -ForegroundColor Red
                Write-Host
            }

            if ($PreserveArray -eq 1)
            {
                if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu   
                    }  
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(20)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable SourceOrDestMenu: $SourceOrDestMenu (Should equal 0 or 1) | TotalArrayMenu Count: $TheCountMenu (Should equal 0)" 
                        Exit-CaTScheduler
                        Exit
                    } 
                }
                elseif ($TotalArrayMenu.Count -eq 2)
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1 -TotalArrayMenu $TotalArrayMenu
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu   
                    }  
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(20)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable SourceOrDestMenu: $SourceOrDestMenu (Should equal 0 or 1) | TotalArrayMenu Count: $TheCountMenu (Should equal 2)" 
                        Exit-CaTScheduler
                        Exit
                    }                                    
                } 
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(1)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 0 or 2) | Variable UserInputXX: $UserInputXX (Should equal null)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 2) 
            {
                if ($SourceOrDestMenu -eq 1)
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu -SourceOrDestMenu 1
                }
                elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(21)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 2) | Variable SourceOrDestMenu: $SourceOrDestMenu (Should equal 0 or 1)"  
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 3)
            {
                if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu 
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(22)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3) | TotalArrayMenu Count: $TheCountMenu (Should equal 0)"  
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($TotalArrayMenu.Count -eq 2)
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -TotalArrayReadWrite $TotalArrayMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -TotalArrayReadWrite $TotalArrayMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu -TotalArrayReadWrite $TotalArrayMenu 
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(22)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3) | TotalArrayMenu Count: $TheCountMenu (Should equal 2)"  
                        Exit-CaTScheduler
                        Exit
                    }      
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(22)C. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 0 or 2) | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                    Exit-CaTScheduler
                    Exit
                }   
            } 
            elseif ($PreserveArray -eq 4)
            {
                if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -DestinationPathItemMenu $DestinationPathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(23)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 4)"  
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 5)
            {
                Get-Menu -ChooseMenu 6 -TypeOfBackup $TypeOfBackup -TotalArrayMenu $TotalArrayMenu -PathStatementMenu $PathStatementMenu 
            }
            else
            {
                Invoke-Expression "$CallBackExpression"
            }
        }

        [Bool]$IsItAnInteger = [Int]::TryParse($UserInputXX, [ref]$null) 

        if (-not $IsItAnInteger)
        {
            if (-not($PreserveArray -eq 5))
            {
                if ($SourceOrDestMenu -eq 2)
                {
                    Write-Host
                }

                Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                Write-Host
            }
            else
            {
                Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices." -ForegroundColor Red
                Write-Host
            }

            if ($PreserveArray -eq 1)
            {
                if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu   
                    }  
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(24)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable SourceOrDestMenu: $SourceOrDestMenu (Should equal 0 or 1) | TotalArrayMenu Count: $TheCountMenu (Should equal 0)"  
                        Exit-CaTScheduler
                        Exit
                    } 
                }
                elseif ($TotalArrayMenu.Count -eq 2)
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1 -TotalArrayMenu $TotalArrayMenu
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu   
                    }  
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(24)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable SourceOrDestMenu: $SourceOrDestMenu (Should equal 0 or 1) | TotalArrayMenu Count: $TheCountMenu (Should equal 2)"  
                        Exit-CaTScheduler
                        Exit
                    }                                    
                } 
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(30)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 0 or 2) | Variable UserInputXX: $UserInputXX (Should equal null)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 2) 
            {
                if ($SourceOrDestMenu -eq 1)
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu -SourceOrDestMenu 1
                }
                elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(25)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 2) | Variable SourceOrDestMenu: $SourceOrDestMenu (Should equal 0 or 1)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 3)
            {
                if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu 
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(26)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 0)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($TotalArrayMenu.Count -eq 2)
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -TotalArrayReadWrite $TotalArrayMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -TotalArrayReadWrite $TotalArrayMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu -TotalArrayReadWrite $TotalArrayMenu 
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(26)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 2)" 
                        Exit-CaTScheduler
                        Exit
                    }      
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(26)C. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 4)
            {
                if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -DestinationPathItemMenu $DestinationPathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(27)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 4)" 
                    Exit-CaTScheduler
                    Exit
                }
            } 
            elseif ($PreserveArray -eq 5)
            {
                Get-Menu -ChooseMenu 6 -TypeOfBackup $TypeOfBackup -TotalArrayMenu $TotalArrayMenu -PathStatementMenu $PathStatementMenu 
            }
            else
            {
                Invoke-Expression "$CallBackExpression"
            }
        }
  
        try
        {
            [Int]$UserInputX = [Int]$UserInputXX
        }
        catch [System.Management.Automation.RuntimeException]
        {
            if ($_.Exception.Message -like "*Input string was not in a correct format.*")
            {
                if (-not($PreserveArray -eq 5))
                {
                    if ($SourceOrDestMenu -eq 2)
                    {
                        Write-Host
                    }

                    Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                    Write-Host
                }
                else
                {
                    Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices." -ForegroundColor Red
                    Write-Host
                }
                
                if ($PreserveArray -eq 1)
                {
                    if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                    {
                        if ($SourceOrDestMenu -eq 1)
                        {
                            Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1
                        }
                        elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                        {
                            Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu   
                        }  
                        else
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(28)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 0)" 
                            Exit-CaTScheduler
                            Exit
                        } 
                    }
                    elseif ($TotalArrayMenu.Count -eq 2)
                    {
                        if ($SourceOrDestMenu -eq 1)
                        {
                            Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1 -TotalArrayMenu $TotalArrayMenu
                        }
                        elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                        {
                            Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu   
                        }  
                        else
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(28)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 2)" 
                            Exit-CaTScheduler
                            Exit
                        }                                    
                    } 
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(31)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 0 or 2) | Variable UserInputXX: $UserInputXX (Should equal null)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($PreserveArray -eq 2) 
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu -SourceOrDestMenu 1
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                    {
                        Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(29)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 2) | Variable SourceOrDestMenu: $SourceOrDestMenu (Should equal 0 or 1)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($PreserveArray -eq 3)
                {
                    if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                    {
                        if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                        {
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu 
                        }
                        else
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(34)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                            Exit-CaTScheduler
                            Exit
                        }
                    }
                    elseif ($TotalArrayMenu.Count -eq 2)
                    {
                        if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -TotalArrayReadWrite $TotalArrayMenu
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -TotalArrayReadWrite $TotalArrayMenu
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                        {
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu -TotalArrayReadWrite $TotalArrayMenu 
                        }
                        else
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(34)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                            Exit-CaTScheduler
                            Exit
                        }      
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(34)C. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($PreserveArray -eq 4)
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                    {
                        Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -DestinationPathItemMenu $DestinationPathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions 
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(35)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 4)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($PreserveArray -eq 5)
                {
                    Get-Menu -ChooseMenu 6 -TypeOfBackup $TypeOfBackup -TotalArrayMenu $TotalArrayMenu -PathStatementMenu $PathStatementMenu 
                } 
                else
                {
                    Invoke-Expression "$CallBackExpression"
                }
            }
        }

        if (($UserInputX -ge 1) -and ($UserInputX -le $NumberOfChoices))
        {
            [Int]$ChosenUserInput = $UserInputX   
        }
        elseif ($UserInputX -eq 0)
        {
            if ($PreserveArray -eq 1)
            {
                if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                {
                    Get-Menu -ChooseMenu 2 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu    
                }
                elseif ($TotalArrayMenu.Count -eq 2)
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu -SourceOrDestMenu 1
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null)) 
                    {
                        Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(36)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }   
            }
            elseif ($PreserveArray -eq 2) 
            {
                if ($SourceOrDestMenu -eq 1)
                {
                    Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu -SourceOrDestMenu 1 
                }
                elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                {
                    Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(36)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 2)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 3)
            {
                if ($SourceOrDestMenu -eq 1)
                {
                    if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                    {
                        Get-Menu -ChooseMenu 2 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu
                    }
                    elseif ($TotalArrayMenu.Count -eq 2)
                    { 
                        if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                        {
                            Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -DestinationPathItemMenu $DestinationPathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions 
                        }
                        else
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(37)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                            Exit-CaTScheduler
                            Exit
                        }
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(37)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($SourceOrDestMenu -eq 2) 
                {
                    if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                    {
                        if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Write-Host
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest 1
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Write-Host
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest 1 -SourcePathItem $SourcePathItemMenu
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                        {
                            Write-Host
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest 1 -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu 
                        }
                        else
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(37)C. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                            Exit-CaTScheduler
                            Exit
                        }
                    }
                    elseif ($TotalArrayMenu.Count -eq 2)
                    {
                        if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Write-Host
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest 1 -TotalArrayReadWrite $TotalArrayMenu
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                        {
                            Write-Host
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest 1 -SourcePathItem $SourcePathItemMenu -TotalArrayReadWrite $TotalArrayMenu
                        }
                        elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                        {
                            Write-Host
                            Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest 1 -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu -TotalArrayReadWrite $TotalArrayMenu 
                        }
                        else
                        {
                            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(37)D. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                            Exit-CaTScheduler
                            Exit
                        } 
                    }     
                }
                elseif ($PreserveArray -eq 4) 
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest 1 -TotalArrayReadWrite $TotalArrayMenu
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(38)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 4)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(38)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 4)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 5)
            {
                Write-Host "You cannot go back from here. Choose 2 to restart." -ForegroundColor Yellow
                Write-Host
                Get-Menu -ChooseMenu 6 -TypeOfBackup $TypeOfBackup -TotalArrayMenu $TotalArrayMenu -PathStatementMenu $PathStatementMenu 
            }
            else
            {
                Invoke-Expression "$GoPreviousExpression" 
            }
        }
        elseif (($UserInputX -lt 0) -or ($UserInputX -gt $NumberOfChoices))
        {
            if (-not($PreserveArray -eq 5))
            {
                if ($SourceOrDestMenu -eq 2)
                {
                    Write-Host
                }

                Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                Write-Host
            }
            else
            {
                Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices." -ForegroundColor Red
                Write-Host
            }

            if ($PreserveArray -eq 1)
            {
                if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu   
                    }  
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(39)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1)" 
                        Exit-CaTScheduler
                        Exit
                    } 
                }
                elseif ($TotalArrayMenu.Count -eq 2)
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1 -TotalArrayMenu $TotalArrayMenu
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu   
                    }  
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(39)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1)" 
                        Exit-CaTScheduler
                        Exit
                    }                                    
                } 
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(32)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 0 or 2) | Variable UserInputXX: $UserInputXX (Should equal null)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 2) 
            {
                if ($SourceOrDestMenu -eq 1)
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu -SourceOrDestMenu 1
                }
                elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(40)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 2)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 3)
            {
                if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu 
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(41)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($TotalArrayMenu.Count -eq 2)
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -TotalArrayReadWrite $TotalArrayMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -TotalArrayReadWrite $TotalArrayMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu -TotalArrayReadWrite $TotalArrayMenu 
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(41)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                        Exit-CaTScheduler
                        Exit
                    }      
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(41)C. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 4)
            {
                if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -DestinationPathItemMenu $DestinationPathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(42)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 4)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 5)
            {
                Get-Menu -ChooseMenu 6 -TypeOfBackup $TypeOfBackup -TotalArrayMenu $TotalArrayMenu -PathStatementMenu $PathStatementMenu 
            }
            else
            {
                Invoke-Expression "$CallBackExpression"
            }
        }
        else
        {
            if (-not($PreserveArray -eq 5))
            {
                if ($SourceOrDestMenu -eq 2)
                {
                    Write-Host
                }

                Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices or 0 to go back." -ForegroundColor Red
                Write-Host
            }
            else
            {
                Write-Host "Error: The input given was not valid. The options are 1 - $NumberOfChoices." -ForegroundColor Red
                Write-Host
            }

            if ($PreserveArray -eq 1)
            {
                if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu   
                    }  
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(41)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1)" 
                        Exit-CaTScheduler
                        Exit
                    } 
                }
                elseif ($TotalArrayMenu.Count -eq 2)
                {
                    if ($SourceOrDestMenu -eq 1)
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -SourceOrDestMenu 1 -TotalArrayMenu $TotalArrayMenu
                    }
                    elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                    {
                        Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu   
                    }  
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(41)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1)" 
                        Exit-CaTScheduler
                        Exit
                    }                                    
                } 
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(33)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 1) | Variable TotalArrayMenu Count: $TheCountMenu (Should equal 0 or 2) | Variable UserInputXX: $UserInputXX (Should equal null)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 2) 
            {
                if ($SourceOrDestMenu -eq 1)
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu -SourceOrDestMenu 1
                }
                elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(42)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 2)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 3)
            {
                if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu 
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(43)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                        Exit-CaTScheduler
                        Exit
                    }
                }
                elseif ($TotalArrayMenu.Count -eq 2)
                {
                    if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -TotalArrayReadWrite $TotalArrayMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -TotalArrayReadWrite $TotalArrayMenu
                    }
                    elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                    {
                        Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu -TotalArrayReadWrite $TotalArrayMenu 
                    }
                    else
                    {
                        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(43)B. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                        Exit-CaTScheduler
                        Exit
                    }      
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(43)C. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 3)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 4)
            {
                if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                {
                    Get-Menu -ChooseMenu 4 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -SourceOrDestMenu $SourceOrDestMenu -SourcePathItemMenu $SourcePathItemMenu -DestinationPathItemMenu $DestinationPathItemMenu -TotalArrayMenu $TotalArrayMenu -MenuThreeOptions $MenuThreeOptions 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(44)A. Parent Function: Get-Menu | Child Function: Get-UserInput | Variable PreserveArray: $PreserveArray (Should equal 4)" 
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($PreserveArray -eq 5)
            {
                Get-Menu -ChooseMenu 6 -TypeOfBackup $TypeOfBackup -TotalArrayMenu $TotalArrayMenu -PathStatementMenu $PathStatementMenu 
            }
            else
            {
                Invoke-Expression "$CallBackExpression"
            }
        }

        return $ChosenUserInput 
    }

    function Get-MainMenu
    {
        Write-Host "Main Menu" -ForegroundColor Yellow
        Write-Host
        Write-Host "Choose a task from the list!" 
        Write-Host "1. Schedule a persistent backup"
        Write-Host "2. Run a backup for one time execution"
        Write-Host "3. Delete scheduled backups" 
        Write-Host "0. Quit"   
    }

    function Get-MenuOne
    {
        if ($TypeOfBackup -eq 1)
        {
            Write-Host "1. Schedule a backup from new paths"
            Write-Host "2. Schedule a backup from saved path"
        }
        elseif ($TypeOfBackup -eq 2)
        {
            Write-Host "1. Run a backup from new paths"
            Write-Host "2. Run a backup from saved paths"
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(2)A. Parent Function: Get-Menu | Child Function: Get-MenuOne | Variable TypeOfBackup: $TypeOfBackup (Should equal 1 or 2)"
            Exit-CaTScheduler
            Exit
        }
    }

    function Get-MenuTwo
    {
        Write-Host "Would you like to create another backup?"   
        Write-Host "1. Yes"
        Write-Host "2. No"
    }

    function Get-MenuThree
    {
        Write-Host "Going back from here will erase your existing backups. Do you want to continue going back?" -ForegroundColor Yellow
        Write-Host "1. Yes"
        Write-Host "2. No"
    }

    function Get-TheArray 
    {
        param
        (
            [Int]$TypeOfBackup = $null
        )

        $SourceArrayMenu = $TotalArrayMenu[0]
        $DestinationArrayMenu = $TotalArrayMenu[1]

        [Int]$SourceArrayCount = $SourceArrayMenu.Count
        [Int]$DestArrayCount = $DestinationArrayMenu.Count

        if ($SourceArrayCount -ne $DestArrayCount)
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(45)A. Parent Function: Get-Menu | Child Function: Get-TheArray"
            Exit-CaTScheduler
            Exit
        }
        elseif ($SourceArrayCount -eq $DestArrayCount)
        {
            [Int]$ArrayCount = $SourceArrayCount
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(45)B. Parent Function: Get-Menu | Child Function: Get-TheArray"
            Exit-CaTScheduler
            Exit
        }

        [Int]$ArrayCountBase = 0

        Write-Host "Please verify your selection" -ForegroundColor Yellow

        while ($ArrayCountBase -lt $ArrayCount)
        {
            $ArrayNumber = $ArrayCountBase + 1
            Write-Host "Backup $ArrayNumber. The directory " -NoNewline
            Write-Host "$($SourceArrayMenu[$ArrayCountBase])" -ForegroundColor Yellow -NoNewline
            Write-Host " will backup to " -NoNewline
            Write-Host "$($DestinationArrayMenu[$ArrayCountBase])" -ForegroundColor Yellow  

            $ArrayCountBase = $ArrayCountBase + 1    
        }

        Write-Host "Is this correct?" 
        
        if ($TypeOfBackup -eq 1)
        {
            Write-Host "1. Yes - Continue to scheduling"
        }
        elseif ($TypeOfBackup -eq 2)
        {
            Write-Host "1. Yes - Execute backup"
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(81)A. Parent Function: Get-Menu | Child Function: Get-TheArray | Variable TypeOfBackup: $TypeOfBackup (Should equal 1 or 2)"
            Exit-CaTScheduler
            Exit
        }

        Write-Host "2. No - restart"
    }

    if ($ChooseMenu -eq 1)
    {
        Get-MainMenu 
        $CallBackExpression = "Get-Menu -ChooseMenu 1 -PathStatementMenu `"$PathStatementMenu`" -NewOrSavedMenu $NewOrSavedMenu"
        $GoPreviousExpression = "Exit-CaTScheduler"                                       
        $NumberOfChoices = 3                            

        [Int]$UserInput = Get-UserInput 
        
        if ($UserInput -eq 1)
        {
            Get-Menu -ChooseMenu 2 -TypeOfBackup 1 -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu 
        }
        elseif ($UserInput -eq 2)
        {
            Get-Menu -ChooseMenu 2 -TypeOfBackup 2 -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu 
        }
        elseif ($UserInput -eq 3)
        {
            Invoke-ReadWrite -OperationChoice 4 -PathStatementReadWrite $PathStatementMenu -NewOrSavedReadWrite $NewOrSavedMenu      
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(3)A. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 1) | Variable UserInput: $UserInput (Should equal 1 - 3)"
            Exit-CaTScheduler
            Exit
        }
    }
    elseif ($ChooseMenu -eq 2)
    {
        if ($NewOrSavedMenu -eq 1) 
        {  
            Set-Input -ChooseMenuX 1 -GoBack 1 -ContinueLoopOne 0 -ContinueLoopTwo 0 -TypeOfBackupX $TypeOfBackup -PathStatementInput $PathStatementMenu -NewOrSavedInput $NewOrSavedMenu
        }
        elseif ($NewOrSavedMenu -eq 0)
        {
            Get-MenuOne
            $CallBackExpression = "Get-Menu -ChooseMenu 2 -TypeOfBackup $TypeOfBackup -PathStatementMenu `"$PathStatementMenu`" -NewOrSavedMenu $NewOrSavedMenu"
            $GoPreviousExpression = "Get-Menu -ChooseMenu 1 -PathStatementMenu `"$PathStatementMenu`" -NewOrSavedMenu $NewOrSavedMenu"                                      
            $NumberOfChoices = 2 

            [Int]$UserInput = Get-UserInput
        
            if ($UserInput -eq 1)
            {
                Set-Input -ChooseMenuX 1 -GoBack 1 -ContinueLoopOne 0 -ContinueLoopTwo 0 -TypeOfBackupX $TypeOfBackup -PathStatementInput $PathStatementMenu -NewOrSavedInput $NewOrSavedMenu 
            }
            elseif ($UserInput -eq 2)
            {
                Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest 1
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(3)B. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 2) | Variable UserInput: $UserInput (Should equal 1 or 2)"
                Exit-CaTScheduler
                Exit
            } 
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(16)A. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 2) | Variable NewOrSavedMenu: $NewOrSavedMenu (Should equal 1 or 0)"
            Exit-CaTScheduler
            Exit
        }
    }
    elseif ($ChooseMenu -eq 3)
    {
        Get-MenuTwo                                              
        $NumberOfChoices = 2 
        $PreserveArray = 1                           

        [Int]$UserInput = Get-UserInput 

        if ($UserInput -eq 1)
        {
            if ($SourceOrDestMenu -eq 1)
            {
                Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest 1 -TotalArrayReadWrite $TotalArrayMenu 
            }
            elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null)) 
            {
                Set-Input -ChooseMenuX 1 -GoBack 2 -ContinueLoopOne 0 -ContinueLoopTwo 0 -TypeOfBackupX $TypeOfBackup -TotalArrayInput $TotalArrayMenu -PathStatementInput $PathStatementMenu -NewOrSavedInput $NewOrSavedMenu
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(46)A. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 3)"
                Exit-CaTScheduler
                Exit
            }
        }
        elseif ($UserInput -eq 2) 
        {
            Get-Menu -ChooseMenu 6 -TypeOfBackup $TypeOfBackup -TotalArrayMenu $TotalArrayMenu -PathStatementMenu $PathStatementMenu   
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(46)B. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 3)"
            Exit-CaTScheduler
            Exit
        }
    }
    elseif ($ChooseMenu -eq 4)
    {
        if (($MenuThreeOptions -eq 0) -or ($MenuThreeOptions -eq $null))
        {
            Get-MenuThree
            $NumberOfChoices = 2 
            $PreserveArray = 2

            [Int]$UserInput = Get-UserInput 

            if ($UserInput -eq 1)
            {
                Get-Menu -ChooseMenu 2 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu
            }
            elseif ($UserInput -eq 2)
            {
                if ($SourceOrDestMenu -eq 1)
                {
                    Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu -SourceOrDestMenu 1
                }
                elseif (($SourceOrDestMenu -eq 0) -or ($SourceOrDestMenu -eq $null))
                {
                    Get-Menu -ChooseMenu 3 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu -NewOrSavedMenu $NewOrSavedMenu -TotalArrayMenu $TotalArrayMenu
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(47)A. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 4)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(47)B. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 4)"
                Exit-CaTScheduler
                Exit
            }
        }
        elseif ($MenuThreeOptions -eq 1)
        {
            Get-MenuThree                  
            $NumberOfChoices = 2
            $PreserveArray = 4
            
            [Int]$UserInput = Get-UserInput

            if ($UserInput -eq 1)
            {
                Get-Menu -ChooseMenu 2 -TypeOfBackup $TypeOfBackup -PathStatementMenu $PathStatementMenu
            }
            elseif ($UserInput -eq 2)
            {
                if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -TotalArrayReadWrite $TotalArrayMenu
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -TotalArrayReadWrite $TotalArrayMenu
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                {
                    Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest $SourceOrDestMenu -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu -TotalArrayReadWrite $TotalArrayMenu 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(47)C. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 4)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(47)D. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 4)"
                Exit-CaTScheduler
                Exit
            }
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(47)E. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 4)"
            Exit-CaTScheduler
            Exit
        }
    }
    elseif ($ChooseMenu -eq 5)
    {
        $PreserveArray = 3
        [Int]$UserInput = Get-UserInput

        if (($UserInput -gt 0) -and ($UserInput -le $NumberOfChoices)) 
        {        
            if (-not $TotalArrayMenu -or $TotalArrayMenu.Count -eq 0)
            {
                if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest ($SourceOrDestMenu + 1) -UserInputReadWrite $UserInput -TotalKeys $NumberOfChoices
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest ($SourceOrDestMenu + 1) -SourcePathItem $SourcePathItemMenu -UserInputReadWrite $UserInput -TotalKeys $NumberOfChoices
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                {
                    Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest ($SourceOrDestMenu + 1) -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu -UserInputReadWrite $UserInput -TotalKeys $NumberOfChoices 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(48)A. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 5)"
                    Exit-CaTScheduler
                    Exit
                }
            }
            elseif ($TotalArrayMenu.Count -eq 2)
            {
                if ((($SourcePathItemMenu -eq "") -or ($SourcePathItemMenu -eq $null)) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest ($SourceOrDestMenu + 1) -TotalArrayReadWrite $TotalArrayMenu -UserInputReadWrite $UserInput -TotalKeys $NumberOfChoices
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and (($DestinationPathItemMenu -eq "") -or ($DestinationPathItemMenu -eq $null)))
                {
                    Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest ($SourceOrDestMenu + 1) -SourcePathItem $SourcePathItemMenu -TotalArrayReadWrite $TotalArrayMenu -UserInputReadWrite $UserInput -TotalKeys $NumberOfChoices
                }
                elseif (((-not($SourcePathItemMenu -eq "")) -or (-not($SourcePathItemMenu -eq $null))) -and ((-not($DestinationPathItemMenu -eq "")) -or (-not($DestinationPathItemMenu -eq $null))))
                {
                    Invoke-ReadWrite -OperationChoice 3 -TypeOfBackupReadWrite $TypeOfBackup -PathStatementReadWrite $PathStatementMenu -SourceOrDest ($SourceOrDestMenu + 1) -SourcePathItem $SourcePathItemMenu -DestinationPathItem $DestinationPathItemMenu -TotalArrayReadWrite $TotalArrayMenu -UserInputReadWrite $UserInput -TotalKeys $NumberOfChoices 
                }
                else
                {
                    Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(48)B. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 5)"
                    Exit-CaTScheduler
                    Exit
                }      
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(48)C. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 5)"
                Exit-CaTScheduler
                Exit    
            }
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(48)D. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 5)"
            Exit-CaTScheduler
            Exit 
        }
    }
    elseif ($ChooseMenu -eq 6)
    {
        Get-TheArray -TypeOfBackup $TypeOfBackup
        $PreserveArray = 5
        $NumberOfChoices = 2
        [Int]$UserInput = Get-UserInput

        if ($UserInput -eq 1)
        {
            if ($TypeOfBackup -eq 1)
            {
                Write-Task -SchedulingOperation 1 -PathStatementScheduling $PathStatementMenu -TotalArrayScheduling $TotalArrayMenu 
            }
            elseif ($TypeOfBackup -eq 2)
            {
                Start-Backup -BackupOperation 1 -PathStatementBackup $PathStatementMenu -TotalArrayBackup $TotalArrayMenu 
            }
            else
            {
                Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(49)A. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 6)"
                Exit-CaTScheduler
                Exit
            }
        }
        elseif ($UserInput -eq 2) 
        {
            Start-CaTScheduler -PathStatementStartup $PathStatementMenu -Start 1
        }
        else
        {
            Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(49)B. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should equal 6)"
            Exit-CaTScheduler
            Exit
        }
    }
    else
    {
        Invoke-ReadWrite -OperationChoice 1 -PathStatementReadWrite $PathStatementMenu -LogType 3 -Message "(50)A. Parent Function: Get-Menu | Variable ChooseMenu: $ChooseMenu (Should not equal 1 - 6)"
        Exit-CaTScheduler
        Exit
    }
}

Export-ModuleMember -Function Get-Menu