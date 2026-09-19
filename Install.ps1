## Install File for the Mailbox Manager
## Download Files from Github

## Created by Aaron Haydon 2024
$downloadlocation = "C:\Temp\MailboxManager"
$fileexisits = Test-Path $downloadlocation
$path = "$($PSModulePath)\MailboxFunctions"


if ($fileexisits -eq $False) {
    Invoke-WebRequest -URI "https://github.com/TestGroundControl/MailboxManager/archive/refs/heads/main.zip" -OutFile "C:\Temp\MailboxManager.zip" 
    mkdir "C:\Temp\MailboxManager"
    Expand-Archive -Path "C:\Temp\MailboxManager.zip" -DestinationPath $downloadlocation -Force
    Remove-Item "C:\Temp\MailboxManager.zip"

}
else {
    Write-Host "File Already Exists"
    Remove-Item -Path $downloadlocation -Recurse -Force
    Invoke-WebRequest -URI "https://github.com/TestGroundControl/MailboxManager/archive/refs/heads/main.zip" -OutFile "C:\Temp\MailboxManager.zip"
    mkdir "C:\Temp\MailboxManager"
    Expand-Archive -Path "C:\Temp\MailboxManager.zip" -DestinationPath $downloadlocation -Force   
}
if (-not $env:PSModulePath) {
        throw "The environment variable 'PSModulePath' is not set."
    }

    $PSModulePath = $env:PSModulePath -split ";" | Select-Object -First 1
    
try {
if( (Test-Path($path)) -eq $false) {
    
        New-Item -Path $path -ItemType Directory -Force
    
        Copy-Item -Path 'C:\Temp\MailboxManager\MailboxManager-main\MailboxFunctions\*' -Destination $path -Recurse -Force
        
        }
else {
    Write-Host "Module Already Exists"
    Copy-Item -Path 'C:\Temp\MailboxManager\MailboxManager-main\MailboxFunctions\*' -Destination $path -Recurse -Force
       
}
}
catch {
    Write-Host "Error: The path '$downloadlocation' does not exist." -ForegroundColor Red
    }

#Remove-Item -Path "C:\Temp\MailboxManager.zip" -Force
#Remove-Item -Path "C:\Temp\MailboxManager" -Force -Recurse

Set-Location $downloadlocation
# ps12exe v0.6.0+ uses grouped object parameters for optional settings, e.g.
#   ps12exe -inputFile x.ps1 -outputFile x.exe -Resources @{Icon='icon.ico'} -App @{Windowed=$true}
# -inputFile / -outputFile are unchanged.
Install-Module ps12exe -Scope CurrentUser -Force
ps12exe -inputFile .\MailboxManager.ps1 -outputFile .\MailboxManager.exe

