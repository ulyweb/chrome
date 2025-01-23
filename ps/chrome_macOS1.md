You're absolutely right—on macOS, applying Chrome policies isn't as straightforward as on Windows, where registry settings take effect immediately. Chrome policies on macOS rely on `.plist` files, but the **location** and **management** of these files differ. Let me walk you through the proper way to ensure that the policies, including enabling Chrome Sync, work as expected.

---

### Correct Approach for macOS Chrome Policies

1. **Location of Policy File**:
   The file controlling Chrome policies on macOS is typically located in:
   - `/Library/Managed Preferences/com.google.Chrome.plist`  
     (For managed system-wide policies)
   - Or `/Library/Preferences/com.google.Chrome.plist`  
     (For system-wide preferences).

2. **Editing the Policy File**:
   Policies are enforced by editing or creating the `.plist` file with the necessary keys. However, `defaults` command alone may not work reliably because Chrome expects its policies to be deployed in a specific way. Instead, the proper tool for this is `PlistBuddy`.

---

### Updated macOS Script Using `PlistBuddy`

Here’s a script to configure the same Chrome policies, including enabling Sync, using `PlistBuddy`:

```bash
#!/bin/bash

# Path to the Chrome policy plist file
PLIST_PATH="/Library/Managed Preferences/com.google.Chrome.plist"

# Ensure the plist file exists
if [ ! -f "$PLIST_PATH" ]; then
    sudo /usr/libexec/PlistBuddy -c "Save" "$PLIST_PATH"
fi

# Apply Chrome policies
sudo /usr/libexec/PlistBuddy -c "Set :DownloadRestrictions 0" "$PLIST_PATH" 2>/dev/null || sudo /usr/libexec/PlistBuddy -c "Add :DownloadRestrictions integer 0" "$PLIST_PATH"
sudo /usr/libexec/PlistBuddy -c "Set :AutofillAddressEnabled true" "$PLIST_PATH" 2>/dev/null || sudo /usr/libexec/PlistBuddy -c "Add :AutofillAddressEnabled bool true" "$PLIST_PATH"
sudo /usr/libexec/PlistBuddy -c "Set :AutofillCreditCardEnabled true" "$PLIST_PATH" 2>/dev/null || sudo /usr/libexec/PlistBuddy -c "Add :AutofillCreditCardEnabled bool true" "$PLIST_PATH"
sudo /usr/libexec/PlistBuddy -c "Set :ImportAutofillFormData true" "$PLIST_PATH" 2>/dev/null || sudo /usr/libexec/PlistBuddy -c "Add :ImportAutofillFormData bool true" "$PLIST_PATH"
sudo /usr/libexec/PlistBuddy -c "Set :SyncDisabled false" "$PLIST_PATH" 2>/dev/null || sudo /usr/libexec/PlistBuddy -c "Add :SyncDisabled bool false" "$PLIST_PATH"

# Notify user
echo "Chrome policies have been updated. Please restart Chrome for the changes to take effect."
```

---

### Key Updates in the Script:
1. **Using `PlistBuddy`**:
   - The `PlistBuddy` tool is more reliable for managing `.plist` files compared to `defaults`.
   - It ensures that the keys are created if they don’t exist.

2. **Policy Keys**:
   - `DownloadRestrictions`: Set to `0` (unrestricted downloads).
   - `AutofillAddressEnabled`: Set to `true` (enable address autofill).
   - `AutofillCreditCardEnabled`: Set to `true` (enable credit card autofill).
   - `ImportAutofillFormData`: Set to `true` (enable importing autofill data).
   - `SyncDisabled`: Set to `false` (enable Chrome Sync).

3. **Plist Path**:
   - The script targets `/Library/Managed Preferences/com.google.Chrome.plist`, which Chrome reads for managed settings. If this file doesn’t exist, it creates one.

---

### Final Steps:
1. **Restart Chrome**:
   After running the script, restart Chrome to load the new policies.

2. **Verify Policies**:
   You can verify the applied policies using the following command:
   ```bash
   sudo defaults read /Library/Managed Preferences/com.google.Chrome.plist
   ```

---

### Why `defaults` Didn't Work:
- Chrome reads its managed policies only from certain paths, like `/Library/Managed Preferences/`.
- The `defaults` command often creates keys in the wrong file or format, which Chrome doesn't recognize.

---

Let me know how this works for you!
