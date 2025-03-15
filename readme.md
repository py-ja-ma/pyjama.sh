# 🛰️ Overview

This project provides a PowerShell-based setup for [BGInfo](https://docs.microsoft.com/en-us/sysinternals/downloads/bginfo), a tool that displays system information on the desktop background. The setup includes scripts for installation, fetching quotes, refreshing the background, and uninstalling the application.

Additionally, this project hosts a GitHub Pages website at [pyjama.sh](https://pyjama.sh) that displays a motivational quote each time the background is refreshed.

## 🍻 Features

- Downloads and installs BGInfo if not already present.
- Fetches a random motivational quote from a specified URL and sets it as an environment variable.
- Refreshes the desktop background with the latest configuration.
- Creates scheduled tasks to fetch quotes daily at 6 AM and refresh the background at user login.
- Provides an uninstall script to remove all changes made during setup.

## 🚀 Installation

To install BGInfo and set up the environment, run the following command in Admin PowerShell:

```powershell
irm "https://pyjama.sh/scripts/install.ps1" | iex
```


## 🌊 Refresh

To get your background to update outside the normal schedule / parameters run the following in PowerShell:

```powershell
irm "https://pyjama.sh/scripts/refresh.ps1" | iex
```


## 🗑️ Uninstal

To uninstall BGInfo and remove all related files, run the following command in Admin PowerShell:

```powershell
irm "https://pyjama.sh/scripts/uninstall.ps1" | iex
```

> PowerShell 7.5 doesn't remove the variables for some odd reason, I'd just use default windows PowerShell Admin for everything above.

## 💕 Contributing

Feel free to fork this repository and make improvements or modifications. If you have suggestions or find issues, please open an issue or submit a pull request.

## ©️ License

This project is open-source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- Inspired by the need for daily motivation and positivity.
- Thanks to all the contributors and the community for their support.
