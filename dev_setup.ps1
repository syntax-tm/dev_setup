$ErrorActionPreference = 'Stop'

# make sure we are running from this directory
Set-Location $PSScriptRoot

try
{
    # declare global variables and import shared functions
    . $PSScriptRoot\src\common.ps1

    Start-Logging

    # install choco and then other required software
    . $PSScriptRoot\src\choco\all.ps1

    # configure powershell
    . $PSScriptRoot\src\config\powershell.ps1

    # configure windows
    . $PSScriptRoot\src\config\windows.ps1

    # configure IE
    . $PSScriptRoot\src\config\ie.ps1

    # configure file explorer
    . $PSScriptRoot\src\config\explorer.ps1

    # configure wsl (windows subsystem for linux)
    . $PSScriptRoot\src\config\wsl.ps1

    # remove bloatware apps
    . $PSScriptRoot\src\config\apps.ps1

    # configure network-related settings (proxy)
    . $PSScriptRoot\src\config\network.ps1

    # configure nuget.org package source
    . $PSScriptRoot\src\config\nuget.ps1
}
catch
{
    $message = "An error occurred attempting to run $($MyInvocation.MyCommand.Name). $($_.Exception.Message)"
    $message += "`n`n$($_.ScriptStackTrace)"

    Write-Host ""
    Write-Host $message -ForegroundColor Red
    Write-Host ""
}
finally
{
    Stop-Logging
}

$ErrorActionPreference = 'Continue'
