# Power Loz Backup Utility    
#### Backup scheduler / manager. User friendly CLI. Written in Powershell.    
## Introduction    
I want to share the use case for Power Loz so that you have a clear understanding of what it was designed for and why I built it. Power Loz is a project I created during my free time for the purpose of learning Powershell, and solving the OneDrive/Local storage issue. For my home workstation, I’m not concerned with performing full system backups; instead, I focus on backing up the essential files, such as my documents, pictures, and similar items.    
To illustrate, I have two directories:       
C:\Users\UserName\Documents (local directory)       
C:\Users\UserName\OneDrive\Documents (cloud directory)    
Everything I work on is initially saved in the local directory. Once a day, Power Loz automatically transfers only the files that are different between the local directory and the OneDrive directory.
The code is not optimal, it could be written much simpler. It's complexity comes beacuse: I am a novice, there are no global or script variables, lots of user input sanitazation, and it is broken into modules. A large amount of the code is for the user experiance. The actual backup script is not many lines, and for persistent backups, it schedules a task. With that said, my work on Power Loz is complete for now. It functions well and meets its intended purpose with minimal issues. I'll likely only revisit development if others discover it and show interest. There’s plenty of potential for Power Loz to grow in various directions. If you're interested in it, I’d be happy to answer any questions or collaborate with you directly.    
## Backup Process Overview   
The core Power Loz function is designed to perform a custom file-level backup that doesn’t fit neatly into traditional backup types such as full, incremental, or differential. However, its unique behavior can be described as follows:       
**Source-Destination Backup:** The script works with two directories—source and destination. It checks whether these directories exist, prompting the user to create them if they don’t.     
**File Hash Comparison:** The script compares the hash values of files in both the source and destination directories. If a file exists at both locations but differs based on its hash, the script copies the updated file from the source to the destination. If the files are identical, no copy is made.      
**Directory Creation:** Missing directories are automatically created in the destination to mirror the source structure, ensuring the directory tree is maintained.     
**Logging:** The backup process is logged, documenting when directories are created or files are copied.       
#### Backup Type       
This backup script resembles an incremental backup in that it only backs up files that have changed between the source and destination directories. By comparing file hashes, it selectively copies files that differ, rather than copying everything.      
At the same time, it incorporates elements of a mirror backup, as the destination directory structure is always kept identical to the source. However, unlike traditional incremental backups, it does not keep historical versions of files. Instead, it replaces any file at the destination if it detects a difference.     
## Things to add:  
Turn logs on or off.  
Different types of backups.   
The system call to request for admin privilages needs to be fixed.       
Add monthly scheduling.         
Add a loading screen for one time backups that take a long time.       
Delete multiple tasks at once.       
Check if FindScheduledTasks is already running, and if it is, stop it.   
Remove saved paths.   
Notify user that overlapping paths will do better if scheduled at different times.   
When program exits because of an error. Have a different exit message.   
Appropriate task number.   
GetScheduledTasks define variables.   
Check how ReadWriteModule writes JSON files.    
## Contact: contact@gistyr.dev           
