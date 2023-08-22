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

.\scm.ps1

.\editors.ps1

.\dev.ps1

.\powershell.ps1

.\tools.ps1

.\iis.ps1

.\db.ps1

.\cloud.ps1

.\office.ps1

.\fonts.ps1

.\media.ps1

.\system.ps1

.\windows.ps1
