

# Ensure the registry path exists first
if (-not (Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Force | Out-Null
}

# Set Edge policies for automatic sign-in and sync
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "BrowserSignin" -Value 1 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge" -Name "ForceSync" -Value 1 -PropertyType DWord -Force



# Getting info only
# Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Edge"

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
