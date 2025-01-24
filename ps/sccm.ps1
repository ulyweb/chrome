# This script requires Run as Administrator
# Save this script as SCCM.ps1

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
$logFile = "C:\reports\SCCM_update_log_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
if (-not (Test-Path "C:\reports")) {
    New-Item -ItemType Directory -Path "C:\reports" | Out-Null
}
Add-Content -Path $logFile -Value "Starting SCCM update script at $(Get-Date)"

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
# Prompt for the domain and username
$domain = Read-Host "Enter domain"
$username = Read-Host "Enter username"
$fullUsername = "$domain\$username"

# Run the command with the specified user
Start-Process -FilePath "powershell.exe" -ArgumentList "-Command `"Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command `"C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\Microsoft.ConfigurationManagement.exe`"' -Verb RunAs`"" -Credential $fullUsername
} catch {
    Log-Message "Failed to execute: $_"
}

Log-Message "Script completed at $(Get-Date)"
