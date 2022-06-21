
#udemy doesn't allow .ps1 extensions so I saved this as a .txt file. Make sure you save it as a ps1

#Parameters
#The script should take 2 arguments $source and $destination (for the source and destination folders).

param([Parameter(Mandatory=$true)][string]$source, [Parameter(Mandatory=$true)][string]$destination) 

#Functions
#2)	Functions

#Create a function named CheckFolder that checks for the existence of a specific directory/folder that is passed 
#to it as a parameter. Also, include a switch parameter named create. If the directory/folder does not exist and 
#the create switch is specified, a new folder should be created using the name of the folder/directory that was 
#passed to the function.

function CheckFolder([string]$directory, [switch]$create) 
{
	$exists = Test-Path $directory -PathType Container

	if (-NOT($exists) -AND $create) {
		New-Item -Path $directory -ItemType Directory
	}

	return $exists
}

#Create a function named DisplayFolderStatistics to display folder statistics for a directory/path that is passed 
#to it. Output should include the name of the folder, number of files in the folder, and total size of all files in 
#that directory.

function DisplayFolderStatistics([string]$directory) {
	$folderInfo = New-Object System.Collections.Generic.Dictionary"[string,string]"
		
	$folder = Get-Item $directory
	$files = Get-ChildItem $directory
	$total = 0

	foreach ($file in $files)
	{
		$total += $file.Length
	}
	
	$folderInfo.Add("Name", $folder.Name)
	$folderInfo.Add("Files", $files.Length.ToString())
	$folderInfo.Add("Size", $total)

	return $folderInfo
}

#3)	Main processing

#a) Test for existence of the source folder (using the CheckFolder function).

if (CheckFolder $source) 
{
	Write-Host "Testing Destination Directory - $destination"

	if (CheckFolder $destination -create) {
		$files = Get-ChildItem $source -File
		$length = $files.Length
		Write-Host "Got files: $length"
		
		foreach ($file in $files)
		{
			Copy-Item $file.FullName $destination
			$name = $file.Name
			Write-Host "Copying $name from $source to $destination"
		}
	}
}
else 
{
	Write-Host "$source  - does not exist"
}


#b) Test for the existence of the destination folder; create it if it is not found (using the CheckFolder function 
#with the –create switch).Write-Host "Testing Destination Directory - $destination"



#c) Copy each file to the appropriate destination.
#get all the files that need to be copied



#c-i) Display a message when copying a file. The message should list where the file is being
#moved from and where it is being moved to.





#d) Display each target folder name with the file count and byte count for each folder.


