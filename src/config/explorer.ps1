# changes the explorer startup view to 'This PC'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Value 1

# configure view settings
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty -Path $key -Name 'Hidden' -Value 1                    # show hidden files
Set-ItemProperty -Path $key -Name 'HideFileExt' -Value 0               # show file extensions
Set-ItemProperty -Path $key -Name 'ShowSuperHidden' -Value 1           # show protected (system) files
Set-ItemProperty -Path $key -Name 'UseSharingWizard' -Value 0          # disable sharing wizard

# configure quick access
$key = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer'
Set-ItemProperty -Path $key -Name 'ShowRecent' -Type DWord -Value 0    # don't show recent files in quick access
Set-ItemProperty -Path $key -Name 'ShowFrequent' -Type DWord -Value 0  # don't show frequent folder sin quick access

# restart the explorer process to apply changes
Stop-Process -processname explorer