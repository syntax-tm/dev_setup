$global:ROOT_DIR = Split-Path $PSScriptRoot
$global:LOG_DIR = Join-Path $global:ROOT_DIR 'logs'
$global:SRC_DIR = Join-Path $global:ROOT_DIR 'src'
$global:CHOCO_DIR = Join-Path $global:SRC_DIR 'choco'
$global:CONFIG_DIR = Join-Path $global:SRC_DIR 'config'

# logging
$global:LOG_FILE_NAME = "$([DateTime]::Now.ToString('yyyy-MM-dd_hh-mm-ss'))_log.txt"
$global:LOG_FILE_PATH = Join-Path $global:LOG_DIR $global:LOG_FILE_NAME

$global:IS_ISE = $host.Name -like '*ISE*'

function New-Directory
{
    param(
        [string]$Path
    )

    if (Test-Path $Path) { return }

    New-Item $Path -ItemType | Out-Null
}

function Wait-Repsonse
{
    # ISE does not support readkey
    if ($global:IS_ISE) {
        Write-Host "Press ENTER to continue..." -NoNewline
        Read-Host
        return
    }

    # prompt user for response
    Write-Host "Press any key to continue..." -NoNewline
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
}

function Start-Logging
{
    # configure and start logging
    if (!(Test-Path $global:LOG_DIR))
    {
        New-Item $global:LOG_DIR -ItemType Directory | Out-Null
    }

    if ($PSEdition -eq 'Core') {
        Start-Transcript -Path $global:LOG_FILE_PATH -UseMinimalHeader
    }
    else {
        Start-Transcript -Path $global:LOG_FILE_PATH
    }
}

function Stop-Logging
{
    Write-Host ""
    Write-Host "Done! " -ForegroundColor Green -NoNewline
    Write-Host "The full transcript can be viewed in the logs directory in the file named '" -NoNewline
    Write-Host "$logFileName" -ForegroundColor Cyan -NoNewline
    Write-Host "'."

    Stop-Transcript

    Wait-Repsonse
}