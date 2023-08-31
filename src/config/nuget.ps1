$path = Join-Path $env:APPDATA 'NuGet\nuget.config'

# make sure the config exists
if (!(Test-Path $path))
{
    return
}

# load config
[xml]$config = Get-Content -Path $path

# check if any sources containing api.nuget.org exist
$nugetOrgSource = Select-Xml -Xml $config -XPath '//packageSources/add[contains(@value, "api.nuget.org")]'
if ($null -ne $nugetOrgSource)
{
    return
}

# create nuget.org package source for v3 url
[System.Xml.XmlNode]$nugetSource = $config.CreateElement('add')
$nugetSource.SetAttribute('key', 'NuGet.org')
$nugetSource.SetAttribute('value', 'https://api.nuget.org/v3/index.json')

# prepend the nuget.org source
$packageSources = Select-Xml -Xml $config -XPath '//packageSources'
$packageSources.Node.PrependChild($nugetSource)

# save nuget.config
$config.Save($path)
