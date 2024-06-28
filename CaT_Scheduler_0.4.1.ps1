#Next log is (85)A

function Get-StartupItems
{
    param
    (
        [Int]$Start = $null
    )

    function Get-AdministratorPrivileges
    {
        $IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

        if (-not $IsAdmin)
        {
            $Arguments = "-NoProfile -ExecutionPolicy Bypass -File ""$($MyInvocation.MyCommand.Path)"""

            if ($MyInvocation.BoundParameters.Count -gt 0)
            {
                $Arguments += $MyInvocation.BoundParameters.GetEnumerator() | ForEach-Object { " -$($_.Key) $($_.Value)" }
            }

            Start-Process powershell.exe -Verb RunAs -ArgumentList $Arguments
        }

        return $true
    }

    function Get-PathStatement
    {
        $PathStatementX = $PSScriptRoot
        Set-Location $PathStatementX
        $PathStatement = Get-Location

        return $PathStatement
    }

    function Load-Modules
    {
        $env:PSModulePath += ";$PathStatement"

        Import-Module -Name "$PathStatement\StartUpModule.psm1"
        Import-Module -Name "$PathStatement\MenuModule.psm1"
        Import-Module -Name "$PathStatement\InputModule.psm1"
        Import-Module -Name "$PathStatement\ReadWriteModule.psm1"
        Import-Module -Name "$PathStatement\BackupModule.psm1"
        Import-Module -Name "$PathStatement\SchedulingModule.psm1"

        return $true
    }

    if ($Start -eq 1)
    {
        [Int]$GoodCount = 0

        [Bool]$AdminTrue = Get-AdministratorPrivileges

        if ($AdminTrue -eq $true)
        {
            $GoodCount = $GoodCount + 1

            [String]$PathStatement = Get-PathStatement

            if ($PathStatement.Length -gt 0)
            {
                $GoodCount = $GoodCount + 1

                [Bool]$GoodLoad = Load-Modules

                if ($GoodLoad -eq $true)
                {
                    $GoodCount = $GoodCount + 1

                    if ($GoodCount -eq 3)
                    {
                        Start-CaTScheduler -PathStatementStartup $PathStatement -Start 1
                    }
                    else
                    {
                        Write-Host "Startup failed" -ForegroundColor Red
                        Exit
                    }
                }
                else
                {
                    Write-Host "Startup failed" -ForegroundColor Red
                    Exit
                }
            }
            else
            {
                Write-Host "Startup failed" -ForegroundColor Red
                Exit
            }
        }
        else
        {
            Write-Host "Startup failed" -ForegroundColor Red
            Exit
        }
    }
    else
    {
        Write-Host "Startup failed" -ForegroundColor Red
        Exit
    }
}

Get-StartupItems -Start 1


