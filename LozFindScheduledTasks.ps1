
function Get-SchedTaskHashTable
{
    param
    (
        [Int]$StartOperation
    )

    function Get-LozSchedTask
    {
        $TaskNames = @()
        $Number = 0
        $Pattern = '-SourceDir\s+"([^"]+)"|-DestDir\s+"([^"]+)"'
        $CompleteTasks = @()
        $ScheduledTasksHashTableX = @{}

        $TaskNames = Get-ScheduledTask | Where-Object { $_.TaskName -like 'CaT_Scheduler*' } | Sort-Object TaskName | Select-Object -ExpandProperty TaskName

        while ($Number -lt $TaskNames.Count)
        {
            foreach ($Task in $TaskNames)
            {
                $Number = $Number + 1
                [String]$TheTaskName = "$Task"

                $SelectedTask = Get-ScheduledTask -TaskName "$Task"
                $SelectedTaskAction = $SelectedTask.Actions
                $SelectedTaskArguments = $SelectedTaskAction.Arguments

                $MatchesXX = [regex]::Matches($SelectedTaskArguments, $Pattern)

                foreach ($Match in $MatchesXX)
                {
                    if ($Match.Groups[1].Value)
                    {
                        $SourceDir = $Match.Groups[1].Value
                    }

                    if ($Match.Groups[2].Value)
                    {
                        $DestDir = $Match.Groups[2].Value
                    }

                    [String]$TheTaskDirectory = "Source Directory: $SourceDir Destination Directory: $DestDir"
                }

                $SelectedTaskTriggers = $SelectedTask.Triggers

                foreach ($Trigger in $SelectedTaskTriggers)
                {
                    $Time = [DateTime]::Parse($Trigger.StartBoundary).ToString("t")

                    if ($Trigger.PSObject.TypeNames -contains "Microsoft.Management.Infrastructure.CimInstance#MSFT_TaskDailyTrigger")
                    {
                        [String]$TheTaskTrigger = "Trigger: Daily at $Time"
                    }
                    elseif ($Trigger.PSObject.TypeNames -contains "Microsoft.Management.Infrastructure.CimInstance#MSFT_TaskWeeklyTrigger")
                    {
                        $DaysOfWeek = $Trigger.DaysOfWeek -join ", "
                        [String]$TheTaskTrigger = "Trigger: Weekly on $DaysOfWeek at $Time"
                    }
                    elseif ($Trigger.PSObject.TypeNames -contains "Microsoft.Management.Infrastructure.CimInstance#MSFT_TaskMonthlyTrigger")
                    {
                        $DaysOfMonth = $Trigger.DaysOfMonth -join ", "
                        [String]$TheTaskTrigger = "Trigger: Monthly on day(s) $DaysOfMonth at $Time"
                    }
                    elseif ($Trigger.PSObject.TypeNames -contains "Microsoft.Management.Infrastructure.CimInstance#MSFT_TaskOneTimeTrigger")
                    {
                        [String]$TheTaskTrigger = "Trigger: One-time at $Time"
                    }
                    else
                    {
                        [String]$TheTaskTrigger = "Trigger: $($Trigger.TriggerType) at $Time"
                    }
                }

                $CompleteTasks = ($TheTaskName, $TheTaskDirectory, $TheTaskTrigger)

                [String]$Key = "Key. $Number"
                $ScheduledTasksHashTableX[$Key] = $CompleteTasks
            }
        }

        return $ScheduledTasksHashTableX
    }

    function Write-LozScheduledTask
    {
        $ScheduledTasksHashTable = @{}

        $ScheduledTasksHashTable = Get-LozSchedTask

        $ScheduledTasksHashTable | ConvertTo-Json -Depth 2 | Set-Content -Path $PathStatement

        return $true
    }

    if ($StartOperation -eq 1)
    {
        $PathStatementXX = $PSScriptRoot
        Set-Location $PathStatementXX
        $PathStatementX = Get-Location
        $PathStatement = "$PathStatementX\PowerLozConfigurationFiles\LozScheduledTasks.json"

        [Bool]$IsWritten= Write-LozScheduledTask

        if ($IsWritten -eq $true)
        {
            exit
        }
        elseif (-not ($IsWritten -eq $true))
        {
            exit
        }
        else
        {
            exit
        }
    }
}

Get-SchedTaskHashTable -StartOperation 1

