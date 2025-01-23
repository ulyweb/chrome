The reason the script doesn't work on your **MacBook Pro** running macOS is that the registry-based approach used in the script is specific to **Windows**. On macOS, Chrome's policies are managed differently, as macOS doesn't have a Windows-style registry.

### How Chrome Policies Work on macOS
On macOS, Chrome policies are managed using **configuration profiles** or **.plist files** (Property List files). These files are typically located in `/Library/Managed Preferences/` or `/Library/Google/`.

For Chrome policies on macOS:
1. The main policy file is stored as a `.plist` file at:
   - `/Library/Google/Google Chrome Master Preferences`
   - Or `/Library/Preferences/com.google.Chrome.plist`

2. You can configure Chrome policies using:
   - A **mobile device management (MDM) solution** (for enterprise environments).
   - Directly editing or creating the necessary `.plist` files.

---

### How to Apply the Same Policies on macOS
To replicate the behavior of your script, you need to update or create the `com.google.Chrome.plist` file with the corresponding policies. Here's how you can do it:

#### Step 1: Locate or Create the `com.google.Chrome.plist` File
The file should be located at `/Library/Preferences/com.google.Chrome.plist`. If it doesn’t exist, you can create it.

#### Step 2: Use `defaults` Command to Apply Policies
On macOS, you can use the `defaults` command to update the plist. Below is the equivalent of your PowerShell script for macOS:

````
# Enable downloads, autofill, and Chrome Sync settings for Chrome on macOS
sudo defaults write /Library/Preferences/com.google.Chrome DownloadRestrictions -int 0
sudo defaults write /Library/Preferences/com.google.Chrome AutofillAddressEnabled -bool true
sudo defaults write /Library/Preferences/com.google.Chrome AutofillCreditCardEnabled -bool true
sudo defaults write /Library/Preferences/com.google.Chrome ImportAutofillFormData -bool true
sudo defaults write /Library/Preferences/com.google.Chrome SyncDisabled -bool false

# Restart Chrome to apply changes
echo "Chrome policies have been updated. Please restart Chrome to apply the changes."
````

---

#### Step 3: Restart Chrome
After making changes to the plist, you’ll need to restart Chrome for the policies to take effect.

---

### Notes
1. **Permissions**: Since you’re modifying system-wide preferences, you’ll need to run the commands with `sudo` to gain elevated privileges.
2. **Testing**: You can verify the changes by checking the current preferences:
   ```bash
   defaults read /Library/Preferences/com.google.Chrome
   ```
3. **Manual Editing**: You can also manually edit the plist file using a text editor or a property list editor like Xcode.

---

If you're using a **mobile device management (MDM)** tool to manage your Mac, you can deploy these settings as part of a configuration profile. Let me know if you'd like guidance on creating or deploying configuration profiles!
