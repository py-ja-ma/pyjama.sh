# 🛰️ Overview

This project provides a PowerShell-based setup for [BGInfo](https://learn.microsoft.com/en-us/sysinternals/downloads/bginfo), a tool that displays system information on the desktop background. The setup includes scripts for installation, fetching motivational quotes, refreshing the background, and uninstalling the application.

Additionally, this project hosts a GitHub Pages website at [pyjama.sh](https://pyjama.sh) that displays a motivational quote each time the site is refreshed.

---

## 🍻 Features

- Automatically downloads and installs BGInfo if it's not already available.
- Fetches a random motivational quote from a specified URL.
- Updates the desktop background with the latest quote.
- Sets up scheduled tasks to refresh quotes daily at 6 AM and at user login.
- Includes an uninstall script to remove all changes made during the setup.

---

## 🚀 Installation

To install BGInfo and configure the environment, execute the following command in **PowerShell 7** (pwsh) with Administrator privileges:

```powershell
irm "https://pyjama.sh/scripts/install.ps1" | iex
```

> **Note:** PowerShell 5 is not compatible with this script. Please install and use [PowerShell 7](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell) for optimal performance.

---

## 🌊 Refresh

To manually update your desktop background outside the scheduled tasks, run the following command in **PowerShell 7**:

```powershell
irm "https://pyjama.sh/scripts/refresh.ps1" | iex
```

---

## 🗑️ Uninstallation

To remove BGInfo and all related files, execute the following command in **PowerShell 7** with Administrator privileges:

```powershell
irm "https://pyjama.sh/scripts/uninstall.ps1" | iex
```

---

## 💕 Contributing

Contributions are welcome! Feel free to fork this repository to make improvements or modifications. If you encounter issues or have suggestions, please open an issue or submit a pull request.

---

## ©️ License

This project is open-source and licensed under the [MIT License](LICENSE).

---

## 🙏 Acknowledgments

- Inspired by the quest for daily motivation and positivity.
- Special thanks to all contributors and the broader community for their support.
