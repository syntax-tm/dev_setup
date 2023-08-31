
# install oh-my-posh
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

# install fonts
oh-my-posh font install

$profileContent = @"
if (`$host.Name -like '*ISE*') {
    return
}

if (`$PSEdition -ne 'Core') {
    return
}

# This key handler shows the entire or filtered history using Out-GridView. The
# typed text is used as the substring pattern for filtering. A selected command
# is inserted to the command line without invoking. Multiple command selection
# is supported, e.g. selected by Ctrl + Click.
Set-PSReadlineKeyHandler -Chord F7 `
                         -BriefDescription History `
                         -LongDescription 'Show command history' `
                         -ScriptBlock {
    `$pattern = `$null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]`$pattern, [ref]`$null)
    if (`$pattern)
    {
        `$pattern = [regex]::Escape(`$pattern)
    }

    `$history = [System.Collections.ArrayList]@(
        `$last = ''
        `$lines = ''
        foreach (`$line in [System.IO.File]::ReadLines((Get-PSReadlineOption).HistorySavePath))
        {
            if (`$line.EndsWith('`'))
            {
                `$line = `$line.Substring(0, `$line.Length - 1)
                `$lines = if (`$lines)
                {
                    "`$lines`n`$line"
                }
                else
                {
                    `$line
                }
                continue
            }

            if (`$lines)
            {
                `$line = "`$lines`n`$line"
                `$lines = ''
            }

            if ((`$line -cne `$last) -and (!`$pattern -or (`$line -match `$pattern)))
            {
                `$last = `$line
                `$line
            }
        }
    )
    `$history.Reverse()

    `$command = `$history | Out-GridView -Title History -PassThru
    if (`$command)
    {
        [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert((`$command -join "`n"))
    }
}

Import-Module Terminal-Icons

# by default this will use the bubbles theme (use the 'Get-PoshThemes' command to preview other themes)
oh-my-posh init pwsh --config "`$env:POSH_THEMES_PATH\stelbent-compact.minimal.omp.json" | Invoke-Expression
"@

$profiles = @(
    $PROFILE.CurrentUserAllHosts
    $PROFILE.CurrentUserCurrentHost
)

foreach ($psProfile in $profiles)
{
    if (Test-Path $psProfile) { continue }

    [System.IO.File]::WriteAllText($psProfile, $profileContent)
}

if ($PSEdition -eq 'Core')
{
    Install-Module PSReadLine -AllowPrerelease -Force
}
else
{
    Install-Module PSReadLine -Force
}

# install modules
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
