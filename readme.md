# 🏡 pyjama.sh

This project provides a simple way to display inspirational quotes on your desktop wallpaper using PowerShell scripts. The quotes are fetched from a text file hosted on a web server, and the script updates the quote each time you log in.

## 🚩 Features

- Fetches random quotes from a hosted `quotes.txt` file.
- Saves the selected quote to a local text file.
- Displays the quote on your desktop using a message box (or any other method you prefer).
- Easy to set up and use.

## ✅ Prerequisites

- Windows operating system.
- PowerShell (comes pre-installed on Windows).
- Internet access to fetch quotes from the web.

## 👟 Setup Instructions

1. **Clone the Repository**: Clone this repository to your local machine using Git or download it as a ZIP file.

   ```bash
   git clone https://github.com/pjdotdev/pyjama.sh
   ```

2. **Create the Quotes File**: Create a `quotes.txt` file in the root of your repository (or on your web server) and populate it with inspirational quotes in the following format:

   ```
   "Quote text" – Author Name
   ```

   Example:
   ```
   "Leadership is not about being in charge. It is about taking care of those in your charge." – Simon Sinek
   ```

3. **Edit the PowerShell Script**: Open the `fetch.ps1` script and update the `$quotesUrl` variable to point to the location of your `quotes.txt` file.

   ```powershell
   $quotesUrl = "https://pyjama.sh/quotes.txt"  # Replace with the actual URL
   ```

4. **Run the Script**: You can run the script manually or set it to run at startup.

   To run the script manually, open PowerShell and execute:

   ```powershell
   irm "https://pyjama.sh/fetch.ps1" | iex
   ```

5. **Set Up Automatic Execution**: To run the script automatically at login, you can create a scheduled task or add a shortcut to the script in the Startup folder.

   - **Using Task Scheduler**:
     - Open Task Scheduler and create a new task that runs the PowerShell script at logon.
   - **Using Startup Folder**:
     - Create a shortcut to the script and place it in the Startup folder (`shell:startup`).

## Customization

- You can customize how the quote is displayed by modifying the `bg_info.ps1` script. For example, you can replace the message box with a method to update your desktop wallpaper or use a tool like BGInfo to display the quote on your desktop background.

## Contributing

Feel free to fork this repository and make improvements or modifications. If you have suggestions or find issues, please open an issue or submit a pull request.

## License

This project is open-source and available under the [MIT License](LICENSE).

## Acknowledgments

- Inspired by the need for daily motivation and positivity.
- Thanks to all the contributors and the community for their support.

---

Feel free to reach out if you have any questions or need assistance!
```

### Instructions for Use

1. **Replace Placeholder Text**: Make sure to replace `yourusername` and `your-repo-name` with your actual GitHub username and repository name. Also, update the URL in the script section to point to your actual hosted `quotes.txt` file.

2. **Add Additional Sections**: You can add more sections if needed, such as troubleshooting tips, FAQs, or examples of how to customize the script further.

3. **Formatting**: Ensure that the formatting is preserved when you create the README file in your repository. Markdown files are typically named `README.md`.

This README should provide a clear and concise guide for users who want to set up and use your inspirational quotes background updater.