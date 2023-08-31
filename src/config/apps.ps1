# if running in powershell core, import the appx module using the -UseWindowsPowershell switch
if ($PSEdition -eq 'Core')
{
    Import-Module Appx -UseWindowsPowerShell
}

# will uninstall all of thes by default (comment items to leave installed)
$apps = @(
    '3DBuilder'
    'GetStarted'
    'king.com.CandyCrushSaga'
    'Microsoft.BingFinance'
    'Microsoft.BingNews'
    'Microsoft.BingSports'
    'Microsoft.BingWeather'
    'Microsoft.MicrosoftOfficeHub'
    'Microsoft.MicrosoftSolitaireCollection'
    'Microsoft.Office.OneNote'
    'Microsoft.People'
    'Microsoft.SkypeApp'
    'Microsoft.windowscommunicationsapps'
    'Microsoft.WindowsPhone'
    'Microsoft.WindowsSoundRecorder'
    'Microsoft.XboxApp'
    'Microsoft.ZuneMusic'
    'Microsoft.ZuneVideo'
)

$apps | ForEach-Object { Get-AppxPackage $_ | Remove-AppxPackage }
