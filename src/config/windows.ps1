# privacy
# -------

# don't let apps use your advertising id
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo' -Name 'Enabled' -Type DWord -Value 0
# disable smartscreen for store apps
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost' -Name 'EnableWebContentEvaluation' -Type DWord -Value 0
# disable activity tracking
@('EnableActivityFeed', 'PublishUserActivities', 'UploadUserActivities') | ForEach-Object { Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name $_ -Type DWord -Value 0 }
# disable telemetry
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0
Get-Service DiagTrack, Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

# wifi
# ----

# disable hotspot sharing
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting' -Name 'value' -Type DWord -Value 0
# disable wifi hotspot autoconnect
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots' -Name 'value' -Type DWord -Value 0
# disable bing search results in start menu
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Type DWord -Value 0

# windows
# -------

If (-Not (Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization')) {
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' -Name 'Personalization' | Out-Null
}
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' -Name 'NoLockScreen' -Type DWord -Value 1

# theme
# -----

# enables dark theme
If (-Not (Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize')) {
    New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes' -Name 'Personalize' | Out-Null
}
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -Type DWord -Value 0
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name 'AppsUseLightTheme' -Type DWord -Value 0

# updates
# -------

# changes windows update to notify to schedule restart (default is automatic)
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'UxOption' -Type DWord -Value 1

# keyboard
# --------

Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -Type String -Value '506'        # disable stickykeys
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name 'Flags' -Type String -Value '122' # disable filterkeys
Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\ToggleKeys' -Name 'Flags' -Type String -Value '58'         # disable togglekeys

# mouse
# -----

Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseSpeed' -Type String -Value '0'      # disables mouse precision
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold1' -Type String -Value '0' # disables mouse precision
Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name 'MouseThreshold2' -Type String -Value '0' # disables mouse precision

# cortana
# -------

Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' -Type DWord -Value 0 # disables cortana

# uac
# ---

Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin' -Value 0

