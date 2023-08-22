# make sure we are running from this directory
Set-Location $PSScriptRoot

# declare global variables and import shared functions
. .\src\common.ps1

Start-Logging

# install choco and then other required software
.\src\choco\all.ps1

# configure powershell
.\src\config\powershell.ps1

# configure windows
.\src\config\windows.ps1

# configure IE
.\src\config\ie.ps1

# configure file explorer
.\src\config\explorer.ps1

# configure wsl (windows subsystem for linux)
.\src\config\wsl.ps1

# remove bloatware apps
.\src\config\apps.ps1

Stop-Logging