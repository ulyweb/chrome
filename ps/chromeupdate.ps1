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

    # Enable Chrome sync
    New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "SyncDisabled" -PropertyType DWord -Value 0 -Force
    Log-Message "Chrome sync has been enabled."
} catch {
    Log-Message "Failed to update registry keys: $_"
}

Log-Message "Script completed at $(Get-Date)"
