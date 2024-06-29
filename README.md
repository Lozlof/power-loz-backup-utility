# Power-Loz
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
When program exits because of an error. Have a different exit message. 
Notify user that overlapping paths will do better if scheduled at different times.
Check if FindScheduledTasks is already running, and if it is, stop it. 

Errors that need accounting:
Test-Path : Illegal characters in path.
At C:\Users\Justin Cavage\Documents\Software\CaT_Scheduler\CaT_Scheduler_0.3.X\CaT_Scheduler_0.3.2\InputModule.psm1:201 char:35
+             [Bool]$IsItGoodPath = Test-Path $DestDir
+                                   ~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (C:\Users\Justin Cavage\|:String) [Test-Path], ArgumentException
    + FullyQualifiedErrorId : ItemExistsArgumentError,Microsoft.PowerShell.Commands.TestPathCommand

WARNING: The input given was not valid. The options are 1 - 1 or 0 to go back. 
