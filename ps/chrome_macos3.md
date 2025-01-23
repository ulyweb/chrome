If the script still isn’t working and the changes aren’t reflected in Chrome, there could be other issues at play. Let's troubleshoot step by step and ensure everything is configured correctly.

---

### 1. **Verify File Location and Permissions**

- **Location**: Confirm the file exists at `/Library/Managed Preferences/com.google.Chrome.plist`.
  ```bash
  ls -l /Library/Managed\ Preferences/com.google.Chrome.plist
  ```
  If the file doesn't exist here, try checking `/Library/Preferences/com.google.Chrome.plist` or `/Users/<username>/Library/Preferences/com.google.Chrome.plist`.

- **Permissions**: Ensure the file is owned by `root` and has the correct permissions.
  ```bash
  sudo chown root:wheel /Library/Managed\ Preferences/com.google.Chrome.plist
  sudo chmod 644 /Library/Managed\ Preferences/com.google.Chrome.plist
  ```

---

### 2. **Inspect the Current Keys and Values**

- Use the `defaults` command to read the plist file and confirm the current values of the keys:
  ```bash
  sudo defaults read /Library/Managed\ Preferences/com.google.Chrome.plist
  ```

- Look for the keys: `DownloadRestrictions`, `AutofillAddressEnabled`, `AutofillCreditCardEnabled`, `ImportAutofillFormData`, and `SyncDisabled`. Confirm their current values.

---

### 3. **Try Modifying the File with `defaults`**

If `PlistBuddy` isn’t working for some reason, you can use the `defaults` command to modify the plist file. For example:

```bash
sudo defaults write /Library/Managed\ Preferences/com.google.Chrome.plist DownloadRestrictions -int 0
sudo defaults write /Library/Managed\ Preferences/com.google.Chrome.plist AutofillAddressEnabled -bool true
sudo defaults write /Library/Managed\ Preferences/com.google.Chrome.plist AutofillCreditCardEnabled -bool true
sudo defaults write /Library/Managed\ Preferences/com.google.Chrome.plist ImportAutofillFormData -bool true
sudo defaults write /Library/Managed\ Preferences/com.google.Chrome.plist SyncDisabled -bool false
```

---

### 4. **Restart Chrome and Reload Policies**

- Restart Chrome completely (quit and reopen it).
- Go to `chrome://policy` and click **Reload Policies**.
- Check if the updated policies are reflected.

---

### 5. **Check for Configuration Conflicts**

If the plist file is being managed by an MDM (Mobile Device Management) solution, changes made manually might be overridden. Check if your MacBook is enrolled in an MDM:

- Open **System Settings** > **Privacy & Security** > **Profiles**.
- Look for any profiles that might manage Chrome settings.

---

### 6. **Force Chrome to Load Managed Preferences**

Sometimes Chrome may not automatically detect changes in the plist file. Force it to reload:

```bash
sudo killall -HUP cfprefsd
```

This command resets and reloads all preference files, ensuring the changes take effect.

---

### 7. **Debugging**

- If the problem persists, check Chrome’s logs to see if there are errors reading the plist:
  - Open `Console.app`.
  - Search for `Chrome` or `com.google.Chrome`.

- Confirm that Chrome is actually reading the plist from `/Library/Managed Preferences/`. If it's reading from another location, you’ll need to adjust accordingly.

---

### Let Me Know What You Find

If none of these steps work, share the output of the following commands, and I can help troubleshoot further:

1. Contents of the plist file:
   ```bash
   sudo defaults read /Library/Managed\ Preferences/com.google.Chrome.plist
   ```

2. Errors in the Console logs related to Chrome preferences.

We’ll figure this out! 😊
