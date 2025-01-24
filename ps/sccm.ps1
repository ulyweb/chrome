# Define the path to the executable
$exePath = "C:\Program Files (x86)\Microsoft Configuration Manager\AdminConsole\bin\Microsoft.ConfigurationManagement.exe"

$adminUser = "$env:USERDOMAIN\a-$env:USERNAME"  # admin username

# Run the process as the specified admin user
Start-Process -FilePath "cmd.exe" -ArgumentList "/c runas /user:$adminUser `"$exePath`"" -NoNewWindow

