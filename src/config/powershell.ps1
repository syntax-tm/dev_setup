
# install oh-my-posh
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

# install fonts
oh-my-posh font install

$docsPath = [System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::MyDocuments)

$profileContent = @"
# by default this will use the bubbles theme (use the 'Get-PoshThemes' command to preview other themes)
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\stelbent-compact.minimal.omp.json" | Invoke-Expression
"@

$profiles = @(
    $PROFILE.AllUsersAllHosts
    $PROFILE.AllUsersCurrentHost
    $PROFILE.CurrentUserAllHosts
    $PROFILE.CurrentUserCurrentHost
)

foreach ($psProfile in $profiles)
{
    if (Test-Path $psProfile) { continue }

    [System.IO.File]::WriteAllText($psProfile, $profileContent)
}

# install modules
Install-Module Terminal-Icons
Install-Module Terminal-Icons



# save execution policies

# set via group policy
Set-ExecutionPolicy -Scope MachinePolicy -ExecutionPolicy Undefined -Force
Set-ExecutionPolicy -Scope UserPolicy -ExecutionPolicy Undefined -Force
# set via HKLM and HKCU in registry
Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Unrestricted -Force
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted -Force
# set via $env:PSExecutionPolicyPreference environment variable
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force
