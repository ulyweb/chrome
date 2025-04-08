# This script requires Run as Administrator
# Save this script as chromeupdate.ps1

# Function to check for Administrator privileges
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Check for Administrator privileges
if (-not (Test-Administrator)) {
    Write-Host "This script requires running as Administrator."
    exit
}

# Log file setup
$logFile = "C:\reports\chrome_update_log_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
if (-not (Test-Path "C:\reports")) {
    New-Item -ItemType Directory -Path "C:\reports" | Out-Null
}
Add-Content -Path $logFile -Value "Starting Chrome update script at $(Get-Date)"

# Function to log and write to console
function Log-Message {
    param (
        [string]$message
    )
    Write-Host $message
    Add-Content -Path $logFile -Value $message
}

# Update registry keys
try {
    Log-Message "Updating registry keys for Chrome updates and downloads..."

    # Enable automatic updates
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Update" -Name "AutoUpdateCheckPeriodMinutes" -PropertyType DWord -Value 1 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Update" -Name "Install{8A69D345-D564-463C-AFF1-A69D9E530F96}" -PropertyType DWord -Value 1 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Update" -Name "Update{8A69D345-D564-463C-AFF1-A69D9E530F96}" -PropertyType DWord -Value 1 -Force
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "DisableSafeBrowsing" -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "BlockThirdPartyCookies" -ErrorAction SilentlyContinue
    Log-Message "Chrome auto-update settings updated."

    # Ensure downloads are unrestricted
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "DownloadRestrictions" -PropertyType DWord -Value 0 -Force
    Log-Message "Chrome downloads are now unrestricted (DownloadRestrictions set to 0)."

    # Enable autofill for addresses, credit cards, and form data
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "AutofillAddressEnabled" -PropertyType DWord -Value 1 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "AutofillCreditCardEnabled" -PropertyType DWord -Value 1 -Force
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "ImportAutofillFormData" -PropertyType DWord -Value 1 -Force
    Log-Message "Chrome autofill for addresses, credit cards, and form data has been enabled."


    # Enable Chrome sync
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "SyncDisabled" -PropertyType DWord -Value 0 -Force
    Log-Message "Chrome sync has been enabled."

# These line are designed for Microsoft Edge Browser
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "SyncDisabled" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "PasswordManagerEnabled" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "PasswordMonitorAllowed" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "SyncTypesListDisabled" -PropertyType String -Value "" -Force
# Enable "Save and fill basic info" (required to unlock ML autofill toggle)
New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Edge" -Name "AutofillAddressEnabled" -Value 1 -PropertyType DWord -Force

# Enable "Save and fill basic info" (personal data)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "AutofillAddressEnabled" -Value 1 -PropertyType DWord -Force

# Enable ML-powered suggestions (if available in your Edge version)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "AutofillPredictionsEnabled" -Value 1 -PropertyType DWord -Force

# Enable "Save and fill payment info" (credit cards)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "AutofillCreditCardEnabled" -Value 1 -PropertyType DWord -Force

# Allow credit card sync across devices (requires signed-in Microsoft account)
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "PaymentMethodQueryEnabled" -Value 1 -PropertyType DWord -Force
    Log-Message "Microsoft Edge sync has been enabled."

    
} catch {
    Log-Message "Failed to update registry keys: $_"
}

Log-Message "Script completed at $(Get-Date)"
