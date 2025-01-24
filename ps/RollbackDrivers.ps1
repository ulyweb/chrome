# Define the list of hardware IDs for the devices
$hardwareIDs = @(
    "INT3480",          # Intel(R) AVStream Camera
    "VEN_8086&DEV_7D45",# Intel(R) Graphics
    "HIMX",             # Camera Sensor HM1092
    "OVTI"              # Camera Sensor OV02E10
)

# Path to log actions
$logPath = "C:\DriverRestore\RestoreLog.txt"
$backupFolder = "C:\DriverBackup"

# Ensure log and backup folders exist
if (-not (Test-Path $backupFolder)) { New-Item -ItemType Directory -Path $backupFolder }
if (-not (Test-Path $logPath)) { New-Item -ItemType File -Path $logPath }

# Function to roll back driver
function Rollback-Driver {
    param (
        [string]$HardwareID
    )

    # Find the device associated with the hardware ID
    Write-Host "Processing Hardware ID: $HardwareID" -ForegroundColor Cyan
    Add-Content $logPath "Processing Hardware ID: $HardwareID"

    $deviceQuery = "SELECT * FROM Win32_PnPEntity WHERE DeviceID LIKE '%$HardwareID%'"
    $device = Get-WmiObject -Query $deviceQuery | Select-Object -First 1

    if ($null -eq $device) {
        Write-Warning "No device found for Hardware ID: $HardwareID"
        Add-Content $logPath "WARNING: No device found for Hardware ID: $HardwareID"
        return
    }

    # Get the device's current driver
    $instanceID = $device.DeviceID
    $driverQuery = "SELECT * FROM Win32_PnpSignedDriver WHERE DeviceID LIKE '%$instanceID%'"
    $driver = Get-WmiObject -Query $driverQuery | Select-Object -First 1

    if ($null -eq $driver) {
        Write-Warning "No driver found for Hardware ID: $HardwareID"
        Add-Content $logPath "WARNING: No driver found for Hardware ID: $HardwareID"
        return
    }

    # Uninstall the current driver
    Write-Host "Uninstalling driver for $HardwareID..."
    Add-Content $logPath "Uninstalling driver for $HardwareID..."

    $uninstallResult = & pnputil.exe /delete-driver $driver.InfName /uninstall /force
    Add-Content $logPath $uninstallResult

    # Reinstall the driver from the backup folder (if available)
    $backupDriver = Get-ChildItem -Path $backupFolder -Filter "*$HardwareID*" -Recurse | Select-Object -First 1
    if ($null -ne $backupDriver) {
        Write-Host "Reinstalling driver for $HardwareID from backup..."
        Add-Content $logPath "Reinstalling driver for $HardwareID from backup..."

        $reinstallResult = & pnputil.exe /add-driver $backupDriver.FullName /install
        Add-Content $logPath $reinstallResult
    } else {
        Write-Warning "No backup driver found for $HardwareID. Please restore manually."
        Add-Content $logPath "WARNING: No backup driver found for $HardwareID."
    }
}

# Iterate over all hardware IDs and roll back drivers
foreach ($hardwareID in $hardwareIDs) {
    Rollback-Driver -HardwareID $hardwareID
}

Write-Host "Driver rollback completed. Check the log file at $logPath for details." -ForegroundColor Green
