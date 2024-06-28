# CaT-Scheduler
Backup utility

Things to add:
Turn logs on or off.
Different types of backups. 
Check if running as admin, works through whole program.  
Add monthly scheduling.  
Check how ReadWriteModule writes JSON files.
GetScheduledTasks define variables. 
Appropriate task number.
Remove saved paths.

Errors that need accounting:
Test-Path : Illegal characters in path.
At C:\Users\Justin Cavage\Documents\Software\CaT_Scheduler\CaT_Scheduler_0.3.X\CaT_Scheduler_0.3.2\InputModule.psm1:201 char:35
+             [Bool]$IsItGoodPath = Test-Path $DestDir
+                                   ~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (C:\Users\Justin Cavage\|:String) [Test-Path], ArgumentException
    + FullyQualifiedErrorId : ItemExistsArgumentError,Microsoft.PowerShell.Commands.TestPathCommand

Register-ScheduledTask : Access is denied.
At C:\Users\Justin
Cavage\Documents\Software\CaT_Scheduler\CaT_Scheduler_0.3.X\CaT_Scheduler_0.3.4\Modules\SchedulingModule.psm1:595
char:9
+         Register-ScheduledTask -TaskName $Taskname -Action $Action -T ...
+         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : PermissionDenied: (PS_ScheduledTask:Root/Microsoft/...S_ScheduledTask) [Register-Schedul
   edTask], CimException
    + FullyQualifiedErrorId : HRESULT 0x80070005,Register-ScheduledTask

notify user that overlapping paths will do better if scheduled at different times. 

Cannot convert value "opre" to type "System.Int32". Error: "Input string was not in a correct format."
At C:\Users\srogers\Documents\CaT_Scheduler_0.4.0\SchedulingModule.psm1:91 char:21
+                     $UserChoiceX = Read-Host "Choice"
+                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : MetadataError: (:) [], ArgumentTransformationMetadataException
    + FullyQualifiedErrorId : RuntimeException
