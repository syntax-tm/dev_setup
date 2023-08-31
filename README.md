# dev_setup

This is a basic repo for developer machine setup including software installs, Windows settings, File Explorer preferences, and more.

## Setup

### Softare Installs (choco)

Software installs are done using [Chocolatey](https://community.chocolatey.org/). To configure the installs there are powershell scripts in `src\choco`. The `all.ps1` script is the first script executed and is responsible for installing Chocolatey and then executing the other install scripts. Packages are semi-organized into files so that it's easier to find everything.

Some popular software is already in the scripts and commented out by default. If you want to install anything that's already there just uncomment that line.

**Before:**

`# choco install notepadplusplus`

**After:**

`choco install notepadplusplus`

#### Adding Packages

If you want to look at all available packages or search for something specific you can do so [here](https://community.chocolatey.org/packages).

### Configuration

The `src\config` directory contains scripts that configure File Explorer settings, Windows Updates, mouse settings, and more. Most of the configuration is done via the registry. If you wish to skip any of these changes, simply comment out the line (`#` in powershell). You can either comment the individual setting or the entire script by commenting it out in the `dev_setup.ps1` script in the project root.

## Usage

```ps1
.\dev_setup.ps1
```

## Additional Info

I put this together fairly quickly using my own personal scripts I use to setup my development machines and I tried to make it easy-ish for someone to make their own. Before running `dev_setup.ps1` be sure to look through the scripts in `src` and be sure to add (uncomment) or remove (comment) anything based on your preference. The software that's installed by default (`git`, `vscode`, etc.) is just that, the default. The configuration settings are also just user preference and if you say, want to hide file extensions for whatever reason, then you might want to comment that line out in the `explorer.ps1` script.
