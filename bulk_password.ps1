#used for output trascript
$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"

#set this to the location of the gam binaries
Set-Alias gam C:\gam\gam.exe
Start-Transcript -path C:\scripts\password_output.txt -append
#Imports data from csv, mandatory column 1 (email) address
foreach($column in (Import-Csv C:\scripts\users.csv))
{
 $pass = $null
 #creates random 8 charecter password
 $r = New-Object System.Random
 1..8 | % { $pass += [char]$r.next(33,126) }
 
 gam update user $($column.email) password $pass
 gam update user $($column.email) suspended on

 Write-Host "$($column.email) password changed - $pass - Suspended `r" 
 
 }

Stop-Transcript
