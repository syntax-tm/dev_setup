$choco = Get-Command choco -ErrorAction SilentlyContinue

if ($null -eq $choco)
{
    # install choco
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# enable global confirmations
choco feature enable -n allowGlobalConfirmation

# Common
# ------
choco install 7zip                       # alts: winrar
choco install googlechrome               # alts: brave, firefox, microsoft-edge, opera, tor-browser
choco install microsoft-windows-terminal # windows terminal
choco install pwsh                       # powershell core
choco install vcredist-all               # installs all vc++ redists

# .NET
# ----
choco install dotnet-all                 # includes .net framework and .net core runtimes (desktop runtimes only)
choco install dotnet-sdk                 # .net 7.0 sdk
choco install dotnet-aspnetruntime       # .net 7.0 asp.net runtime
choco install dotnet-windowshosting      # .net 7.0 web hosting
choco install msbuild.communitytasks     # msbuild community extenions

# Misc.
# -----
. $PSScriptRoot\scm.ps1

. $PSScriptRoot\editors.ps1

. $PSScriptRoot\dev.ps1

. $PSScriptRoot\powershell.ps1

. $PSScriptRoot\tools.ps1

. $PSScriptRoot\iis.ps1

. $PSScriptRoot\db.ps1

. $PSScriptRoot\cloud.ps1

. $PSScriptRoot\office.ps1

. $PSScriptRoot\fonts.ps1

. $PSScriptRoot\media.ps1

. $PSScriptRoot\system.ps1

. $PSScriptRoot\windows.ps1
